<h1 align="center" style="border-bottom: none;">
graph-tables</h1>
<h3 align="center">Postgres database schema parser for Graph Protocol subgraph schema</h3>
<p align="center">
  <a href="https://github.com/semantic-release/semantic-release">
    <img alt="semantic-release" src="https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg">
  </a>
  <a href="https://github.com/semiotic-ai/graph-tables/actions">
    <img alt="Actions Status" src="https://github.com/semiotic-ai/graph-tables/workflows/CI/badge.svg">
  </a>
  <a href="https://github.com/semiotic-ai/graph-tables/blob/main/LICENSE">
    <img alt="License" src="https://img.shields.io/github/license/semiotic-ai/graph-tables">
  </a>
</p>
<p align="center">
  <a href="https://www.npmjs.com/package/@semiotic-labs/graph-tables">
    <img alt="npm install" src="https://img.shields.io/badge/npm%20i-graph--tables-brightgreen">
  </a>
  <a href="https://github.com/semiotic-ai/graph-tables/tags">
    <img alt="version" src="https://img.shields.io/npm/v/@semiotic-labs/graph-tables?color=green&label=version">
  </a>
</p>

## Highlights
- Simple layout parse function
- Exact same identifier (table, column, enum, etc..) naming from graph-node implementation of postgres schema generation.
- JS mappings used for fast table and column search
- Enum definitions
- Detailed column types including enum and foreign key references
- One to one and one to many table relations
- `block$` or `block_range` column based on the GraphQL entity mutability. 
- Package include CommonJS, ES Modules, UMD version and TypeScript declaration files.

## Install

```sh
npm install @semiotic-labs/graph-tables
```

## Usage

```ts
import {parse} from '@semiotic-labs/graph-tables';

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
```

## Examples
The examples folder contains sample subgraph search and parsing example using the library.

```sh
What is the name of the subgraph? uniswap-v3
First 20 subgraphs found: 
1. hype-pool-uniswap-v3-arbitrum
2. uniswap-v3-mainnet
3. polygon-uniswap-v3
4. uniswap-v3-optimism
5. uniswap-v3-polygon
6. uniswap-v3-arbitrum
7. uniswap-v3-ethereum
8. uniswap-v3-avalanche
9. uniswap-v3-polygon
Enter subgraph index to view the database layout: 7
Selected subgraph: uniswap-v3-ethereum
Fetching layout... QmZ1y5FfQkxxFXydm1jvpUgC2bC719wvTm9AAfTy5WeKiR-QmcBpDfSAt3jxFZCenUCVnyuNgPkRhz1aD3MA4SiNKPyRR
Database layout: 
        Enums:
        Tables:
                fee_amount_enabled
                        block$
                        vid
                        id
                        fee
                        tick_spacing
                        block_number
                        block_timestamp
                        transaction_hash
                owner_changed
                        block$
                        vid
                        id
                        old_owner
                        new_owner
                        block_number
                        block_timestamp
                        transaction_hash
                pool_created
                        block$
                        vid
                        id
                        token_0
                        token_1
                        fee
                        tick_spacing
                        pool
                        block_number
                        block_timestamp
                        transaction_hash
```