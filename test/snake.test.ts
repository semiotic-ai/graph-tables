import { snakeCase } from '../src/snake';

test('lowerUpper', () => expect(snakeCase('lowerUpper')).toBe('lower_upper'));
test('lowerUpperLower', () => expect(snakeCase('lowerUpperLower')).toBe('lower_upper_lower'));
test('lower0Upper', () => expect(snakeCase('lower0Upper')).toBe('lower_0_upper'));
test('lowerUpper0', () => expect(snakeCase('lowerUpper0')).toBe('lower_upper_0'));
test('feeGrowthGlobal0X128', () =>
  expect(snakeCase('feeGrowthGlobal0X128')).toBe('fee_growth_global_0x128'));
test('feeGrowthGlobal0X128Free', () =>
  expect(snakeCase('feeGrowthGlobal0X128Free')).toBe('fee_growth_global_0x128_free'));
test('feeGrowthGlobal0X128free', () =>
  expect(snakeCase('feeGrowthGlobal0X128free')).toBe('fee_growth_global_0x12_8free')); // This is a bug in the graph-node snake case library
test('feeGrowthGlobal0X128,Free', () =>
  expect(snakeCase('feeGrowthGlobal0X128,Free')).toBe('fee_growth_global_0x128_free'));
