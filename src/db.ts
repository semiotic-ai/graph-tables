/**
 * Postgres specific column types used by thegraph protocol
 */
export enum DBType {
  /**
   * state of true or false
   */
  Boolean = 'boolean',
  /**
   * any numeric value
   */
  Numeric = 'numeric',
  /**
   * variable-length binary string
   */
  Bytea = 'bytea',
  /**
   * signed four-byte integer
   */
  Integer = 'integer',
  /**
   * signed eight-byte integer
   */
  Int8 = 'int8',
  /**
   * variable-length character string
   */
  Text = 'text',
  /**
   * large auto incrementing integer
   */
  BigSerial = 'bigserial',
  /**
   * range of integers (start,end)
   */
  Int4Range = 'int4range',
  /**
   * sorted list of distinct lexemes (used for full text indexing)
   */
  TextSearch = 'tsvector'
}

/**
 * Postgres specific `id` column types used by thegraph protocol
 */
export type IdType = DBType.Bytea | DBType.Int8 | DBType.Text;
