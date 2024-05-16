import * as assert from 'assert';

import { parse } from '../src/parse';
import { VIRTUAL_ID_COLUMN_NAME, BLOCK_RANGE_COLUMN_NAME, ID_FIELD_NAME } from '../src/graph';
import { EnumType, ReferenceType, ScalarType, TextSearchType, TypeKind } from '../src/layout';
import { DBType } from '../src/db';
import { readFileSync } from 'fs';
import path from 'path';

describe('basic', () => {
  const simple_schema = `
    type SomeComplexTableErc20Name  @entity {
        "Some description about a string field"
        id: ID!,
        nullableField:Boolean,
        booleanField:Boolean!,
        bigIntField:BigInt!,
        bytesField:Bytes!,
        bigDecimalField:BigDecimal!,
        intField:Int!,
        int8Field:Int8!,
        stringField:String!
    }
`;

  const layout = parse(simple_schema);

  test('single table parsed', () => expect(layout.tables.size).toBe(1));

  const table = layout.tables.get('some_complex_table_erc_20_name');

  test('table name is snake case', () => expect(table).toBeDefined());
  test('column count is 11', () => expect(table!.columns.size).toBe(11));

  describe('vid pk column', () => {
    const column = table!.columns.get(VIRTUAL_ID_COLUMN_NAME);
    test('is defined', () => expect(column).toBeDefined());
    test('is primary key', () => expect(column!.isPrimary).toBeTruthy());
    test('type is `ScalarType`', () => expect(column!.type.kind).toBe(TypeKind.Scalar));
    test('db type is `bigserial`', () =>
      expect((column?.type as ScalarType).dbType).toBe(DBType.BigSerial));
    test('is not nullable', () => expect(column?.nullable).toBeFalsy());
  });

  describe('block range column', () => {
    const column = table!.columns.get(BLOCK_RANGE_COLUMN_NAME);
    test('is defined', () => expect(column).toBeDefined());
    test('is not primary key', () => expect(column!.isPrimary).toBeFalsy());
    test('type is `ScalarType`', () => expect(column!.type.kind).toBe(TypeKind.Scalar));
    test('db type is `int4range`', () =>
      expect((column?.type as ScalarType).dbType).toBe(DBType.Int4Range));
    test('is not nullable', () => expect(column!.nullable).toBeFalsy());
  });

  describe('id column', () => {
    const column = table!.columns.get(ID_FIELD_NAME);
    test('is defined', () => expect(column).toBeDefined());
    test('is not primary key', () => expect(column!.isPrimary).toBeFalsy());
    test('type is `ScalarType`', () => expect(column!.type.kind).toBe(TypeKind.Scalar));
    test('db type is `Text`', () => expect((column!.type as ScalarType).dbType).toBe(DBType.Text));
    test('is not nullable', () => expect(column!.nullable).toBeFalsy());
  });

  describe('nullable column', () => {
    const column = table!.columns.get('nullable_field');
    test('is defined', () => expect(column).toBeDefined());
    test('is nullable', () => expect(column?.nullable).toBeTruthy());
  });

  const scalar_columns: { name: string; expected: DBType }[] = [
    { name: 'boolean_field', expected: DBType.Boolean },
    { name: 'big_int_field', expected: DBType.Numeric },
    { name: 'bytes_field', expected: DBType.Bytea },
    { name: 'big_decimal_field', expected: DBType.Numeric },
    { name: 'int_field', expected: DBType.Integer },
    { name: 'int_8_field', expected: DBType.Int8 },
    { name: 'string_field', expected: DBType.Text }
  ];

  describe.each(scalar_columns)(`scalar columns`, (config) => {
    const column = table!.columns.get(config.name);
    test('is defined', () => expect(column).toBeDefined());
    test('type is `ScalarType`', () => expect(column!.type.kind).toBe(TypeKind.Scalar));
    test('db type is correct', () =>
      expect((column!.type as ScalarType).dbType).toBe(config.expected));
  });
});

describe('enum', () => {
  const enum_schema = `
    enum SomeComplexNamedErc20 {
        A
        B
        C
    }

    type SomeEnumTable @entity {
        id: ID!,
        enumField:SomeComplexNamedErc20!
    }
`;

  const expected_enum_name = 'some_complex_named_erc_20';
  const expected_table_name = 'some_enum_table';

  const layout = parse(enum_schema);

  test('is parsed', () => expect(layout.enums.size).toBe(1));
  test('name is `some_complex_named_erc_20`', () =>
    expect(layout.enums.has(expected_enum_name)).toBeTruthy());

  const enum_column = layout.tables.get(expected_table_name)!.columns.get('enum_field')!;

  test('column type is `EnumType`', () => expect(enum_column.type.kind).toBe(TypeKind.Enum));
  test('column enum name is `some_complex_named_erc_20`', () =>
    expect((enum_column.type as EnumType).name).toBe(expected_enum_name));
});

