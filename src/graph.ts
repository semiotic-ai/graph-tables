import {
  Kind,
  type FieldDefinitionNode,
  type ObjectTypeDefinitionNode,
  type BooleanValueNode
} from 'graphql';

/**
 * GraphQL type name containing full text indexing information in the subgraph graphql schema
 */
export const SCHEMA_TYPE_NAME = '_Schema_';
/**
 * GraphQL directive name containing full text indexing information in the subgraph graphql schema
 */
export const FULLTEXT_DIRECTIVE_NAME = 'fulltext';

/**
 * GraphQL directive name containing relation column for parent-child information in the subgraph graphql schema
 */
export const DERIVED_FROM_DIRECTIVE_NAME = 'derivedFrom';
/**
 * GraphQL type field name identifying a unique key in the subgraph graphql schema
 */
export const ID_FIELD_NAME: string = 'id';

/**
 * GraphQL directive name identifying an entity
 */
export const ENTITY_DIRECTIVE_NAME = 'entity';

/**
 * GraphQL `entity` directive `argument` name marking an entity as immutable
 */
export const IMMUTABLE_ARGUMENT_NAME = 'immutable';

/**
 * Virtual ID column name
 */
export const VIRTUAL_ID_COLUMN_NAME = 'vid';

/**
 * Block range column name for mutable entities
 */
export const BLOCK_RANGE_COLUMN_NAME = 'block_range';

/**
 * Block column name for immutable entities
 */
export const BLOCK_COLUMN_NAME = 'block$';

/**
 * Checks if the field is a derived list of child objects
 * @param field field type to check
 * @returns `true` if the `field` is a derived list of child objects
 */
export function isDerivedField(field: FieldDefinitionNode): boolean {
  return (
    field.directives?.some((directive) => directive.name.value === DERIVED_FROM_DIRECTIVE_NAME) ??
    false
  );
}

/**
 * Checks if the entity is marked as immuttable
 * @param entity entity type to check
 * @returns `true` if the `entity` is marked as immuttable
 */
export function isImmutableEntity(entity: ObjectTypeDefinitionNode): boolean {
  const immutableArgument = entity.directives
    ?.find((directive) => directive.name.value === ENTITY_DIRECTIVE_NAME)
    ?.arguments?.find(
      (arg) => arg.name.value === IMMUTABLE_ARGUMENT_NAME && arg.value.kind === Kind.BOOLEAN
    )?.value;

  if (!immutableArgument) {
    return false;
  }

  return (immutableArgument as BooleanValueNode).value;
}
