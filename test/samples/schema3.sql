-- This file is generated from graph-node postgres database schema generation
-- see store/postgres/src/relational/ddl_tests.rs under graph-node repository

create type sgd0815."liquidity_pool_fee_type" as enum (
    'DEPOSIT_FEE',
    'DYNAMIC_LP_FEE',
    'DYNAMIC_PROTOCOL_FEE',
    'DYNAMIC_TRADING_FEE',
    'FIXED_LP_FEE',
    'FIXED_PROTOCOL_FEE',
    'FIXED_TRADING_FEE',
    'TIERED_TRADING_FEE',
    'WITHDRAWAL_FEE'
);
create type sgd0815."network" as enum (
    'ARBITRUM_ONE',
    'ARWEAVE_MAINNET',
    'AURORA',
    'AVALANCHE',
    'BOBA',
    'BSC',
    'CELO',
    'COSMOS',
    'CRONOS',
    'FANTOM',
    'FUSE',
    'HARMONY',
    'JUNO',
    'MAINNET',
    'MATIC',
    'MOONBEAM',
    'MOONRIVER',
    'NEAR_MAINNET',
    'OPTIMISM',
    'OSMOSIS',
    'XDAI'
);
create type sgd0815."protocol_type" as enum (
    'BRIDGE',
    'EXCHANGE',
    'GENERIC',
    'LENDING',
    'YIELD'
);
create type sgd0815."reward_token_type" as enum ('BORROW', 'DEPOSIT');
create table "sgd0815"."token" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "name" text not null,
    "symbol" text not null,
    "decimals" integer not null,
    "last_price_usd" numeric,
    "last_price_block_number" numeric
);
alter table "sgd0815"."token"
add constraint token_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_token on "sgd0815"."token" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index token_block_range_closed on "sgd0815"."token"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_0_0_token_id on "sgd0815"."token" using btree("id");
create index attr_0_1_token_name on "sgd0815"."token" using btree(left("name", 256));
create index attr_0_2_token_symbol on "sgd0815"."token" using btree(left("symbol", 256));
create index attr_0_3_token_decimals on "sgd0815"."token" using btree("decimals");
create index attr_0_4_token_last_price_usd on "sgd0815"."token" using btree("last_price_usd");
create index attr_0_5_token_last_price_block_number on "sgd0815"."token" using btree("last_price_block_number");
create table "sgd0815"."reward_token" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "token" text not null,
    "type" "sgd0815"."reward_token_type" not null
);
alter table "sgd0815"."reward_token"
add constraint reward_token_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_reward_token on "sgd0815"."reward_token" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index reward_token_block_range_closed on "sgd0815"."reward_token"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_1_0_reward_token_id on "sgd0815"."reward_token" using btree("id");
create index attr_1_1_reward_token_token on "sgd0815"."reward_token" using gist("token", block_range);
create index attr_1_2_reward_token_type on "sgd0815"."reward_token" using btree("type");
create table "sgd0815"."liquidity_pool_fee" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "fee_percentage" numeric,
    "fee_type" "sgd0815"."liquidity_pool_fee_type" not null
);
alter table "sgd0815"."liquidity_pool_fee"
add constraint liquidity_pool_fee_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_liquidity_pool_fee on "sgd0815"."liquidity_pool_fee" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index liquidity_pool_fee_block_range_closed on "sgd0815"."liquidity_pool_fee"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_2_0_liquidity_pool_fee_id on "sgd0815"."liquidity_pool_fee" using btree("id");
create index attr_2_1_liquidity_pool_fee_fee_percentage on "sgd0815"."liquidity_pool_fee" using btree("fee_percentage");
create index attr_2_2_liquidity_pool_fee_fee_type on "sgd0815"."liquidity_pool_fee" using btree("fee_type");
create table "sgd0815"."dex_amm_protocol" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "name" text not null,
    "slug" text not null,
    "schema_version" text not null,
    "subgraph_version" text not null,
    "methodology_version" text not null,
    "network" "sgd0815"."network" not null,
    "type" "sgd0815"."protocol_type" not null,
    "total_value_locked_usd" numeric not null,
    "protocol_controlled_value_usd" numeric,
    "cumulative_volume_usd" numeric not null,
    "cumulative_supply_side_revenue_usd" numeric not null,
    "cumulative_protocol_side_revenue_usd" numeric not null,
    "cumulative_total_revenue_usd" numeric not null,
    "cumulative_unique_users" integer not null,
    "total_pool_count" integer not null,
    "pool_ids" text [] not null
);
alter table "sgd0815"."dex_amm_protocol"
add constraint dex_amm_protocol_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_dex_amm_protocol on "sgd0815"."dex_amm_protocol" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index dex_amm_protocol_block_range_closed on "sgd0815"."dex_amm_protocol"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_3_0_dex_amm_protocol_id on "sgd0815"."dex_amm_protocol" using btree("id");
create index attr_3_1_dex_amm_protocol_name on "sgd0815"."dex_amm_protocol" using btree(left("name", 256));
create index attr_3_2_dex_amm_protocol_slug on "sgd0815"."dex_amm_protocol" using btree(left("slug", 256));
create index attr_3_3_dex_amm_protocol_schema_version on "sgd0815"."dex_amm_protocol" using btree(left("schema_version", 256));
create index attr_3_4_dex_amm_protocol_subgraph_version on "sgd0815"."dex_amm_protocol" using btree(left("subgraph_version", 256));
create index attr_3_5_dex_amm_protocol_methodology_version on "sgd0815"."dex_amm_protocol" using btree(left("methodology_version", 256));
create index attr_3_6_dex_amm_protocol_network on "sgd0815"."dex_amm_protocol" using btree("network");
create index attr_3_7_dex_amm_protocol_type on "sgd0815"."dex_amm_protocol" using btree("type");
create index attr_3_8_dex_amm_protocol_total_value_locked_usd on "sgd0815"."dex_amm_protocol" using btree("total_value_locked_usd");
create index attr_3_9_dex_amm_protocol_protocol_controlled_value_usd on "sgd0815"."dex_amm_protocol" using btree("protocol_controlled_value_usd");
create index attr_3_10_dex_amm_protocol_cumulative_volume_usd on "sgd0815"."dex_amm_protocol" using btree("cumulative_volume_usd");
create index attr_3_11_dex_amm_protocol_cumulative_supply_side_revenue_usd on "sgd0815"."dex_amm_protocol" using btree("cumulative_supply_side_revenue_usd");
create index attr_3_12_dex_amm_protocol_cumulative_protocol_side_revenue_usd on "sgd0815"."dex_amm_protocol" using btree("cumulative_protocol_side_revenue_usd");
create index attr_3_13_dex_amm_protocol_cumulative_total_revenue_usd on "sgd0815"."dex_amm_protocol" using btree("cumulative_total_revenue_usd");
create index attr_3_14_dex_amm_protocol_cumulative_unique_users on "sgd0815"."dex_amm_protocol" using btree("cumulative_unique_users");
create index attr_3_15_dex_amm_protocol_total_pool_count on "sgd0815"."dex_amm_protocol" using btree("total_pool_count");
create table "sgd0815"."usage_metrics_daily_snapshot" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "protocol" text not null,
    "daily_active_users" integer not null,
    "cumulative_unique_users" integer not null,
    "daily_transaction_count" integer not null,
    "daily_deposit_count" integer not null,
    "daily_withdraw_count" integer not null,
    "daily_swap_count" integer not null,
    "total_pool_count" integer not null,
    "block_number" numeric not null,
    "timestamp" numeric not null
);
alter table "sgd0815"."usage_metrics_daily_snapshot"
add constraint usage_metrics_daily_snapshot_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_usage_metrics_daily_snapshot on "sgd0815"."usage_metrics_daily_snapshot" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index usage_metrics_daily_snapshot_block_range_closed on "sgd0815"."usage_metrics_daily_snapshot"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_4_0_usage_metrics_daily_snapshot_id on "sgd0815"."usage_metrics_daily_snapshot" using btree("id");
create index attr_4_1_usage_metrics_daily_snapshot_protocol on "sgd0815"."usage_metrics_daily_snapshot" using gist("protocol", block_range);
create index attr_4_2_usage_metrics_daily_snapshot_daily_active_users on "sgd0815"."usage_metrics_daily_snapshot" using btree("daily_active_users");
create index attr_4_3_usage_metrics_daily_snapshot_cumulative_unique_users on "sgd0815"."usage_metrics_daily_snapshot" using btree("cumulative_unique_users");
create index attr_4_4_usage_metrics_daily_snapshot_daily_transaction_count on "sgd0815"."usage_metrics_daily_snapshot" using btree("daily_transaction_count");
create index attr_4_5_usage_metrics_daily_snapshot_daily_deposit_count on "sgd0815"."usage_metrics_daily_snapshot" using btree("daily_deposit_count");
create index attr_4_6_usage_metrics_daily_snapshot_daily_withdraw_count on "sgd0815"."usage_metrics_daily_snapshot" using btree("daily_withdraw_count");
create index attr_4_7_usage_metrics_daily_snapshot_daily_swap_count on "sgd0815"."usage_metrics_daily_snapshot" using btree("daily_swap_count");
create index attr_4_8_usage_metrics_daily_snapshot_total_pool_count on "sgd0815"."usage_metrics_daily_snapshot" using btree("total_pool_count");
create index attr_4_9_usage_metrics_daily_snapshot_block_number on "sgd0815"."usage_metrics_daily_snapshot" using btree("block_number");
create index attr_4_10_usage_metrics_daily_snapshot_timestamp on "sgd0815"."usage_metrics_daily_snapshot" using btree("timestamp");
create table "sgd0815"."usage_metrics_hourly_snapshot" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "protocol" text not null,
    "hourly_active_users" integer not null,
    "cumulative_unique_users" integer not null,
    "hourly_transaction_count" integer not null,
    "hourly_deposit_count" integer not null,
    "hourly_withdraw_count" integer not null,
    "hourly_swap_count" integer not null,
    "block_number" numeric not null,
    "timestamp" numeric not null
);
alter table "sgd0815"."usage_metrics_hourly_snapshot"
add constraint usage_metrics_hourly_snapshot_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_usage_metrics_hourly_snapshot on "sgd0815"."usage_metrics_hourly_snapshot" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index usage_metrics_hourly_snapshot_block_range_closed on "sgd0815"."usage_metrics_hourly_snapshot"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_5_0_usage_metrics_hourly_snapshot_id on "sgd0815"."usage_metrics_hourly_snapshot" using btree("id");
create index attr_5_1_usage_metrics_hourly_snapshot_protocol on "sgd0815"."usage_metrics_hourly_snapshot" using gist("protocol", block_range);
create index attr_5_2_usage_metrics_hourly_snapshot_hourly_active_users on "sgd0815"."usage_metrics_hourly_snapshot" using btree("hourly_active_users");
create index attr_5_3_usage_metrics_hourly_snapshot_cumulative_unique_users on "sgd0815"."usage_metrics_hourly_snapshot" using btree("cumulative_unique_users");
create index attr_5_4_usage_metrics_hourly_snapshot_hourly_transaction_count on "sgd0815"."usage_metrics_hourly_snapshot" using btree("hourly_transaction_count");
create index attr_5_5_usage_metrics_hourly_snapshot_hourly_deposit_count on "sgd0815"."usage_metrics_hourly_snapshot" using btree("hourly_deposit_count");
create index attr_5_6_usage_metrics_hourly_snapshot_hourly_withdraw_count on "sgd0815"."usage_metrics_hourly_snapshot" using btree("hourly_withdraw_count");
create index attr_5_7_usage_metrics_hourly_snapshot_hourly_swap_count on "sgd0815"."usage_metrics_hourly_snapshot" using btree("hourly_swap_count");
create index attr_5_8_usage_metrics_hourly_snapshot_block_number on "sgd0815"."usage_metrics_hourly_snapshot" using btree("block_number");
create index attr_5_9_usage_metrics_hourly_snapshot_timestamp on "sgd0815"."usage_metrics_hourly_snapshot" using btree("timestamp");
create table "sgd0815"."financials_daily_snapshot" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "protocol" text not null,
    "total_value_locked_usd" numeric not null,
    "protocol_controlled_value_usd" numeric,
    "daily_volume_usd" numeric not null,
    "cumulative_volume_usd" numeric not null,
    "daily_supply_side_revenue_usd" numeric not null,
    "cumulative_supply_side_revenue_usd" numeric not null,
    "daily_protocol_side_revenue_usd" numeric not null,
    "cumulative_protocol_side_revenue_usd" numeric not null,
    "daily_total_revenue_usd" numeric not null,
    "cumulative_total_revenue_usd" numeric not null,
    "block_number" numeric not null,
    "timestamp" numeric not null
);
alter table "sgd0815"."financials_daily_snapshot"
add constraint financials_daily_snapshot_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_financials_daily_snapshot on "sgd0815"."financials_daily_snapshot" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index financials_daily_snapshot_block_range_closed on "sgd0815"."financials_daily_snapshot"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_6_0_financials_daily_snapshot_id on "sgd0815"."financials_daily_snapshot" using btree("id");
create index attr_6_1_financials_daily_snapshot_protocol on "sgd0815"."financials_daily_snapshot" using gist("protocol", block_range);
create index attr_6_2_financials_daily_snapshot_total_value_locked_usd on "sgd0815"."financials_daily_snapshot" using btree("total_value_locked_usd");
create index attr_6_3_financials_daily_snapshot_protocol_controlled_value_usd on "sgd0815"."financials_daily_snapshot" using btree("protocol_controlled_value_usd");
create index attr_6_4_financials_daily_snapshot_daily_volume_usd on "sgd0815"."financials_daily_snapshot" using btree("daily_volume_usd");
create index attr_6_5_financials_daily_snapshot_cumulative_volume_usd on "sgd0815"."financials_daily_snapshot" using btree("cumulative_volume_usd");
create index attr_6_6_financials_daily_snapshot_daily_supply_side_revenue_usd on "sgd0815"."financials_daily_snapshot" using btree("daily_supply_side_revenue_usd");
create index attr_6_7_financials_daily_snapshot_cumulative_supply_side_revenue_usd on "sgd0815"."financials_daily_snapshot" using btree("cumulative_supply_side_revenue_usd");
create index attr_6_8_financials_daily_snapshot_daily_protocol_side_revenue_usd on "sgd0815"."financials_daily_snapshot" using btree("daily_protocol_side_revenue_usd");
create index attr_6_9_financials_daily_snapshot_cumulative_protocol_side_revenue_usd on "sgd0815"."financials_daily_snapshot" using btree("cumulative_protocol_side_revenue_usd");
create index attr_6_10_financials_daily_snapshot_daily_total_revenue_usd on "sgd0815"."financials_daily_snapshot" using btree("daily_total_revenue_usd");
create index attr_6_11_financials_daily_snapshot_cumulative_total_revenue_usd on "sgd0815"."financials_daily_snapshot" using btree("cumulative_total_revenue_usd");
create index attr_6_12_financials_daily_snapshot_block_number on "sgd0815"."financials_daily_snapshot" using btree("block_number");
create index attr_6_13_financials_daily_snapshot_timestamp on "sgd0815"."financials_daily_snapshot" using btree("timestamp");
create table "sgd0815"."liquidity_pool" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "protocol" text not null,
    "name" text,
    "symbol" text,
    "input_tokens" text [] not null,
    "input_tokens_ordered" text [] not null,
    "output_token" text,
    "reward_tokens" text [],
    "fees" text [] not null,
    "is_single_sided" boolean not null,
    "created_timestamp" numeric not null,
    "created_block_number" numeric not null,
    "total_value_locked_usd" numeric not null,
    "cumulative_supply_side_revenue_usd" numeric not null,
    "cumulative_protocol_side_revenue_usd" numeric not null,
    "cumulative_total_revenue_usd" numeric not null,
    "cumulative_volume_usd" numeric not null,
    "input_token_balances" numeric [] not null,
    "input_token_weights" numeric [] not null,
    "output_token_supply" numeric,
    "output_token_price_usd" numeric,
    "staked_output_token_amount" numeric,
    "reward_token_emissions_amount" numeric [],
    "reward_token_emissions_usd" numeric [],
    "registry_address" text not null,
    "gauge_address" text not null
);
alter table "sgd0815"."liquidity_pool"
add constraint liquidity_pool_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_liquidity_pool on "sgd0815"."liquidity_pool" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index liquidity_pool_block_range_closed on "sgd0815"."liquidity_pool"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_7_0_liquidity_pool_id on "sgd0815"."liquidity_pool" using btree("id");
create index attr_7_1_liquidity_pool_protocol on "sgd0815"."liquidity_pool" using gist("protocol", block_range);
create index attr_7_2_liquidity_pool_name on "sgd0815"."liquidity_pool" using btree(left("name", 256));
create index attr_7_3_liquidity_pool_symbol on "sgd0815"."liquidity_pool" using btree(left("symbol", 256));
create index attr_7_6_liquidity_pool_output_token on "sgd0815"."liquidity_pool" using gist("output_token", block_range);
create index attr_7_9_liquidity_pool_is_single_sided on "sgd0815"."liquidity_pool" using btree("is_single_sided");
create index attr_7_10_liquidity_pool_created_timestamp on "sgd0815"."liquidity_pool" using btree("created_timestamp");
create index attr_7_11_liquidity_pool_created_block_number on "sgd0815"."liquidity_pool" using btree("created_block_number");
create index attr_7_12_liquidity_pool_total_value_locked_usd on "sgd0815"."liquidity_pool" using btree("total_value_locked_usd");
create index attr_7_13_liquidity_pool_cumulative_supply_side_revenue_usd on "sgd0815"."liquidity_pool" using btree("cumulative_supply_side_revenue_usd");
create index attr_7_14_liquidity_pool_cumulative_protocol_side_revenue_usd on "sgd0815"."liquidity_pool" using btree("cumulative_protocol_side_revenue_usd");
create index attr_7_15_liquidity_pool_cumulative_total_revenue_usd on "sgd0815"."liquidity_pool" using btree("cumulative_total_revenue_usd");
create index attr_7_16_liquidity_pool_cumulative_volume_usd on "sgd0815"."liquidity_pool" using btree("cumulative_volume_usd");
create index attr_7_17_liquidity_pool_output_token_supply on "sgd0815"."liquidity_pool" using btree("output_token_supply");
create index attr_7_18_liquidity_pool_output_token_price_usd on "sgd0815"."liquidity_pool" using btree("output_token_price_usd");
create index attr_7_19_liquidity_pool_staked_output_token_amount on "sgd0815"."liquidity_pool" using btree("staked_output_token_amount");
create index attr_7_20_liquidity_pool_registry_address on "sgd0815"."liquidity_pool" using btree(left("registry_address", 256));
create index attr_7_21_liquidity_pool_gauge_address on "sgd0815"."liquidity_pool" using btree(left("gauge_address", 256));
create table "sgd0815"."liquidity_pool_daily_snapshot" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "protocol" text not null,
    "pool" text not null,
    "block_number" numeric not null,
    "timestamp" numeric not null,
    "total_value_locked_usd" numeric not null,
    "cumulative_supply_side_revenue_usd" numeric not null,
    "daily_supply_side_revenue_usd" numeric not null,
    "cumulative_protocol_side_revenue_usd" numeric not null,
    "daily_protocol_side_revenue_usd" numeric not null,
    "cumulative_total_revenue_usd" numeric not null,
    "daily_total_revenue_usd" numeric not null,
    "daily_volume_usd" numeric not null,
    "daily_volume_by_token_amount" numeric [] not null,
    "daily_volume_by_token_usd" numeric [] not null,
    "cumulative_volume_usd" numeric not null,
    "input_token_balances" numeric [] not null,
    "input_token_weights" numeric [] not null,
    "output_token_supply" numeric,
    "output_token_price_usd" numeric,
    "staked_output_token_amount" numeric,
    "reward_token_emissions_amount" numeric [],
    "reward_token_emissions_usd" numeric []
);
alter table "sgd0815"."liquidity_pool_daily_snapshot"
add constraint liquidity_pool_daily_snapshot_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_liquidity_pool_daily_snapshot on "sgd0815"."liquidity_pool_daily_snapshot" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index liquidity_pool_daily_snapshot_block_range_closed on "sgd0815"."liquidity_pool_daily_snapshot"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_8_0_liquidity_pool_daily_snapshot_id on "sgd0815"."liquidity_pool_daily_snapshot" using btree("id");
create index attr_8_1_liquidity_pool_daily_snapshot_protocol on "sgd0815"."liquidity_pool_daily_snapshot" using gist("protocol", block_range);
create index attr_8_2_liquidity_pool_daily_snapshot_pool on "sgd0815"."liquidity_pool_daily_snapshot" using gist("pool", block_range);
create index attr_8_3_liquidity_pool_daily_snapshot_block_number on "sgd0815"."liquidity_pool_daily_snapshot" using btree("block_number");
create index attr_8_4_liquidity_pool_daily_snapshot_timestamp on "sgd0815"."liquidity_pool_daily_snapshot" using btree("timestamp");
create index attr_8_5_liquidity_pool_daily_snapshot_total_value_locked_usd on "sgd0815"."liquidity_pool_daily_snapshot" using btree("total_value_locked_usd");
create index attr_8_6_liquidity_pool_daily_snapshot_cumulative_supply_side_revenue_usd on "sgd0815"."liquidity_pool_daily_snapshot" using btree("cumulative_supply_side_revenue_usd");
create index attr_8_7_liquidity_pool_daily_snapshot_daily_supply_side_revenue_usd on "sgd0815"."liquidity_pool_daily_snapshot" using btree("daily_supply_side_revenue_usd");
create index attr_8_8_liquidity_pool_daily_snapshot_cumulative_protocol_side_revenue_usd on "sgd0815"."liquidity_pool_daily_snapshot" using btree("cumulative_protocol_side_revenue_usd");
create index attr_8_9_liquidity_pool_daily_snapshot_daily_protocol_side_revenue_usd on "sgd0815"."liquidity_pool_daily_snapshot" using btree("daily_protocol_side_revenue_usd");
create index attr_8_10_liquidity_pool_daily_snapshot_cumulative_total_revenue_usd on "sgd0815"."liquidity_pool_daily_snapshot" using btree("cumulative_total_revenue_usd");
create index attr_8_11_liquidity_pool_daily_snapshot_daily_total_revenue_usd on "sgd0815"."liquidity_pool_daily_snapshot" using btree("daily_total_revenue_usd");
create index attr_8_12_liquidity_pool_daily_snapshot_daily_volume_usd on "sgd0815"."liquidity_pool_daily_snapshot" using btree("daily_volume_usd");
create index attr_8_13_liquidity_pool_daily_snapshot_cumulative_volume_usd on "sgd0815"."liquidity_pool_daily_snapshot" using btree("cumulative_volume_usd");
create index attr_8_14_liquidity_pool_daily_snapshot_output_token_supply on "sgd0815"."liquidity_pool_daily_snapshot" using btree("output_token_supply");
create index attr_8_15_liquidity_pool_daily_snapshot_output_token_price_usd on "sgd0815"."liquidity_pool_daily_snapshot" using btree("output_token_price_usd");
create index attr_8_16_liquidity_pool_daily_snapshot_staked_output_token_amount on "sgd0815"."liquidity_pool_daily_snapshot" using btree("staked_output_token_amount");
create table "sgd0815"."liquidity_pool_hourly_snapshot" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "protocol" text not null,
    "pool" text not null,
    "block_number" numeric not null,
    "timestamp" numeric not null,
    "total_value_locked_usd" numeric not null,
    "cumulative_supply_side_revenue_usd" numeric not null,
    "hourly_supply_side_revenue_usd" numeric not null,
    "cumulative_protocol_side_revenue_usd" numeric not null,
    "hourly_protocol_side_revenue_usd" numeric not null,
    "cumulative_total_revenue_usd" numeric not null,
    "hourly_total_revenue_usd" numeric not null,
    "hourly_volume_usd" numeric not null,
    "hourly_volume_by_token_amount" numeric [] not null,
    "hourly_volume_by_token_usd" numeric [] not null,
    "cumulative_volume_usd" numeric not null,
    "input_token_balances" numeric [] not null,
    "input_token_weights" numeric [] not null,
    "output_token_supply" numeric,
    "output_token_price_usd" numeric,
    "staked_output_token_amount" numeric,
    "reward_token_emissions_amount" numeric [],
    "reward_token_emissions_usd" numeric []
);
alter table "sgd0815"."liquidity_pool_hourly_snapshot"
add constraint liquidity_pool_hourly_snapshot_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_liquidity_pool_hourly_snapshot on "sgd0815"."liquidity_pool_hourly_snapshot" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index liquidity_pool_hourly_snapshot_block_range_closed on "sgd0815"."liquidity_pool_hourly_snapshot"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_9_0_liquidity_pool_hourly_snapshot_id on "sgd0815"."liquidity_pool_hourly_snapshot" using btree("id");
create index attr_9_1_liquidity_pool_hourly_snapshot_protocol on "sgd0815"."liquidity_pool_hourly_snapshot" using gist("protocol", block_range);
create index attr_9_2_liquidity_pool_hourly_snapshot_pool on "sgd0815"."liquidity_pool_hourly_snapshot" using gist("pool", block_range);
create index attr_9_3_liquidity_pool_hourly_snapshot_block_number on "sgd0815"."liquidity_pool_hourly_snapshot" using btree("block_number");
create index attr_9_4_liquidity_pool_hourly_snapshot_timestamp on "sgd0815"."liquidity_pool_hourly_snapshot" using btree("timestamp");
create index attr_9_5_liquidity_pool_hourly_snapshot_total_value_locked_usd on "sgd0815"."liquidity_pool_hourly_snapshot" using btree("total_value_locked_usd");
create index attr_9_6_liquidity_pool_hourly_snapshot_cumulative_supply_side_revenue_usd on "sgd0815"."liquidity_pool_hourly_snapshot" using btree("cumulative_supply_side_revenue_usd");
create index attr_9_7_liquidity_pool_hourly_snapshot_hourly_supply_side_revenue_usd on "sgd0815"."liquidity_pool_hourly_snapshot" using btree("hourly_supply_side_revenue_usd");
create index attr_9_8_liquidity_pool_hourly_snapshot_cumulative_protocol_side_revenue_usd on "sgd0815"."liquidity_pool_hourly_snapshot" using btree("cumulative_protocol_side_revenue_usd");
create index attr_9_9_liquidity_pool_hourly_snapshot_hourly_protocol_side_revenue_usd on "sgd0815"."liquidity_pool_hourly_snapshot" using btree("hourly_protocol_side_revenue_usd");
create index attr_9_10_liquidity_pool_hourly_snapshot_cumulative_total_revenue_usd on "sgd0815"."liquidity_pool_hourly_snapshot" using btree("cumulative_total_revenue_usd");
create index attr_9_11_liquidity_pool_hourly_snapshot_hourly_total_revenue_usd on "sgd0815"."liquidity_pool_hourly_snapshot" using btree("hourly_total_revenue_usd");
create index attr_9_12_liquidity_pool_hourly_snapshot_hourly_volume_usd on "sgd0815"."liquidity_pool_hourly_snapshot" using btree("hourly_volume_usd");
create index attr_9_13_liquidity_pool_hourly_snapshot_cumulative_volume_usd on "sgd0815"."liquidity_pool_hourly_snapshot" using btree("cumulative_volume_usd");
create index attr_9_14_liquidity_pool_hourly_snapshot_output_token_supply on "sgd0815"."liquidity_pool_hourly_snapshot" using btree("output_token_supply");
create index attr_9_15_liquidity_pool_hourly_snapshot_output_token_price_usd on "sgd0815"."liquidity_pool_hourly_snapshot" using btree("output_token_price_usd");
create index attr_9_16_liquidity_pool_hourly_snapshot_staked_output_token_amount on "sgd0815"."liquidity_pool_hourly_snapshot" using btree("staked_output_token_amount");
create table "sgd0815"."deposit" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "hash" text not null,
    "log_index" integer not null,
    "protocol" text not null,
    "to" text not null,
    "from" text not null,
    "block_number" numeric not null,
    "timestamp" numeric not null,
    "input_tokens" text [] not null,
    "output_token" text,
    "input_token_amounts" numeric [] not null,
    "output_token_amount" numeric,
    "amount_usd" numeric not null,
    "pool" text not null
);
alter table "sgd0815"."deposit"
add constraint deposit_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_deposit on "sgd0815"."deposit" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index deposit_block_range_closed on "sgd0815"."deposit"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_10_0_deposit_id on "sgd0815"."deposit" using btree("id");
create index attr_10_1_deposit_hash on "sgd0815"."deposit" using btree(left("hash", 256));
create index attr_10_2_deposit_log_index on "sgd0815"."deposit" using btree("log_index");
create index attr_10_3_deposit_protocol on "sgd0815"."deposit" using gist("protocol", block_range);
create index attr_10_4_deposit_to on "sgd0815"."deposit" using btree(left("to", 256));
create index attr_10_5_deposit_from on "sgd0815"."deposit" using btree(left("from", 256));
create index attr_10_6_deposit_block_number on "sgd0815"."deposit" using btree("block_number");
create index attr_10_7_deposit_timestamp on "sgd0815"."deposit" using btree("timestamp");
create index attr_10_9_deposit_output_token on "sgd0815"."deposit" using gist("output_token", block_range);
create index attr_10_10_deposit_output_token_amount on "sgd0815"."deposit" using btree("output_token_amount");
create index attr_10_11_deposit_amount_usd on "sgd0815"."deposit" using btree("amount_usd");
create index attr_10_12_deposit_pool on "sgd0815"."deposit" using gist("pool", block_range);
create table "sgd0815"."withdraw" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "hash" text not null,
    "log_index" integer not null,
    "protocol" text not null,
    "to" text not null,
    "from" text not null,
    "block_number" numeric not null,
    "timestamp" numeric not null,
    "input_tokens" text [] not null,
    "output_token" text,
    "input_token_amounts" numeric [] not null,
    "output_token_amount" numeric,
    "amount_usd" numeric not null,
    "pool" text not null
);
alter table "sgd0815"."withdraw"
add constraint withdraw_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_withdraw on "sgd0815"."withdraw" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index withdraw_block_range_closed on "sgd0815"."withdraw"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_11_0_withdraw_id on "sgd0815"."withdraw" using btree("id");
create index attr_11_1_withdraw_hash on "sgd0815"."withdraw" using btree(left("hash", 256));
create index attr_11_2_withdraw_log_index on "sgd0815"."withdraw" using btree("log_index");
create index attr_11_3_withdraw_protocol on "sgd0815"."withdraw" using gist("protocol", block_range);
create index attr_11_4_withdraw_to on "sgd0815"."withdraw" using btree(left("to", 256));
create index attr_11_5_withdraw_from on "sgd0815"."withdraw" using btree(left("from", 256));
create index attr_11_6_withdraw_block_number on "sgd0815"."withdraw" using btree("block_number");
create index attr_11_7_withdraw_timestamp on "sgd0815"."withdraw" using btree("timestamp");
create index attr_11_9_withdraw_output_token on "sgd0815"."withdraw" using gist("output_token", block_range);
create index attr_11_10_withdraw_output_token_amount on "sgd0815"."withdraw" using btree("output_token_amount");
create index attr_11_11_withdraw_amount_usd on "sgd0815"."withdraw" using btree("amount_usd");
create index attr_11_12_withdraw_pool on "sgd0815"."withdraw" using gist("pool", block_range);
create table "sgd0815"."swap" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "hash" text not null,
    "log_index" integer not null,
    "protocol" text not null,
    "to" text not null,
    "from" text not null,
    "block_number" numeric not null,
    "timestamp" numeric not null,
    "token_in" text not null,
    "amount_in" numeric not null,
    "amount_in_usd" numeric not null,
    "token_out" text not null,
    "amount_out" numeric not null,
    "amount_out_usd" numeric not null,
    "pool" text not null
);
alter table "sgd0815"."swap"
add constraint swap_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_swap on "sgd0815"."swap" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index swap_block_range_closed on "sgd0815"."swap"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_12_0_swap_id on "sgd0815"."swap" using btree("id");
create index attr_12_1_swap_hash on "sgd0815"."swap" using btree(left("hash", 256));
create index attr_12_2_swap_log_index on "sgd0815"."swap" using btree("log_index");
create index attr_12_3_swap_protocol on "sgd0815"."swap" using gist("protocol", block_range);
create index attr_12_4_swap_to on "sgd0815"."swap" using btree(left("to", 256));
create index attr_12_5_swap_from on "sgd0815"."swap" using btree(left("from", 256));
create index attr_12_6_swap_block_number on "sgd0815"."swap" using btree("block_number");
create index attr_12_7_swap_timestamp on "sgd0815"."swap" using btree("timestamp");
create index attr_12_8_swap_token_in on "sgd0815"."swap" using gist("token_in", block_range);
create index attr_12_9_swap_amount_in on "sgd0815"."swap" using btree("amount_in");
create index attr_12_10_swap_amount_in_usd on "sgd0815"."swap" using btree("amount_in_usd");
create index attr_12_11_swap_token_out on "sgd0815"."swap" using gist("token_out", block_range);
create index attr_12_12_swap_amount_out on "sgd0815"."swap" using btree("amount_out");
create index attr_12_13_swap_amount_out_usd on "sgd0815"."swap" using btree("amount_out_usd");
create index attr_12_14_swap_pool on "sgd0815"."swap" using gist("pool", block_range);
create table "sgd0815"."account" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null
);
alter table "sgd0815"."account"
add constraint account_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_account on "sgd0815"."account" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index account_block_range_closed on "sgd0815"."account"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_13_0_account_id on "sgd0815"."account" using btree("id");
create table "sgd0815"."active_account" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null
);
alter table "sgd0815"."active_account"
add constraint active_account_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_active_account on "sgd0815"."active_account" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index active_account_block_range_closed on "sgd0815"."active_account"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_14_0_active_account_id on "sgd0815"."active_account" using btree("id");
create table "sgd0815"."liquidity_gauge" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "pool_address" text not null
);
alter table "sgd0815"."liquidity_gauge"
add constraint liquidity_gauge_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_liquidity_gauge on "sgd0815"."liquidity_gauge" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index liquidity_gauge_block_range_closed on "sgd0815"."liquidity_gauge"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_15_0_liquidity_gauge_id on "sgd0815"."liquidity_gauge" using btree("id");
create index attr_15_1_liquidity_gauge_pool_address on "sgd0815"."liquidity_gauge" using btree(left("pool_address", 256));
create table "sgd0815"."lp_token" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "pool_address" text not null,
    "registry_address" text not null
);
alter table "sgd0815"."lp_token"
add constraint lp_token_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_lp_token on "sgd0815"."lp_token" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index lp_token_block_range_closed on "sgd0815"."lp_token"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_16_0_lp_token_id on "sgd0815"."lp_token" using btree("id");
create index attr_16_1_lp_token_pool_address on "sgd0815"."lp_token" using btree(left("pool_address", 256));
create index attr_16_2_lp_token_registry_address on "sgd0815"."lp_token" using btree(left("registry_address", 256));
create table "sgd0815"."circular_buffer" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "blocks" integer [] not null,
    "window_start_index" integer not null,
    "next_index" integer not null,
    "buffer_size" integer not null,
    "blocks_per_day" numeric not null
);
alter table "sgd0815"."circular_buffer"
add constraint circular_buffer_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_circular_buffer on "sgd0815"."circular_buffer" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index circular_buffer_block_range_closed on "sgd0815"."circular_buffer"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_17_0_circular_buffer_id on "sgd0815"."circular_buffer" using btree("id");
create index attr_17_1_circular_buffer_window_start_index on "sgd0815"."circular_buffer" using btree("window_start_index");
create index attr_17_2_circular_buffer_next_index on "sgd0815"."circular_buffer" using btree("next_index");
create index attr_17_3_circular_buffer_buffer_size on "sgd0815"."circular_buffer" using btree("buffer_size");
create index attr_17_4_circular_buffer_blocks_per_day on "sgd0815"."circular_buffer" using btree("blocks_per_day");