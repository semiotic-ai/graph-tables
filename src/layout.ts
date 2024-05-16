import type { DBType, IdType } from './db';

/**
 * Column type kind
 */
export enum TypeKind {
  Scalar = 'scalar',
  Enum = 'enum',
  Reference = 'reference',
  List = 'list',
  TextSearch = 'textsearch'
}

interface TypeBase {
  /**
   * Column type kind
   */
  readonly kind: TypeKind;
}

/**
 * Scalar/simple column type
 */
export interface ScalarType extends TypeBase {
  readonly kind: TypeKind.Scalar;
  /**
   * Database specific column type
   */
  readonly dbType: DBType;
}

export interface EnumType extends TypeBase {
  readonly kind: TypeKind.Enum;
  /**
   * Enum name in the database
   */
  readonly name: string;
}

export interface ReferenceType {
  readonly kind: TypeKind.Reference;
  /**
   * Name of the relation parent table
   */
  readonly tables: string[];
  /**
   * Name of the relation parent column
   */
  readonly column: string;
  /**
   * Database specific column type
   */
  readonly dbType: IdType;
}

export interface ListType {
  readonly kind: TypeKind.List;
  /**
   * Type of the array item
   */
  readonly itemType: ScalarType | EnumType | ReferenceType;
}

/**
 * Full text search column type
 */
export interface TextSearchType {
  readonly kind: TypeKind.TextSearch;
  /**
   * Database specific column type
   */
  readonly dbType: DBType.TextSearch;
  /**
   * Full text indexing language used in the database
   */
  readonly language: string;
  /**
   * Full text indexing algorithm used in the database
   */
  readonly algorithm: string;
  /**
   * Table column names  used for full text indexing in the database
   */
  readonly columns: string[];
}

/**
 * Column type definitions
 */
export type ColumnType = ScalarType | EnumType | ReferenceType | ListType | TextSearchType;

/**
 * Column definition
 */
export interface Column {
  /**
   * Column type
   */
  readonly type: ColumnType;
  /**
   * Is column a primary key in the database
   */
  readonly isPrimary: boolean;
  /**
   * Is column nullable in the database
   */
  readonly nullable: boolean;
  /**
   * Column description
   */
  readonly description?: string;
}

/**
 * Table parent-child relation definition
 */
export interface Relation {
  /**
   * Relation name (not used by db)
   */
  name: string;
  /**
   * Child table name in the database
   */
  table: string;
  /**
   * Child column name in the database
   */
  column: string;
  /**
   * Parent table name in the database
   */
  type: 'one' | 'many';
}

/**
 * Table definition
 */
export interface Table {
  /**
   * Table columns
   */
  columns: Map<string, Column>;
  /**
   * Table parent-child relations by column
   */
  relations: Map<string, Relation[]>;
}

/**
 * Layout definition
 */
export interface Layout {
  /**
   * Layout tables
   */
  tables: Map<string, Table>;
  /**
   * Layout enums
   */
  enums: Map<string, string[]>;
}
