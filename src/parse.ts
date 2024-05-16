import { snakeCase } from './snake';

import {
  parse as parseDocument,
  Kind,
  type ObjectTypeDefinitionNode,
  // type InterfaceTypeDefinitionNode, // FIXME: Unused type. Can we remove this?
  type EnumTypeDefinitionNode,
  type DocumentNode,
  type TypeDefinitionNode,
  type FieldDefinitionNode,
  type TypeNode,
  type NamedTypeNode,
  type ListTypeNode,
  type ConstDirectiveNode,
  type ConstValueNode,
  type ConstObjectValueNode,
  type InterfaceTypeDefinitionNode
} from 'graphql';

import {
  type Column,
  TypeKind,
  type ScalarType,
  type EnumType,
  type ReferenceType,
  type ListType,
  type Relation,
  type Table,
  type Layout
} from './layout';
import { DBType, type IdType } from './db';
import {
  DERIVED_FROM_DIRECTIVE_NAME,
  FULLTEXT_DIRECTIVE_NAME,
  ID_FIELD_NAME,
  SCHEMA_TYPE_NAME,
  VIRTUAL_ID_COLUMN_NAME,
  BLOCK_RANGE_COLUMN_NAME,
  BLOCK_COLUMN_NAME,
  isDerivedField,
  isImmutableEntity
} from './graph';

const PrimaryKeyColumn: Column = {
  type: { kind: TypeKind.Scalar, dbType: DBType.BigSerial },
  isPrimary: true,
  nullable: false
};

const BlockRangeColumn: Column = {
  type: { kind: TypeKind.Scalar, dbType: DBType.Int4Range },
  isPrimary: false,
  nullable: false
};

const BlockColumn: Column = {
  type: { kind: TypeKind.Scalar, dbType: DBType.Integer },
  isPrimary: false,
  nullable: false
};

interface ImplementationTypeNode extends InterfaceTypeDefinitionNode {
  references: string[];
}

interface Schema {
  objects: Map<string, ObjectTypeDefinitionNode | ImplementationTypeNode>;
  enums: Map<string, EnumTypeDefinitionNode>;
  fulltext: Map<string, Map<string, Column>>;
}

function parseDBType(fieldType: NamedTypeNode): DBType | undefined {
  switch (fieldType.name.value) {
    case 'ID':
      return DBType.Text;
    case 'Boolean':
      return DBType.Boolean;
    case 'BigInt':
      return DBType.Numeric;
    case 'Bytes':
      return DBType.Bytea;
    case 'BigDecimal':
      return DBType.Numeric;
    case 'Int':
      return DBType.Integer;
    case 'Int8':
      return DBType.Int8;
    case 'String':
      return DBType.Text;
    default:
      return undefined;
  }
}

function parseIDType(fieldType: TypeNode): IdType {
  if (fieldType.kind !== Kind.NON_NULL_TYPE) {
    throw new Error(`ID field must be a non-nullable type.`);
  }

  fieldType = fieldType.type;

  if (fieldType.kind !== Kind.NAMED_TYPE) {
    throw new Error(`ID field must be ID, Bytes, Int8 or String type.`);
  }

  switch (fieldType.name.value) {
    case 'ID':
      return DBType.Text;
    case 'Bytes':
      return DBType.Bytea;
    case 'Int8':
      return DBType.Int8;
    case 'String':
      return DBType.Text;
    default:
      throw new Error(`ID field must be ID, Bytes, Int8 or String type.`);
  }
}

function parseScalarType(fieldType: NamedTypeNode): ScalarType | undefined {
  const dbType = parseDBType(fieldType);
  return dbType !== undefined ? { kind: TypeKind.Scalar, dbType } : undefined;
}

function parseEnumType(fieldType: NamedTypeNode, schema: Schema): EnumType | undefined {
  const target = schema.enums.get(fieldType.name.value);

  if (target === undefined) {
    return undefined;
  }

  return { kind: TypeKind.Enum, name: snakeCase(target.name.value) };
}

function parseReferenceType(fieldType: NamedTypeNode, schema: Schema): ReferenceType | undefined {
  if (schema.objects.has(fieldType.name.value)) {
    const target = schema.objects.get(fieldType.name.value);

    if (target === undefined) {
      return undefined;
    }

    const id_field_type = target?.fields?.find((field) => field.name.value === ID_FIELD_NAME)?.type;

    if (id_field_type === undefined) {
      throw new Error(
        `Reference entity ${fieldType.name.value} must have a ${ID_FIELD_NAME} field`
      );
    }
    const dbType = parseIDType(id_field_type);

    const tables =
      target.kind === Kind.OBJECT_TYPE_DEFINITION
        ? [snakeCase(target.name.value)]
        : target.references.map((ref) => snakeCase(ref));

    return { kind: TypeKind.Reference, tables, column: ID_FIELD_NAME, dbType };
  }

  return undefined;
}