describe('relation', () => {
  const relation_schema = `
    type SomeRelationParentTable @entity {
        id: ID!,
        children: [SomeRelationChildTable!]! @derivedFrom(field: "parentField")
    }

    type SomeRelationChildTable @entity {
        id: ID!,
        parentField: SomeRelationParentTable!
    }

	type SomeOneToOneRelationParentTable @entity {
		id: ID!,
		child: SomeRelationChildTable @derivedFrom(field: "parentField")
	}

`;

  const layout = parse(relation_schema);
  const expected_parent_table_name = 'some_relation_parent_table';
  const expected_child_table_name = 'some_relation_child_table';
  const expected_one_to_one_parent_table_name = 'some_one_to_one_relation_parent_table';

  test('tables are parsed', () => expect(layout.tables.size).toBe(3));

  const relations = layout.tables.get(expected_parent_table_name)!.relations.get(ID_FIELD_NAME)!;

  test('parent to child is parsed', () => expect(relations.length).toBe(1));
  test('parent to child name is `children`', () => expect(relations[0].name).toBe('children'));
  test('parent to child table name is `some_relation_child_table`', () =>
    expect(relations[0].table).toBe(expected_child_table_name));
  test('parent to child column name is `parent_field`', () =>
    expect(relations[0].column).toBe('parent_field'));
  test('parent to child rel type is `many`', () => expect(relations[0].type).toBe('many'));

  const one_to_one_relations = layout.tables
    .get(expected_one_to_one_parent_table_name)!
    .relations.get(ID_FIELD_NAME)!;

  test('one to one rel type is `one`', () => expect(one_to_one_relations[0].type).toBe('one'));

  const ref_type = layout.tables.get(expected_child_table_name)!.columns.get('parent_field')!.type;

  test('child to parent column type is `ReferenceType`', () =>
    expect(ref_type.kind).toBe(TypeKind.Reference));
  test('child to parent column reference table is `some_relation_parent_table`', () =>
    expect((ref_type as ReferenceType).tables).toEqual([expected_parent_table_name]));
  test('child to parent column reference column name is `id`', () =>
    expect((ref_type as ReferenceType).column).toBe(ID_FIELD_NAME));
  test('child to parent column reference db type is `Text`', () =>
    expect((ref_type as ReferenceType).dbType).toBe(DBType.Text));
});

describe('fulltext', () => {
  const fulltext_schema = `
    type SomeFulltextTable @entity {
        id: ID!,
        symbol: String!,
        name: String!,
    }

    type _Schema_
        @fulltext(
            name: "FulltextField"
            language: tr
            algorithm: rank
            include: [
            {
                entity: "SomeFulltextTable"
                fields: [{ name: "symbol" }, { name: "name" }, { name: "id" }]
            }
            ]
        )
`;

  const layout = parse(fulltext_schema);
  const expected_table_name = 'some_fulltext_table';
  const expected_column_name = 'fulltext_field';

  const fulltext_column = layout.tables
    .get(expected_table_name)!
    .columns.get(expected_column_name)!;

  test('column is defined', () => expect(fulltext_column).toBeDefined());
  test('column type is `TextSearchType`', () =>
    expect(fulltext_column.type.kind).toBe(TypeKind.TextSearch));
  test('column db type is `tSVector`', () =>
    expect((fulltext_column.type as TextSearchType).dbType).toBe(DBType.TextSearch));
  test('column full text language is `tr`', () =>
    expect((fulltext_column.type as TextSearchType).language).toBe('tr'));
  test('column full text algorithm is `rank`', () =>
    expect((fulltext_column.type as TextSearchType).algorithm).toBe('rank'));
  test('column full text columns are `symbol`, `name` and `id`', () =>
    expect((fulltext_column.type as TextSearchType).columns).toEqual(['symbol', 'name', 'id']));
});

describe.each([
  'schema.graphql',
  'schema2.graphql',
  'schema3.graphql',
  'schema4.graphql',
  'schema5.graphql',
  'schema6.graphql'
])('real life samples', (schema_file) => {
  test(schema_file, () => {
    const graphql_schema = readFileSync(path.join(__dirname, 'samples/' + schema_file), 'utf8');
    const layout = parse(graphql_schema);
    expect(layout.tables.size).toBeGreaterThan(0);
  });
});
