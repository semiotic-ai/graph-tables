/** This regex is derived from graph-node snake case library which has really strange
 * behavior. See [v0.11.4 of inflector package](https://github.com/whatisinternet/Inflector/blob/master/src/cases/snakecase/mod.rs)
 **/
const GRAPH_SNAKE_CASE_RE =
  /((?<=\p{Ll})\p{Lu}|(?<=\p{Ll})\p{N}|(?<=\p{N})\p{Lu}\p{Ll}|\p{N}\p{Ll})/gu;

// Regexp involved with stripping non-word characters from the result.
const DEFAULT_STRIP_REGEXP = /[^\p{L}\p{N}_]+/giu;
// The replacement value for splits.
const SPLIT_REPLACE_VALUE = '_$1';

/**
 * Convert a string to snake case (`foo_bar`).
 */
export function snakeCase(value: string): string {
  const result = value
    .replace(GRAPH_SNAKE_CASE_RE, SPLIT_REPLACE_VALUE)
    .replace(DEFAULT_STRIP_REGEXP, '_')
    .toLowerCase();

  return result;
}