function parseNamedType(
  fieldType: NamedTypeNode,
  schema: Schema
): ScalarType | EnumType | ReferenceType {
  const type =
    parseScalarType(fieldType) ||
    parseReferenceType(fieldType, schema) ||
    parseEnumType(fieldType, schema);

  if (type !== undefined) {
    return type;
  }

  throw new Error(`Item type of the list must be a scalar or enum type.`);
}

function parseListType(fieldType: ListTypeNode, schema: Schema): ListType {
  const nullable = fieldType.type.kind !== Kind.NON_NULL_TYPE;
  const item_type = nullable ? fieldType.type : fieldType.type.type;

  if (item_type.kind !== Kind.NAMED_TYPE) {
    throw new Error(`Item type of the list must be a known/named type.`);
  }

  const itemType = parseNamedType(item_type, schema);

  return { kind: TypeKind.List, itemType };
}

function parseColumn(field: FieldDefinitionNode, schema: Schema): [string, Column] {
  const name = snakeCase(field.name.value);
  const description = field.description?.value;

  if (name === ID_FIELD_NAME) {
    const dbType = parseIDType(field.type);
    return [
      name,
      {
        type: { kind: TypeKind.Scalar, dbType },
        nullable: false,
        description,
        isPrimary: false
      }
    ];
  }

  const nullable = field.type.kind !== Kind.NON_NULL_TYPE;
  const fieldType = nullable ? field.type : field.type.type;

  const type =
    fieldType.kind === Kind.LIST_TYPE
      ? parseListType(fieldType, schema)
      : parseNamedType(fieldType, schema);

  return [name, { type, isPrimary: false, nullable, description }];
}

function parseRelation(field: FieldDefinitionNode): Relation {
  const name = snakeCase(field.name.value);

  let table_type = field.type.kind !== Kind.NON_NULL_TYPE ? field.type : field.type.type;

  const type = table_type.kind === Kind.NAMED_TYPE ? 'one' : 'many';

  if (table_type.kind === Kind.LIST_TYPE) {
    table_type =
      table_type.type.kind !== Kind.NON_NULL_TYPE ? table_type.type : table_type.type.type;
  }

  if (table_type.kind !== Kind.NAMED_TYPE) {
    throw new Error(`Relation field must be a (list) non-nullable known/named type.`);
  }

  const table = snakeCase(table_type.name.value);

  const derivedFrom = field.directives?.find(
    (dir) => dir.name.value === DERIVED_FROM_DIRECTIVE_NAME
  );

  if (derivedFrom === undefined) {
    throw new Error(`Relation field must have a derivedFrom directive.`);
  }

  const column = snakeCase(parseOjectField(derivedFrom, 'field', Kind.STRING));

  return { name, table, column, type };
}

function parseTable(table: ObjectTypeDefinitionNode, schema: Schema): [string, Table] {
  const name = snakeCase(table.name.value);

  const columns: Map<string, Column> = new Map();

  if (isImmutableEntity(table)) {
    columns.set(BLOCK_COLUMN_NAME, BlockColumn);
  } else {
    columns.set(BLOCK_RANGE_COLUMN_NAME, BlockRangeColumn);
  }

  columns.set(VIRTUAL_ID_COLUMN_NAME, PrimaryKeyColumn);

  for (const [column_name, column] of schema.fulltext.get(name)?.entries() || []) {
    columns.set(column_name, column);
  }

  table.fields
    ?.filter((field) => !isDerivedField(field))
    .map((field) => parseColumn(field, schema))
    .forEach(([name, column]) => columns.set(name, column));

  const relations: Map<string, Relation[]> = new Map();

  relations.set(
    ID_FIELD_NAME,
    table.fields?.filter((field) => isDerivedField(field)).map(parseRelation) || []
  );

  return [
    name,
    {
      columns,
      relations
    }
  ];
}

export function parseEnum(enum_type: EnumTypeDefinitionNode): [string, string[]] {
  const name = snakeCase(enum_type.name.value);
  const values = enum_type.values?.map((value) => value.name.value) || [];
  return [name, values];
}

function parseOjectField(
  obj: ConstDirectiveNode | ConstObjectValueNode,
  name: string,
  kind: Kind.ENUM | Kind.STRING
): string {
  let field: ConstValueNode | undefined = undefined;

  if (obj.kind === Kind.DIRECTIVE) {
    field = obj.arguments?.find((arg) => arg.name.value === name)?.value;
  } else if (obj.kind === Kind.OBJECT) {
    field = obj.fields?.find((field) => field.name.value === name)?.value;
  }

  if (field === undefined) {
    throw new Error(`Argument ${name} is required for full text search column.`);
  }

  if (field.kind === kind) {
    return field.value;
  } else {
    throw new Error(`Argument ${name} must be a ${kind} for full text search column.`);
  }
}

function parseFullTextDirective(directive: ConstDirectiveNode): [string, string, Column] {
  const column_name = snakeCase(parseOjectField(directive, 'name', Kind.STRING));
  const language = parseOjectField(directive, 'language', Kind.ENUM);
  const algorithm = parseOjectField(directive, 'algorithm', Kind.ENUM);

  const include = directive.arguments?.find((arg) => arg.name.value === 'include')?.value;
  if (include === undefined || include.kind !== Kind.LIST || include.values.length !== 1) {
    throw new Error(
      `Argument include must be an array with single entity for full text search column.`
    );
  }

  const item = include.values.at(0);
  if (item === undefined || item.kind !== Kind.OBJECT) {
    throw new Error(
      `Argument include must be an array with single entity for full text search column.`
    );
  }

  const table_name = snakeCase(parseOjectField(item, 'entity', Kind.STRING));

  const fields = item.fields?.find((field) => field.name.value === 'fields')?.value;

  if (fields === undefined || fields.kind !== Kind.LIST) {
    throw new Error(`Argument include must be a list of strings for full text search column.`);
  }

  const columns = fields.values.map((value) => {
    if (value.kind !== Kind.OBJECT) {
      throw new Error(`Argument include must be a list of strings for full text search column.`);
    }
    return snakeCase(parseOjectField(value, 'name', Kind.STRING));
  });

  return [
    table_name,
    column_name,
    {
      type: {
        kind: TypeKind.TextSearch,
        dbType: DBType.TextSearch,
        language,
        algorithm,
        columns
      },
      isPrimary: false,
      nullable: true
    }
  ];
}

/**
 * Parses GraphQL schema into a database layout
 * @param raw string containing valid GraphQL schema
 * @returns database layout
 */
export function parse(raw: string): Layout {
  const document = parseDocument(raw);

  const objects: Map<string, ObjectTypeDefinitionNode | ImplementationTypeNode> = new Map();
  const enums: Map<string, EnumTypeDefinitionNode> = new Map();
  const fulltext: Map<string, Map<string, Column>> = new Map();

  document.definitions.forEach((def) => {
    if (def.kind === Kind.OBJECT_TYPE_DEFINITION) {
      const obj = def as ObjectTypeDefinitionNode;
      objects.set(obj.name.value, obj);
      if (obj.name.value === SCHEMA_TYPE_NAME) {
        obj.directives
          ?.filter((dir) => dir.name.value === FULLTEXT_DIRECTIVE_NAME)
          .map(parseFullTextDirective)
          .forEach(([table_name, column_name, column]) => {
            if (fulltext.has(table_name)) {
              fulltext.get(table_name)?.set(column_name, column);
            } else {
              fulltext.set(table_name, new Map([[column_name, column]]));
            }
          });
      }
    } else if (def.kind === Kind.ENUM_TYPE_DEFINITION) {
      const obj = def as EnumTypeDefinitionNode;
      enums.set(obj.name.value, obj);
    } else if (def.kind === Kind.INTERFACE_TYPE_DEFINITION) {
      const obj = def as ImplementationTypeNode;
      obj.references = document.definitions
        .filter(
          (def) =>
            def.kind === Kind.OBJECT_TYPE_DEFINITION &&
            def.interfaces &&
            def.interfaces.some((impl) => impl.name.value === obj.name.value)
        )
        .map((def) => def as ObjectTypeDefinitionNode)
        .map((def) => def.name.value);
      objects.set(obj.name.value, obj);
    }
  });

  //Hashmaps to easily access schema objects
  const schema: Schema = {
    objects,
    enums,
    fulltext
  };

  // Parse graphql enum objects into database enums
  const layout_enums: Map<string, string[]> = new Map();

  for (const [name, value] of schema.enums.entries()) {
    const [enum_name, enum_values] = parseEnum(value);
    layout_enums.set(enum_name, enum_values);
  }

  const layout_tables = new Map<string, Table>();

  for (const [name, value] of schema.objects.entries()) {
    if (name !== SCHEMA_TYPE_NAME && value.kind === Kind.OBJECT_TYPE_DEFINITION) {
      const [table_name, table_value] = parseTable(value, schema);
      layout_tables.set(table_name, table_value);
    }
  }

  return {
    tables: layout_tables,
    enums: layout_enums
  };
}
