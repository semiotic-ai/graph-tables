-- This file is generated from graph-node postgres database schema generation
-- see store/postgres/src/relational/ddl_tests.rs under graph-node repository

create table "sgd0815"."locker" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null
);
alter table "sgd0815"."locker"
add constraint locker_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_locker on "sgd0815"."locker" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index locker_block_range_closed on "sgd0815"."locker"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_0_0_locker_id on "sgd0815"."locker" using btree("id");
create table "sgd0815"."manager" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null
);
alter table "sgd0815"."manager"
add constraint manager_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_manager on "sgd0815"."manager" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index manager_block_range_closed on "sgd0815"."manager"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_1_0_manager_id on "sgd0815"."manager" using btree("id");
create table "sgd0815"."aggregate" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "token_0" text not null,
    "token_1" text not null,
    "manager" text not null
);
alter table "sgd0815"."aggregate"
add constraint aggregate_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_aggregate on "sgd0815"."aggregate" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index aggregate_block_range_closed on "sgd0815"."aggregate"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_2_0_aggregate_id on "sgd0815"."aggregate" using btree("id");
create index attr_2_1_aggregate_token_0 on "sgd0815"."aggregate" using gist("token_0", block_range);
create index attr_2_2_aggregate_token_1 on "sgd0815"."aggregate" using gist("token_1", block_range);
create index attr_2_3_aggregate_manager on "sgd0815"."aggregate" using gist("manager", block_range);
create table "sgd0815"."reserve" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "liquidity" numeric not null,
    "main_token" text not null,
    "base_token" text not null,
    "pool" text not null,
    "aggregate" text not null,
    "manager" text not null,
    "lock_ids" text [] not null,
    "locker" text not null,
    "reserve_search" tsvector
);
alter table "sgd0815"."reserve"
add constraint reserve_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_reserve on "sgd0815"."reserve" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index reserve_block_range_closed on "sgd0815"."reserve"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_3_0_reserve_id on "sgd0815"."reserve" using btree("id");
create index attr_3_1_reserve_liquidity on "sgd0815"."reserve" using btree("liquidity");
create index attr_3_2_reserve_main_token on "sgd0815"."reserve" using gist("main_token", block_range);
create index attr_3_3_reserve_base_token on "sgd0815"."reserve" using gist("base_token", block_range);
create index attr_3_4_reserve_pool on "sgd0815"."reserve" using gist("pool", block_range);
create index attr_3_5_reserve_aggregate on "sgd0815"."reserve" using gist("aggregate", block_range);
create index attr_3_6_reserve_manager on "sgd0815"."reserve" using gist("manager", block_range);
create index attr_3_8_reserve_locker on "sgd0815"."reserve" using gist("locker", block_range);
create index attr_3_9_reserve_reserve_search on "sgd0815"."reserve" using gin("reserve_search");
create table "sgd0815"."pool" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "fee_tier" numeric not null,
    "token_0" text not null,
    "token_1" text not null,
    "amount_0" numeric not null,
    "amount_1" numeric not null,
    "price_0" numeric not null,
    "price_1" numeric not null,
    "active_liquidity" numeric not null,
    "sqrt_price_x96" numeric not null,
    "current_tick" numeric not null,
    "position_ids" text [] not null,
    "reserve" text not null,
    "aggregate" text not null,
    "manager" text not null,
    "pool_search" tsvector
);
alter table "sgd0815"."pool"
add constraint pool_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_pool on "sgd0815"."pool" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index pool_block_range_closed on "sgd0815"."pool"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_4_0_pool_id on "sgd0815"."pool" using btree("id");
create index attr_4_1_pool_fee_tier on "sgd0815"."pool" using btree("fee_tier");
create index attr_4_2_pool_token_0 on "sgd0815"."pool" using gist("token_0", block_range);
create index attr_4_3_pool_token_1 on "sgd0815"."pool" using gist("token_1", block_range);
create index attr_4_4_pool_amount_0 on "sgd0815"."pool" using btree("amount_0");
create index attr_4_5_pool_amount_1 on "sgd0815"."pool" using btree("amount_1");
create index attr_4_6_pool_price_0 on "sgd0815"."pool" using btree("price_0");
create index attr_4_7_pool_price_1 on "sgd0815"."pool" using btree("price_1");
create index attr_4_8_pool_active_liquidity on "sgd0815"."pool" using btree("active_liquidity");
create index attr_4_9_pool_sqrt_price_x96 on "sgd0815"."pool" using btree("sqrt_price_x96");
create index attr_4_10_pool_current_tick on "sgd0815"."pool" using btree("current_tick");
create index attr_4_12_pool_reserve on "sgd0815"."pool" using gist("reserve", block_range);
create index attr_4_13_pool_aggregate on "sgd0815"."pool" using gist("aggregate", block_range);
create index attr_4_14_pool_manager on "sgd0815"."pool" using gist("manager", block_range);
create index attr_4_15_pool_pool_search on "sgd0815"."pool" using gin("pool_search");
create table "sgd0815"."lock" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "lock_id" text not null,
    "main_token" text not null,
    "base_token" text not null,
    "locked_liquidity" numeric not null,
    "locked_amount_0" numeric not null,
    "locked_amount_1" numeric not null,
    "locked_core_usd" numeric not null,
    "locked_percent" numeric not null,
    "owner" text not null,
    "collector" text not null,
    "additional_collector" text not null,
    "unlock_date" numeric not null,
    "position" text not null,
    "reserve" text not null,
    "aggregate" text not null,
    "manager" text not null,
    "locker" text not null,
    "block_number" numeric not null,
    "timestamp" numeric not null,
    "lock_search" tsvector
);
alter table "sgd0815"."lock"
add constraint lock_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_lock on "sgd0815"."lock" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index lock_block_range_closed on "sgd0815"."lock"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_5_0_lock_id on "sgd0815"."lock" using btree("id");
create index attr_5_1_lock_lock_id on "sgd0815"."lock" using btree(left("lock_id", 256));
create index attr_5_2_lock_main_token on "sgd0815"."lock" using gist("main_token", block_range);
create index attr_5_3_lock_base_token on "sgd0815"."lock" using gist("base_token", block_range);
create index attr_5_4_lock_locked_liquidity on "sgd0815"."lock" using btree("locked_liquidity");
create index attr_5_5_lock_locked_amount_0 on "sgd0815"."lock" using btree("locked_amount_0");
create index attr_5_6_lock_locked_amount_1 on "sgd0815"."lock" using btree("locked_amount_1");
create index attr_5_7_lock_locked_core_usd on "sgd0815"."lock" using btree("locked_core_usd");
create index attr_5_8_lock_locked_percent on "sgd0815"."lock" using btree("locked_percent");
create index attr_5_9_lock_owner on "sgd0815"."lock" using gist("owner", block_range);
create index attr_5_10_lock_collector on "sgd0815"."lock" using gist("collector", block_range);
create index attr_5_11_lock_additional_collector on "sgd0815"."lock" using gist("additional_collector", block_range);
create index attr_5_12_lock_unlock_date on "sgd0815"."lock" using btree("unlock_date");
create index attr_5_13_lock_position on "sgd0815"."lock" using gist("position", block_range);
create index attr_5_14_lock_reserve on "sgd0815"."lock" using gist("reserve", block_range);
create index attr_5_15_lock_aggregate on "sgd0815"."lock" using gist("aggregate", block_range);
create index attr_5_16_lock_manager on "sgd0815"."lock" using gist("manager", block_range);
create index attr_5_17_lock_locker on "sgd0815"."lock" using gist("locker", block_range);
create index attr_5_18_lock_block_number on "sgd0815"."lock" using btree("block_number");
create index attr_5_19_lock_timestamp on "sgd0815"."lock" using btree("timestamp");
create index attr_5_20_lock_lock_search on "sgd0815"."lock" using gin("lock_search");
create table "sgd0815"."position" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "nft_id" text not null,
    "token_0" text not null,
    "token_1" text not null,
    "lower_tick" numeric not null,
    "upper_tick" numeric not null,
    "liquidity" numeric not null,
    "amount_0" numeric not null,
    "amount_1" numeric not null,
    "core_total_usd" numeric not null,
    "lock" text not null,
    "pool" text not null,
    "aggregate" text not null,
    "manager" text not null
);
alter table "sgd0815"."position"
add constraint position_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_position on "sgd0815"."position" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index position_block_range_closed on "sgd0815"."position"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_6_0_position_id on "sgd0815"."position" using btree("id");
create index attr_6_1_position_nft_id on "sgd0815"."position" using btree(left("nft_id", 256));
create index attr_6_2_position_token_0 on "sgd0815"."position" using gist("token_0", block_range);
create index attr_6_3_position_token_1 on "sgd0815"."position" using gist("token_1", block_range);
create index attr_6_4_position_lower_tick on "sgd0815"."position" using btree("lower_tick");
create index attr_6_5_position_upper_tick on "sgd0815"."position" using btree("upper_tick");
create index attr_6_6_position_liquidity on "sgd0815"."position" using btree("liquidity");
create index attr_6_7_position_amount_0 on "sgd0815"."position" using btree("amount_0");
create index attr_6_8_position_amount_1 on "sgd0815"."position" using btree("amount_1");
create index attr_6_9_position_core_total_usd on "sgd0815"."position" using btree("core_total_usd");
create index attr_6_10_position_lock on "sgd0815"."position" using gist("lock", block_range);
create index attr_6_11_position_pool on "sgd0815"."position" using gist("pool", block_range);
create index attr_6_12_position_aggregate on "sgd0815"."position" using gist("aggregate", block_range);
create index attr_6_13_position_manager on "sgd0815"."position" using gist("manager", block_range);
create table "sgd0815"."token" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "name" text not null,
    "symbol" text not null,
    "decimals" integer not null,
    "tvl_usd" numeric not null,
    "locked_usd" numeric not null,
    "block_number" numeric not null,
    "timestamp" numeric not null,
    "token_search" tsvector
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
create index attr_7_0_token_id on "sgd0815"."token" using btree("id");
create index attr_7_1_token_name on "sgd0815"."token" using btree(left("name", 256));
create index attr_7_2_token_symbol on "sgd0815"."token" using btree(left("symbol", 256));
create index attr_7_3_token_decimals on "sgd0815"."token" using btree("decimals");
create index attr_7_4_token_tvl_usd on "sgd0815"."token" using btree("tvl_usd");
create index attr_7_5_token_locked_usd on "sgd0815"."token" using btree("locked_usd");
create index attr_7_6_token_block_number on "sgd0815"."token" using btree("block_number");
create index attr_7_7_token_timestamp on "sgd0815"."token" using btree("timestamp");
create index attr_7_8_token_token_search on "sgd0815"."token" using gin("token_search");
create table "sgd0815"."base_token" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "token" text not null,
    "base_price" numeric not null,
    "last_base_updated_timestamp" numeric not null
);
alter table "sgd0815"."base_token"
add constraint base_token_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_base_token on "sgd0815"."base_token" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index base_token_block_range_closed on "sgd0815"."base_token"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_8_0_base_token_id on "sgd0815"."base_token" using btree("id");
create index attr_8_1_base_token_token on "sgd0815"."base_token" using gist("token", block_range);
create index attr_8_2_base_token_base_price on "sgd0815"."base_token" using btree("base_price");
create index attr_8_3_base_token_last_base_updated_timestamp on "sgd0815"."base_token" using btree("last_base_updated_timestamp");
create table "sgd0815"."wallet" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "wallet_search" tsvector
);
alter table "sgd0815"."wallet"
add constraint wallet_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_wallet on "sgd0815"."wallet" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index wallet_block_range_closed on "sgd0815"."wallet"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_9_0_wallet_id on "sgd0815"."wallet" using btree("id");
create index attr_9_1_wallet_wallet_search on "sgd0815"."wallet" using gin("wallet_search");
create table "sgd0815"."event_collection" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "lock_events_number" numeric not null,
    "withdraw_events_number" numeric not null,
    "increase_events_number" numeric not null,
    "relock_events_number" numeric not null,
    "transfer_ownership_events_number" numeric not null,
    "migrate_events_number" numeric not null,
    "collector_events_number" numeric not null,
    "additional_collector_events_number" numeric not null
);
alter table "sgd0815"."event_collection"
add constraint event_collection_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_event_collection on "sgd0815"."event_collection" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index event_collection_block_range_closed on "sgd0815"."event_collection"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_10_0_event_collection_id on "sgd0815"."event_collection" using btree("id");
create index attr_10_1_event_collection_lock_events_number on "sgd0815"."event_collection" using btree("lock_events_number");
create index attr_10_2_event_collection_withdraw_events_number on "sgd0815"."event_collection" using btree("withdraw_events_number");
create index attr_10_3_event_collection_increase_events_number on "sgd0815"."event_collection" using btree("increase_events_number");
create index attr_10_4_event_collection_relock_events_number on "sgd0815"."event_collection" using btree("relock_events_number");
create index attr_10_5_event_collection_transfer_ownership_events_number on "sgd0815"."event_collection" using btree("transfer_ownership_events_number");
create index attr_10_6_event_collection_migrate_events_number on "sgd0815"."event_collection" using btree("migrate_events_number");
create index attr_10_7_event_collection_collector_events_number on "sgd0815"."event_collection" using btree("collector_events_number");
create index attr_10_8_event_collection_additional_collector_events_number on "sgd0815"."event_collection" using btree("additional_collector_events_number");
create table "sgd0815"."lock_event" (
    vid bigserial primary key,
    block $ int not null,
    "id" text not null,
    "lock_id" text not null,
    "main_token" text not null,
    "base_token" text not null,
    "locked_liquidity" numeric not null,
    "locked_amount_0" numeric not null,
    "locked_amount_1" numeric not null,
    "locked_core_usd" numeric not null,
    "locked_percent" numeric not null,
    "owner" text not null,
    "collector" text not null,
    "additional_collector" text not null,
    "position" text,
    "lock" text,
    "reserve" text not null,
    "aggregate" text not null,
    "manager" text not null,
    "locker" text not null,
    "unlock_date" numeric not null,
    "block_number" numeric not null,
    "timestamp" numeric not null,
    "transaction" bytea not null,
    "events_collection" text not null,
    unique(id)
);
create index brin_lock_event on "sgd0815"."lock_event" using brin(block $ int4_minmax_ops, vid int8_minmax_ops);
create index attr_11_0_lock_event_lock_id on "sgd0815"."lock_event" using btree(left("lock_id", 256));
create index attr_11_1_lock_event_main_token on "sgd0815"."lock_event" using btree("main_token", block $);
create index attr_11_2_lock_event_base_token on "sgd0815"."lock_event" using btree("base_token", block $);
create index attr_11_3_lock_event_locked_liquidity on "sgd0815"."lock_event" using btree("locked_liquidity");
create index attr_11_4_lock_event_locked_amount_0 on "sgd0815"."lock_event" using btree("locked_amount_0");
create index attr_11_5_lock_event_locked_amount_1 on "sgd0815"."lock_event" using btree("locked_amount_1");
create index attr_11_6_lock_event_locked_core_usd on "sgd0815"."lock_event" using btree("locked_core_usd");
create index attr_11_7_lock_event_locked_percent on "sgd0815"."lock_event" using btree("locked_percent");
create index attr_11_8_lock_event_owner on "sgd0815"."lock_event" using btree("owner", block $);
create index attr_11_9_lock_event_collector on "sgd0815"."lock_event" using btree("collector", block $);
create index attr_11_10_lock_event_additional_collector on "sgd0815"."lock_event" using btree("additional_collector", block $);
create index attr_11_11_lock_event_position on "sgd0815"."lock_event" using btree("position", block $);
create index attr_11_12_lock_event_lock on "sgd0815"."lock_event" using btree("lock", block $);
create index attr_11_13_lock_event_reserve on "sgd0815"."lock_event" using btree("reserve", block $);
create index attr_11_14_lock_event_aggregate on "sgd0815"."lock_event" using btree("aggregate", block $);
create index attr_11_15_lock_event_manager on "sgd0815"."lock_event" using btree("manager", block $);
create index attr_11_16_lock_event_locker on "sgd0815"."lock_event" using btree("locker", block $);
create index attr_11_17_lock_event_unlock_date on "sgd0815"."lock_event" using btree("unlock_date");
create index attr_11_18_lock_event_block_number on "sgd0815"."lock_event" using btree("block_number");
create index attr_11_19_lock_event_timestamp on "sgd0815"."lock_event" using btree("timestamp");
create index attr_11_20_lock_event_transaction on "sgd0815"."lock_event" using btree(substring("transaction", 1, 64));
create index attr_11_21_lock_event_events_collection on "sgd0815"."lock_event" using btree("events_collection", block $);
create table "sgd0815"."withdraw_event" (
    vid bigserial primary key,
    block $ int not null,
    "id" text not null,
    "lock_id" text not null,
    "main_token" text not null,
    "base_token" text not null,
    "withdrawn_liquidity" numeric not null,
    "withdrawn_amount_0" numeric not null,
    "withdrawn_amount_1" numeric not null,
    "withdrawn_core_usd" numeric not null,
    "withdrawn_percent" numeric not null,
    "owner" text not null,
    "collector" text not null,
    "additional_collector" text not null,
    "position" text,
    "lock" text,
    "reserve" text not null,
    "aggregate" text not null,
    "manager" text not null,
    "locker" text not null,
    "unlock_date" numeric not null,
    "block_number" numeric not null,
    "timestamp" numeric not null,
    "transaction" bytea not null,
    "events_collection" text not null,
    unique(id)
);
create index brin_withdraw_event on "sgd0815"."withdraw_event" using brin(block $ int4_minmax_ops, vid int8_minmax_ops);
create index attr_12_0_withdraw_event_lock_id on "sgd0815"."withdraw_event" using btree(left("lock_id", 256));
create index attr_12_1_withdraw_event_main_token on "sgd0815"."withdraw_event" using btree("main_token", block $);
create index attr_12_2_withdraw_event_base_token on "sgd0815"."withdraw_event" using btree("base_token", block $);
create index attr_12_3_withdraw_event_withdrawn_liquidity on "sgd0815"."withdraw_event" using btree("withdrawn_liquidity");
create index attr_12_4_withdraw_event_withdrawn_amount_0 on "sgd0815"."withdraw_event" using btree("withdrawn_amount_0");
create index attr_12_5_withdraw_event_withdrawn_amount_1 on "sgd0815"."withdraw_event" using btree("withdrawn_amount_1");
create index attr_12_6_withdraw_event_withdrawn_core_usd on "sgd0815"."withdraw_event" using btree("withdrawn_core_usd");
create index attr_12_7_withdraw_event_withdrawn_percent on "sgd0815"."withdraw_event" using btree("withdrawn_percent");
create index attr_12_8_withdraw_event_owner on "sgd0815"."withdraw_event" using btree("owner", block $);
create index attr_12_9_withdraw_event_collector on "sgd0815"."withdraw_event" using btree("collector", block $);
create index attr_12_10_withdraw_event_additional_collector on "sgd0815"."withdraw_event" using btree("additional_collector", block $);
create index attr_12_11_withdraw_event_position on "sgd0815"."withdraw_event" using btree("position", block $);
create index attr_12_12_withdraw_event_lock on "sgd0815"."withdraw_event" using btree("lock", block $);
create index attr_12_13_withdraw_event_reserve on "sgd0815"."withdraw_event" using btree("reserve", block $);
create index attr_12_14_withdraw_event_aggregate on "sgd0815"."withdraw_event" using btree("aggregate", block $);
create index attr_12_15_withdraw_event_manager on "sgd0815"."withdraw_event" using btree("manager", block $);
create index attr_12_16_withdraw_event_locker on "sgd0815"."withdraw_event" using btree("locker", block $);
create index attr_12_17_withdraw_event_unlock_date on "sgd0815"."withdraw_event" using btree("unlock_date");
create index attr_12_18_withdraw_event_block_number on "sgd0815"."withdraw_event" using btree("block_number");
create index attr_12_19_withdraw_event_timestamp on "sgd0815"."withdraw_event" using btree("timestamp");
create index attr_12_20_withdraw_event_transaction on "sgd0815"."withdraw_event" using btree(substring("transaction", 1, 64));
create index attr_12_21_withdraw_event_events_collection on "sgd0815"."withdraw_event" using btree("events_collection", block $);
create table "sgd0815"."increase_event" (
    vid bigserial primary key,
    block $ int not null,
    "id" text not null,
    "lock_id" text not null,
    "main_token" text not null,
    "base_token" text not null,
    "locked_liquidity_before" numeric not null,
    "locked_amount_0_before" numeric not null,
    "locked_amount_1_before" numeric not null,
    "locked_core_usd_before" numeric not null,
    "locked_percent_before" numeric not null,
    "locked_liquidity_after" numeric not null,
    "locked_amount_0_after" numeric not null,
    "locked_amount_1_after" numeric not null,
    "locked_core_usd_after" numeric not null,
    "locked_percent_after" numeric not null,
    "owner" text not null,
    "collector" text not null,
    "additional_collector" text not null,
    "position" text,
    "lock" text,
    "reserve" text not null,
    "aggregate" text not null,
    "manager" text not null,
    "locker" text not null,
    "unlock_date" numeric not null,
    "block_number" numeric not null,
    "timestamp" numeric not null,
    "transaction" bytea not null,
    "events_collection" text not null,
    unique(id)
);
create index brin_increase_event on "sgd0815"."increase_event" using brin(block $ int4_minmax_ops, vid int8_minmax_ops);
create index attr_13_0_increase_event_lock_id on "sgd0815"."increase_event" using btree(left("lock_id", 256));
create index attr_13_1_increase_event_main_token on "sgd0815"."increase_event" using btree("main_token", block $);
create index attr_13_2_increase_event_base_token on "sgd0815"."increase_event" using btree("base_token", block $);
create index attr_13_3_increase_event_locked_liquidity_before on "sgd0815"."increase_event" using btree("locked_liquidity_before");
create index attr_13_4_increase_event_locked_amount_0_before on "sgd0815"."increase_event" using btree("locked_amount_0_before");
create index attr_13_5_increase_event_locked_amount_1_before on "sgd0815"."increase_event" using btree("locked_amount_1_before");
create index attr_13_6_increase_event_locked_core_usd_before on "sgd0815"."increase_event" using btree("locked_core_usd_before");
create index attr_13_7_increase_event_locked_percent_before on "sgd0815"."increase_event" using btree("locked_percent_before");
create index attr_13_8_increase_event_locked_liquidity_after on "sgd0815"."increase_event" using btree("locked_liquidity_after");
create index attr_13_9_increase_event_locked_amount_0_after on "sgd0815"."increase_event" using btree("locked_amount_0_after");
create index attr_13_10_increase_event_locked_amount_1_after on "sgd0815"."increase_event" using btree("locked_amount_1_after");
create index attr_13_11_increase_event_locked_core_usd_after on "sgd0815"."increase_event" using btree("locked_core_usd_after");
create index attr_13_12_increase_event_locked_percent_after on "sgd0815"."increase_event" using btree("locked_percent_after");
create index attr_13_13_increase_event_owner on "sgd0815"."increase_event" using btree("owner", block $);
create index attr_13_14_increase_event_collector on "sgd0815"."increase_event" using btree("collector", block $);
create index attr_13_15_increase_event_additional_collector on "sgd0815"."increase_event" using btree("additional_collector", block $);
create index attr_13_16_increase_event_position on "sgd0815"."increase_event" using btree("position", block $);
create index attr_13_17_increase_event_lock on "sgd0815"."increase_event" using btree("lock", block $);
create index attr_13_18_increase_event_reserve on "sgd0815"."increase_event" using btree("reserve", block $);
create index attr_13_19_increase_event_aggregate on "sgd0815"."increase_event" using btree("aggregate", block $);
create index attr_13_20_increase_event_manager on "sgd0815"."increase_event" using btree("manager", block $);
create index attr_13_21_increase_event_locker on "sgd0815"."increase_event" using btree("locker", block $);
create index attr_13_22_increase_event_unlock_date on "sgd0815"."increase_event" using btree("unlock_date");
create index attr_13_23_increase_event_block_number on "sgd0815"."increase_event" using btree("block_number");
create index attr_13_24_increase_event_timestamp on "sgd0815"."increase_event" using btree("timestamp");
create index attr_13_25_increase_event_transaction on "sgd0815"."increase_event" using btree(substring("transaction", 1, 64));
create index attr_13_26_increase_event_events_collection on "sgd0815"."increase_event" using btree("events_collection", block $);
create table "sgd0815"."relock_event" (
    vid bigserial primary key,
    block $ int not null,
    "id" text not null,
    "lock_id" text not null,
    "main_token" text not null,
    "base_token" text not null,
    "locked_liquidity" numeric not null,
    "locked_amount_0" numeric not null,
    "locked_amount_1" numeric not null,
    "locked_core_usd" numeric not null,
    "locked_percent" numeric not null,
    "owner" text not null,
    "collector" text not null,
    "additional_collector" text not null,
    "position" text,
    "lock" text,
    "reserve" text not null,
    "aggregate" text not null,
    "manager" text not null,
    "locker" text not null,
    "unlock_date_before" numeric not null,
    "unlock_date_after" numeric not null,
    "block_number" numeric not null,
    "timestamp" numeric not null,
    "transaction" bytea not null,
    "events_collection" text not null,
    unique(id)
);
create index brin_relock_event on "sgd0815"."relock_event" using brin(block $ int4_minmax_ops, vid int8_minmax_ops);
create index attr_14_0_relock_event_lock_id on "sgd0815"."relock_event" using btree(left("lock_id", 256));
create index attr_14_1_relock_event_main_token on "sgd0815"."relock_event" using btree("main_token", block $);
create index attr_14_2_relock_event_base_token on "sgd0815"."relock_event" using btree("base_token", block $);
create index attr_14_3_relock_event_locked_liquidity on "sgd0815"."relock_event" using btree("locked_liquidity");
create index attr_14_4_relock_event_locked_amount_0 on "sgd0815"."relock_event" using btree("locked_amount_0");
create index attr_14_5_relock_event_locked_amount_1 on "sgd0815"."relock_event" using btree("locked_amount_1");
create index attr_14_6_relock_event_locked_core_usd on "sgd0815"."relock_event" using btree("locked_core_usd");
create index attr_14_7_relock_event_locked_percent on "sgd0815"."relock_event" using btree("locked_percent");
create index attr_14_8_relock_event_owner on "sgd0815"."relock_event" using btree("owner", block $);
create index attr_14_9_relock_event_collector on "sgd0815"."relock_event" using btree("collector", block $);
create index attr_14_10_relock_event_additional_collector on "sgd0815"."relock_event" using btree("additional_collector", block $);
create index attr_14_11_relock_event_position on "sgd0815"."relock_event" using btree("position", block $);
create index attr_14_12_relock_event_lock on "sgd0815"."relock_event" using btree("lock", block $);
create index attr_14_13_relock_event_reserve on "sgd0815"."relock_event" using btree("reserve", block $);
create index attr_14_14_relock_event_aggregate on "sgd0815"."relock_event" using btree("aggregate", block $);
create index attr_14_15_relock_event_manager on "sgd0815"."relock_event" using btree("manager", block $);
create index attr_14_16_relock_event_locker on "sgd0815"."relock_event" using btree("locker", block $);
create index attr_14_17_relock_event_unlock_date_before on "sgd0815"."relock_event" using btree("unlock_date_before");
create index attr_14_18_relock_event_unlock_date_after on "sgd0815"."relock_event" using btree("unlock_date_after");
create index attr_14_19_relock_event_block_number on "sgd0815"."relock_event" using btree("block_number");
create index attr_14_20_relock_event_timestamp on "sgd0815"."relock_event" using btree("timestamp");
create index attr_14_21_relock_event_transaction on "sgd0815"."relock_event" using btree(substring("transaction", 1, 64));
create index attr_14_22_relock_event_events_collection on "sgd0815"."relock_event" using btree("events_collection", block $);
create table "sgd0815"."transfer_ownership_event" (
    vid bigserial primary key,
    block $ int not null,
    "id" text not null,
    "lock_id" text not null,
    "main_token" text not null,
    "base_token" text not null,
    "locked_liquidity" numeric not null,
    "locked_amount_0" numeric not null,
    "locked_amount_1" numeric not null,
    "locked_core_usd" numeric not null,
    "locked_percent" numeric not null,
    "owner_before" text not null,
    "owner_after" text not null,
    "collector" text not null,
    "additional_collector" text not null,
    "position" text,
    "lock" text,
    "reserve" text not null,
    "aggregate" text not null,
    "manager" text not null,
    "locker" text not null,
    "unlock_date" numeric not null,
    "block_number" numeric not null,
    "timestamp" numeric not null,
    "transaction" bytea not null,
    "events_collection" text not null,
    unique(id)
);
create index brin_transfer_ownership_event on "sgd0815"."transfer_ownership_event" using brin(block $ int4_minmax_ops, vid int8_minmax_ops);
create index attr_15_0_transfer_ownership_event_lock_id on "sgd0815"."transfer_ownership_event" using btree(left("lock_id", 256));
create index attr_15_1_transfer_ownership_event_main_token on "sgd0815"."transfer_ownership_event" using btree("main_token", block $);
create index attr_15_2_transfer_ownership_event_base_token on "sgd0815"."transfer_ownership_event" using btree("base_token", block $);
create index attr_15_3_transfer_ownership_event_locked_liquidity on "sgd0815"."transfer_ownership_event" using btree("locked_liquidity");
create index attr_15_4_transfer_ownership_event_locked_amount_0 on "sgd0815"."transfer_ownership_event" using btree("locked_amount_0");
create index attr_15_5_transfer_ownership_event_locked_amount_1 on "sgd0815"."transfer_ownership_event" using btree("locked_amount_1");
create index attr_15_6_transfer_ownership_event_locked_core_usd on "sgd0815"."transfer_ownership_event" using btree("locked_core_usd");
create index attr_15_7_transfer_ownership_event_locked_percent on "sgd0815"."transfer_ownership_event" using btree("locked_percent");
create index attr_15_8_transfer_ownership_event_owner_before on "sgd0815"."transfer_ownership_event" using btree("owner_before", block $);
create index attr_15_9_transfer_ownership_event_owner_after on "sgd0815"."transfer_ownership_event" using btree("owner_after", block $);
create index attr_15_10_transfer_ownership_event_collector on "sgd0815"."transfer_ownership_event" using btree("collector", block $);
create index attr_15_11_transfer_ownership_event_additional_collector on "sgd0815"."transfer_ownership_event" using btree("additional_collector", block $);
create index attr_15_12_transfer_ownership_event_position on "sgd0815"."transfer_ownership_event" using btree("position", block $);
create index attr_15_13_transfer_ownership_event_lock on "sgd0815"."transfer_ownership_event" using btree("lock", block $);
create index attr_15_14_transfer_ownership_event_reserve on "sgd0815"."transfer_ownership_event" using btree("reserve", block $);
create index attr_15_15_transfer_ownership_event_aggregate on "sgd0815"."transfer_ownership_event" using btree("aggregate", block $);
create index attr_15_16_transfer_ownership_event_manager on "sgd0815"."transfer_ownership_event" using btree("manager", block $);
create index attr_15_17_transfer_ownership_event_locker on "sgd0815"."transfer_ownership_event" using btree("locker", block $);
create index attr_15_18_transfer_ownership_event_unlock_date on "sgd0815"."transfer_ownership_event" using btree("unlock_date");
create index attr_15_19_transfer_ownership_event_block_number on "sgd0815"."transfer_ownership_event" using btree("block_number");
create index attr_15_20_transfer_ownership_event_timestamp on "sgd0815"."transfer_ownership_event" using btree("timestamp");
create index attr_15_21_transfer_ownership_event_transaction on "sgd0815"."transfer_ownership_event" using btree(substring("transaction", 1, 64));
create index attr_15_22_transfer_ownership_event_events_collection on "sgd0815"."transfer_ownership_event" using btree("events_collection", block $);
create table "sgd0815"."migrate_event" (
    vid bigserial primary key,
    block $ int not null,
    "id" text not null,
    "lock_id" text not null,
    "main_token" text not null,
    "base_token" text not null,
    "locked_liquidity" numeric not null,
    "locked_amount_0" numeric not null,
    "locked_amount_1" numeric not null,
    "locked_core_usd" numeric not null,
    "locked_percent" numeric not null,
    "owner" text not null,
    "collector" text not null,
    "additional_collector" text not null,
    "position" text,
    "lock" text,
    "reserve" text not null,
    "aggregate" text not null,
    "manager" text not null,
    "locker" text not null,
    "unlock_date" numeric not null,
    "block_number" numeric not null,
    "timestamp" numeric not null,
    "transaction" bytea not null,
    "events_collection" text not null,
    unique(id)
);
create index brin_migrate_event on "sgd0815"."migrate_event" using brin(block $ int4_minmax_ops, vid int8_minmax_ops);
create index attr_16_0_migrate_event_lock_id on "sgd0815"."migrate_event" using btree(left("lock_id", 256));
create index attr_16_1_migrate_event_main_token on "sgd0815"."migrate_event" using btree("main_token", block $);
create index attr_16_2_migrate_event_base_token on "sgd0815"."migrate_event" using btree("base_token", block $);
create index attr_16_3_migrate_event_locked_liquidity on "sgd0815"."migrate_event" using btree("locked_liquidity");
create index attr_16_4_migrate_event_locked_amount_0 on "sgd0815"."migrate_event" using btree("locked_amount_0");
create index attr_16_5_migrate_event_locked_amount_1 on "sgd0815"."migrate_event" using btree("locked_amount_1");
create index attr_16_6_migrate_event_locked_core_usd on "sgd0815"."migrate_event" using btree("locked_core_usd");
create index attr_16_7_migrate_event_locked_percent on "sgd0815"."migrate_event" using btree("locked_percent");
create index attr_16_8_migrate_event_owner on "sgd0815"."migrate_event" using btree("owner", block $);
create index attr_16_9_migrate_event_collector on "sgd0815"."migrate_event" using btree("collector", block $);
create index attr_16_10_migrate_event_additional_collector on "sgd0815"."migrate_event" using btree("additional_collector", block $);
create index attr_16_11_migrate_event_position on "sgd0815"."migrate_event" using btree("position", block $);
create index attr_16_12_migrate_event_lock on "sgd0815"."migrate_event" using btree("lock", block $);
create index attr_16_13_migrate_event_reserve on "sgd0815"."migrate_event" using btree("reserve", block $);
create index attr_16_14_migrate_event_aggregate on "sgd0815"."migrate_event" using btree("aggregate", block $);
create index attr_16_15_migrate_event_manager on "sgd0815"."migrate_event" using btree("manager", block $);
create index attr_16_16_migrate_event_locker on "sgd0815"."migrate_event" using btree("locker", block $);
create index attr_16_17_migrate_event_unlock_date on "sgd0815"."migrate_event" using btree("unlock_date");
create index attr_16_18_migrate_event_block_number on "sgd0815"."migrate_event" using btree("block_number");
create index attr_16_19_migrate_event_timestamp on "sgd0815"."migrate_event" using btree("timestamp");
create index attr_16_20_migrate_event_transaction on "sgd0815"."migrate_event" using btree(substring("transaction", 1, 64));
create index attr_16_21_migrate_event_events_collection on "sgd0815"."migrate_event" using btree("events_collection", block $);
create table "sgd0815"."collector_event" (
    vid bigserial primary key,
    block $ int not null,
    "id" text not null,
    "lock_id" text not null,
    "main_token" text not null,
    "base_token" text not null,
    "locked_liquidity" numeric not null,
    "locked_amount_0" numeric not null,
    "locked_amount_1" numeric not null,
    "locked_core_usd" numeric not null,
    "locked_percent" numeric not null,
    "owner" text not null,
    "collector_before" text not null,
    "collector_after" text not null,
    "additional_collector" text not null,
    "position" text,
    "lock" text,
    "reserve" text not null,
    "aggregate" text not null,
    "manager" text not null,
    "locker" text not null,
    "unlock_date" numeric not null,
    "block_number" numeric not null,
    "timestamp" numeric not null,
    "transaction" bytea not null,
    "events_collection" text not null,
    unique(id)
);
create index brin_collector_event on "sgd0815"."collector_event" using brin(block $ int4_minmax_ops, vid int8_minmax_ops);
create index attr_17_0_collector_event_lock_id on "sgd0815"."collector_event" using btree(left("lock_id", 256));
create index attr_17_1_collector_event_main_token on "sgd0815"."collector_event" using btree("main_token", block $);
create index attr_17_2_collector_event_base_token on "sgd0815"."collector_event" using btree("base_token", block $);
create index attr_17_3_collector_event_locked_liquidity on "sgd0815"."collector_event" using btree("locked_liquidity");
create index attr_17_4_collector_event_locked_amount_0 on "sgd0815"."collector_event" using btree("locked_amount_0");
create index attr_17_5_collector_event_locked_amount_1 on "sgd0815"."collector_event" using btree("locked_amount_1");
create index attr_17_6_collector_event_locked_core_usd on "sgd0815"."collector_event" using btree("locked_core_usd");
create index attr_17_7_collector_event_locked_percent on "sgd0815"."collector_event" using btree("locked_percent");
create index attr_17_8_collector_event_owner on "sgd0815"."collector_event" using btree("owner", block $);
create index attr_17_9_collector_event_collector_before on "sgd0815"."collector_event" using btree("collector_before", block $);
create index attr_17_10_collector_event_collector_after on "sgd0815"."collector_event" using btree("collector_after", block $);
create index attr_17_11_collector_event_additional_collector on "sgd0815"."collector_event" using btree("additional_collector", block $);
create index attr_17_12_collector_event_position on "sgd0815"."collector_event" using btree("position", block $);
create index attr_17_13_collector_event_lock on "sgd0815"."collector_event" using btree("lock", block $);
create index attr_17_14_collector_event_reserve on "sgd0815"."collector_event" using btree("reserve", block $);
create index attr_17_15_collector_event_aggregate on "sgd0815"."collector_event" using btree("aggregate", block $);
create index attr_17_16_collector_event_manager on "sgd0815"."collector_event" using btree("manager", block $);
create index attr_17_17_collector_event_locker on "sgd0815"."collector_event" using btree("locker", block $);
create index attr_17_18_collector_event_unlock_date on "sgd0815"."collector_event" using btree("unlock_date");
create index attr_17_19_collector_event_block_number on "sgd0815"."collector_event" using btree("block_number");
create index attr_17_20_collector_event_timestamp on "sgd0815"."collector_event" using btree("timestamp");
create index attr_17_21_collector_event_transaction on "sgd0815"."collector_event" using btree(substring("transaction", 1, 64));
create index attr_17_22_collector_event_events_collection on "sgd0815"."collector_event" using btree("events_collection", block $);
create table "sgd0815"."additional_collector_event" (
    vid bigserial primary key,
    block $ int not null,
    "id" text not null,
    "lock_id" text not null,
    "main_token" text not null,
    "base_token" text not null,
    "locked_liquidity" numeric not null,
    "locked_amount_0" numeric not null,
    "locked_amount_1" numeric not null,
    "locked_core_usd" numeric not null,
    "locked_percent" numeric not null,
    "owner" text not null,
    "collector" text not null,
    "additional_collector_before" text not null,
    "additional_collector_after" text not null,
    "position" text,
    "lock" text,
    "reserve" text not null,
    "aggregate" text not null,
    "manager" text not null,
    "locker" text not null,
    "unlock_date" numeric not null,
    "block_number" numeric not null,
    "timestamp" numeric not null,
    "transaction" bytea not null,
    "events_collection" text not null,
    unique(id)
);
create index brin_additional_collector_event on "sgd0815"."additional_collector_event" using brin(block $ int4_minmax_ops, vid int8_minmax_ops);
create index attr_18_0_additional_collector_event_lock_id on "sgd0815"."additional_collector_event" using btree(left("lock_id", 256));
create index attr_18_1_additional_collector_event_main_token on "sgd0815"."additional_collector_event" using btree("main_token", block $);
create index attr_18_2_additional_collector_event_base_token on "sgd0815"."additional_collector_event" using btree("base_token", block $);
create index attr_18_3_additional_collector_event_locked_liquidity on "sgd0815"."additional_collector_event" using btree("locked_liquidity");
create index attr_18_4_additional_collector_event_locked_amount_0 on "sgd0815"."additional_collector_event" using btree("locked_amount_0");
create index attr_18_5_additional_collector_event_locked_amount_1 on "sgd0815"."additional_collector_event" using btree("locked_amount_1");
create index attr_18_6_additional_collector_event_locked_core_usd on "sgd0815"."additional_collector_event" using btree("locked_core_usd");
create index attr_18_7_additional_collector_event_locked_percent on "sgd0815"."additional_collector_event" using btree("locked_percent");
create index attr_18_8_additional_collector_event_owner on "sgd0815"."additional_collector_event" using btree("owner", block $);
create index attr_18_9_additional_collector_event_collector on "sgd0815"."additional_collector_event" using btree("collector", block $);
create index attr_18_10_additional_collector_event_additional_collector_before on "sgd0815"."additional_collector_event" using btree("additional_collector_before", block $);
create index attr_18_11_additional_collector_event_additional_collector_after on "sgd0815"."additional_collector_event" using btree("additional_collector_after", block $);
create index attr_18_12_additional_collector_event_position on "sgd0815"."additional_collector_event" using btree("position", block $);
create index attr_18_13_additional_collector_event_lock on "sgd0815"."additional_collector_event" using btree("lock", block $);
create index attr_18_14_additional_collector_event_reserve on "sgd0815"."additional_collector_event" using btree("reserve", block $);
create index attr_18_15_additional_collector_event_aggregate on "sgd0815"."additional_collector_event" using btree("aggregate", block $);
create index attr_18_16_additional_collector_event_manager running 1 test create table "sgd0815"."locker" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null
);
alter table "sgd0815"."locker"
add constraint locker_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_locker on "sgd0815"."locker" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index locker_block_range_closed on "sgd0815"."locker"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_0_0_locker_id on "sgd0815"."locker" using btree("id");
create table "sgd0815"."manager" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null
);
alter table "sgd0815"."manager"
add constraint manager_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_manager on "sgd0815"."manager" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index manager_block_range_closed on "sgd0815"."manager"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_1_0_manager_id on "sgd0815"."manager" using btree("id");
create table "sgd0815"."aggregate" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "token_0" text not null,
    "token_1" text not null,
    "manager" text not null
);
alter table "sgd0815"."aggregate"
add constraint aggregate_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_aggregate on "sgd0815"."aggregate" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index aggregate_block_range_closed on "sgd0815"."aggregate"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_2_0_aggregate_id on "sgd0815"."aggregate" using btree("id");
create index attr_2_1_aggregate_token_0 on "sgd0815"."aggregate" using gist("token_0", block_range);
create index attr_2_2_aggregate_token_1 on "sgd0815"."aggregate" using gist("token_1", block_range);
create index attr_2_3_aggregate_manager on "sgd0815"."aggregate" using gist("manager", block_range);
create table "sgd0815"."reserve" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "liquidity" numeric not null,
    "main_token" text not null,
    "base_token" text not null,
    "pool" text not null,
    "aggregate" text not null,
    "manager" text not null,
    "lock_ids" text [] not null,
    "locker" text not null,
    "reserve_search" tsvector
);
alter table "sgd0815"."reserve"
add constraint reserve_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_reserve on "sgd0815"."reserve" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index reserve_block_range_closed on "sgd0815"."reserve"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_3_0_reserve_id on "sgd0815"."reserve" using btree("id");
create index attr_3_1_reserve_liquidity on "sgd0815"."reserve" using btree("liquidity");
create index attr_3_2_reserve_main_token on "sgd0815"."reserve" using gist("main_token", block_range);
create index attr_3_3_reserve_base_token on "sgd0815"."reserve" using gist("base_token", block_range);
create index attr_3_4_reserve_pool on "sgd0815"."reserve" using gist("pool", block_range);
create index attr_3_5_reserve_aggregate on "sgd0815"."reserve" using gist("aggregate", block_range);
create index attr_3_6_reserve_manager on "sgd0815"."reserve" using gist("manager", block_range);
create index attr_3_8_reserve_locker on "sgd0815"."reserve" using gist("locker", block_range);
create index attr_3_9_reserve_reserve_search on "sgd0815"."reserve" using gin("reserve_search");
create table "sgd0815"."pool" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "fee_tier" numeric not null,
    "token_0" text not null,
    "token_1" text not null,
    "amount_0" numeric not null,
    "amount_1" numeric not null,
    "price_0" numeric not null,
    "price_1" numeric not null,
    "active_liquidity" numeric not null,
    "sqrt_price_x96" numeric not null,
    "current_tick" numeric not null,
    "position_ids" text [] not null,
    "reserve" text not null,
    "aggregate" text not null,
    "manager" text not null,
    "pool_search" tsvector
);
alter table "sgd0815"."pool"
add constraint pool_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_pool on "sgd0815"."pool" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index pool_block_range_closed on "sgd0815"."pool"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_4_0_pool_id on "sgd0815"."pool" using btree("id");
create index attr_4_1_pool_fee_tier on "sgd0815"."pool" using btree("fee_tier");
create index attr_4_2_pool_token_0 on "sgd0815"."pool" using gist("token_0", block_range);
create index attr_4_3_pool_token_1 on "sgd0815"."pool" using gist("token_1", block_range);
create index attr_4_4_pool_amount_0 on "sgd0815"."pool" using btree("amount_0");
create index attr_4_5_pool_amount_1 on "sgd0815"."pool" using btree("amount_1");
create index attr_4_6_pool_price_0 on "sgd0815"."pool" using btree("price_0");
create index attr_4_7_pool_price_1 on "sgd0815"."pool" using btree("price_1");
create index attr_4_8_pool_active_liquidity on "sgd0815"."pool" using btree("active_liquidity");
create index attr_4_9_pool_sqrt_price_x96 on "sgd0815"."pool" using btree("sqrt_price_x96");
create index attr_4_10_pool_current_tick on "sgd0815"."pool" using btree("current_tick");
create index attr_4_12_pool_reserve on "sgd0815"."pool" using gist("reserve", block_range);
create index attr_4_13_pool_aggregate on "sgd0815"."pool" using gist("aggregate", block_range);
create index attr_4_14_pool_manager on "sgd0815"."pool" using gist("manager", block_range);
create index attr_4_15_pool_pool_search on "sgd0815"."pool" using gin("pool_search");
create table "sgd0815"."lock" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "lock_id" text not null,
    "main_token" text not null,
    "base_token" text not null,
    "locked_liquidity" numeric not null,
    "locked_amount_0" numeric not null,
    "locked_amount_1" numeric not null,
    "locked_core_usd" numeric not null,
    "locked_percent" numeric not null,
    "owner" text not null,
    "collector" text not null,
    "additional_collector" text not null,
    "unlock_date" numeric not null,
    "position" text not null,
    "reserve" text not null,
    "aggregate" text not null,
    "manager" text not null,
    "locker" text not null,
    "block_number" numeric not null,
    "timestamp" numeric not null,
    "lock_search" tsvector
);
alter table "sgd0815"."lock"
add constraint lock_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_lock on "sgd0815"."lock" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index lock_block_range_closed on "sgd0815"."lock"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_5_0_lock_id on "sgd0815"."lock" using btree("id");
create index attr_5_1_lock_lock_id on "sgd0815"."lock" using btree(left("lock_id", 256));
create index attr_5_2_lock_main_token on "sgd0815"."lock" using gist("main_token", block_range);
create index attr_5_3_lock_base_token on "sgd0815"."lock" using gist("base_token", block_range);
create index attr_5_4_lock_locked_liquidity on "sgd0815"."lock" using btree("locked_liquidity");
create index attr_5_5_lock_locked_amount_0 on "sgd0815"."lock" using btree("locked_amount_0");
create index attr_5_6_lock_locked_amount_1 on "sgd0815"."lock" using btree("locked_amount_1");
create index attr_5_7_lock_locked_core_usd on "sgd0815"."lock" using btree("locked_core_usd");
create index attr_5_8_lock_locked_percent on "sgd0815"."lock" using btree("locked_percent");
create index attr_5_9_lock_owner on "sgd0815"."lock" using gist("owner", block_range);
create index attr_5_10_lock_collector on "sgd0815"."lock" using gist("collector", block_range);
create index attr_5_11_lock_additional_collector on "sgd0815"."lock" using gist("additional_collector", block_range);
create index attr_5_12_lock_unlock_date on "sgd0815"."lock" using btree("unlock_date");
create index attr_5_13_lock_position on "sgd0815"."lock" using gist("position", block_range);
create index attr_5_14_lock_reserve on "sgd0815"."lock" using gist("reserve", block_range);
create index attr_5_15_lock_aggregate on "sgd0815"."lock" using gist("aggregate", block_range);
create index attr_5_16_lock_manager on "sgd0815"."lock" using gist("manager", block_range);
create index attr_5_17_lock_locker on "sgd0815"."lock" using gist("locker", block_range);
create index attr_5_18_lock_block_number on "sgd0815"."lock" using btree("block_number");
create index attr_5_19_lock_timestamp on "sgd0815"."lock" using btree("timestamp");
create index attr_5_20_lock_lock_search on "sgd0815"."lock" using gin("lock_search");
create table "sgd0815"."position" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "nft_id" text not null,
    "token_0" text not null,
    "token_1" text not null,
    "lower_tick" numeric not null,
    "upper_tick" numeric not null,
    "liquidity" numeric not null,
    "amount_0" numeric not null,
    "amount_1" numeric not null,
    "core_total_usd" numeric not null,
    "lock" text not null,
    "pool" text not null,
    "aggregate" text not null,
    "manager" text not null
);
alter table "sgd0815"."position"
add constraint position_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_position on "sgd0815"."position" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index position_block_range_closed on "sgd0815"."position"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_6_0_position_id on "sgd0815"."position" using btree("id");
create index attr_6_1_position_nft_id on "sgd0815"."position" using btree(left("nft_id", 256));
create index attr_6_2_position_token_0 on "sgd0815"."position" using gist("token_0", block_range);
create index attr_6_3_position_token_1 on "sgd0815"."position" using gist("token_1", block_range);
create index attr_6_4_position_lower_tick on "sgd0815"."position" using btree("lower_tick");
create index attr_6_5_position_upper_tick on "sgd0815"."position" using btree("upper_tick");
create index attr_6_6_position_liquidity on "sgd0815"."position" using btree("liquidity");
create index attr_6_7_position_amount_0 on "sgd0815"."position" using btree("amount_0");
create index attr_6_8_position_amount_1 on "sgd0815"."position" using btree("amount_1");
create index attr_6_9_position_core_total_usd on "sgd0815"."position" using btree("core_total_usd");
create index attr_6_10_position_lock on "sgd0815"."position" using gist("lock", block_range);
create index attr_6_11_position_pool on "sgd0815"."position" using gist("pool", block_range);
create index attr_6_12_position_aggregate on "sgd0815"."position" using gist("aggregate", block_range);
create index attr_6_13_position_manager on "sgd0815"."position" using gist("manager", block_range);
create table "sgd0815"."token" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "name" text not null,
    "symbol" text not null,
    "decimals" integer not null,
    "tvl_usd" numeric not null,
    "locked_usd" numeric not null,
    "block_number" numeric not null,
    "timestamp" numeric not null,
    "token_search" tsvector
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
create index attr_7_0_token_id on "sgd0815"."token" using btree("id");
create index attr_7_1_token_name on "sgd0815"."token" using btree(left("name", 256));
create index attr_7_2_token_symbol on "sgd0815"."token" using btree(left("symbol", 256));
create index attr_7_3_token_decimals on "sgd0815"."token" using btree("decimals");
create index attr_7_4_token_tvl_usd on "sgd0815"."token" using btree("tvl_usd");
create index attr_7_5_token_locked_usd on "sgd0815"."token" using btree("locked_usd");
create index attr_7_6_token_block_number on "sgd0815"."token" using btree("block_number");
create index attr_7_7_token_timestamp on "sgd0815"."token" using btree("timestamp");
create index attr_7_8_token_token_search on "sgd0815"."token" using gin("token_search");
create table "sgd0815"."base_token" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "token" text not null,
    "base_price" numeric not null,
    "last_base_updated_timestamp" numeric not null
);
alter table "sgd0815"."base_token"
add constraint base_token_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_base_token on "sgd0815"."base_token" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index base_token_block_range_closed on "sgd0815"."base_token"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_8_0_base_token_id on "sgd0815"."base_token" using btree("id");
create index attr_8_1_base_token_token on "sgd0815"."base_token" using gist("token", block_range);
create index attr_8_2_base_token_base_price on "sgd0815"."base_token" using btree("base_price");
create index attr_8_3_base_token_last_base_updated_timestamp on "sgd0815"."base_token" using btree("last_base_updated_timestamp");
create table "sgd0815"."wallet" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "wallet_search" tsvector
);
alter table "sgd0815"."wallet"
add constraint wallet_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_wallet on "sgd0815"."wallet" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index wallet_block_range_closed on "sgd0815"."wallet"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_9_0_wallet_id on "sgd0815"."wallet" using btree("id");
create index attr_9_1_wallet_wallet_search on "sgd0815"."wallet" using gin("wallet_search");
create table "sgd0815"."event_collection" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "lock_events_number" numeric not null,
    "withdraw_events_number" numeric not null,
    "increase_events_number" numeric not null,
    "relock_events_number" numeric not null,
    "transfer_ownership_events_number" numeric not null,
    "migrate_events_number" numeric not null,
    "collector_events_number" numeric not null,
    "additional_collector_events_number" numeric not null
);
alter table "sgd0815"."event_collection"
add constraint event_collection_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_event_collection on "sgd0815"."event_collection" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index event_collection_block_range_closed on "sgd0815"."event_collection"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_10_0_event_collection_id on "sgd0815"."event_collection" using btree("id");
create index attr_10_1_event_collection_lock_events_number on "sgd0815"."event_collection" using btree("lock_events_number");
create index attr_10_2_event_collection_withdraw_events_number on "sgd0815"."event_collection" using btree("withdraw_events_number");
create index attr_10_3_event_collection_increase_events_number on "sgd0815"."event_collection" using btree("increase_events_number");
create index attr_10_4_event_collection_relock_events_number on "sgd0815"."event_collection" using btree("relock_events_number");
create index attr_10_5_event_collection_transfer_ownership_events_number on "sgd0815"."event_collection" using btree("transfer_ownership_events_number");
create index attr_10_6_event_collection_migrate_events_number on "sgd0815"."event_collection" using btree("migrate_events_number");
create index attr_10_7_event_collection_collector_events_number on "sgd0815"."event_collection" using btree("collector_events_number");
create index attr_10_8_event_collection_additional_collector_events_number on "sgd0815"."event_collection" using btree("additional_collector_events_number");
create table "sgd0815"."lock_event" (
    vid bigserial primary key,
    block $ int not null,
    "id" text not null,
    "lock_id" text not null,
    "main_token" text not null,
    "base_token" text not null,
    "locked_liquidity" numeric not null,
    "locked_amount_0" numeric not null,
    "locked_amount_1" numeric not null,
    "locked_core_usd" numeric not null,
    "locked_percent" numeric not null,
    "owner" text not null,
    "collector" text not null,
    "additional_collector" text not null,
    "position" text,
    "lock" text,
    "reserve" text not null,
    "aggregate" text not null,
    "manager" text not null,
    "locker" text not null,
    "unlock_date" numeric not null,
    "block_number" numeric not null,
    "timestamp" numeric not null,
    "transaction" bytea not null,
    "events_collection" text not null,
    unique(id)
);
create index brin_lock_event on "sgd0815"."lock_event" using brin(block $ int4_minmax_ops, vid int8_minmax_ops);
create index attr_11_0_lock_event_lock_id on "sgd0815"."lock_event" using btree(left("lock_id", 256));
create index attr_11_1_lock_event_main_token on "sgd0815"."lock_event" using btree("main_token", block $);
create index attr_11_2_lock_event_base_token on "sgd0815"."lock_event" using btree("base_token", block $);
create index attr_11_3_lock_event_locked_liquidity on "sgd0815"."lock_event" using btree("locked_liquidity");
create index attr_11_4_lock_event_locked_amount_0 on "sgd0815"."lock_event" using btree("locked_amount_0");
create index attr_11_5_lock_event_locked_amount_1 on "sgd0815"."lock_event" using btree("locked_amount_1");
create index attr_11_6_lock_event_locked_core_usd on "sgd0815"."lock_event" using btree("locked_core_usd");
create index attr_11_7_lock_event_locked_percent on "sgd0815"."lock_event" using btree("locked_percent");
create index attr_11_8_lock_event_owner on "sgd0815"."lock_event" using btree("owner", block $);
create index attr_11_9_lock_event_collector on "sgd0815"."lock_event" using btree("collector", block $);
create index attr_11_10_lock_event_additional_collector on "sgd0815"."lock_event" using btree("additional_collector", block $);
create index attr_11_11_lock_event_position on "sgd0815"."lock_event" using btree("position", block $);
create index attr_11_12_lock_event_lock on "sgd0815"."lock_event" using btree("lock", block $);
create index attr_11_13_lock_event_reserve on "sgd0815"."lock_event" using btree("reserve", block $);
create index attr_11_14_lock_event_aggregate on "sgd0815"."lock_event" using btree("aggregate", block $);
create index attr_11_15_lock_event_manager on "sgd0815"."lock_event" using btree("manager", block $);
create index attr_11_16_lock_event_locker on "sgd0815"."lock_event" using btree("locker", block $);
create index attr_11_17_lock_event_unlock_date on "sgd0815"."lock_event" using btree("unlock_date");
create index attr_11_18_lock_event_block_number on "sgd0815"."lock_event" using btree("block_number");
create index attr_11_19_lock_event_timestamp on "sgd0815"."lock_event" using btree("timestamp");
create index attr_11_20_lock_event_transaction on "sgd0815"."lock_event" using btree(substring("transaction", 1, 64));
create index attr_11_21_lock_event_events_collection on "sgd0815"."lock_event" using btree("events_collection", block $);
create table "sgd0815"."withdraw_event" (
    vid bigserial primary key,
    block $ int not null,
    "id" text not null,
    "lock_id" text not null,
    "main_token" text not null,
    "base_token" text not null,
    "withdrawn_liquidity" numeric not null,
    "withdrawn_amount_0" numeric not null,
    "withdrawn_amount_1" numeric not null,
    "withdrawn_core_usd" numeric not null,
    "withdrawn_percent" numeric not null,
    "owner" text not null,
    "collector" text not null,
    "additional_collector" text not null,
    "position" text,
    "lock" text,
    "reserve" text not null,
    "aggregate" text not null,
    "manager" text not null,
    "locker" text not null,
    "unlock_date" numeric not null,
    "block_number" numeric not null,
    "timestamp" numeric not null,
    "transaction" bytea not null,
    "events_collection" text not null,
    unique(id)
);
create index brin_withdraw_event on "sgd0815"."withdraw_event" using brin(block $ int4_minmax_ops, vid int8_minmax_ops);
create index attr_12_0_withdraw_event_lock_id on "sgd0815"."withdraw_event" using btree(left("lock_id", 256));
create index attr_12_1_withdraw_event_main_token on "sgd0815"."withdraw_event" using btree("main_token", block $);
create index attr_12_2_withdraw_event_base_token on "sgd0815"."withdraw_event" using btree("base_token", block $);
create index attr_12_3_withdraw_event_withdrawn_liquidity on "sgd0815"."withdraw_event" using btree("withdrawn_liquidity");
create index attr_12_4_withdraw_event_withdrawn_amount_0 on "sgd0815"."withdraw_event" using btree("withdrawn_amount_0");
create index attr_12_5_withdraw_event_withdrawn_amount_1 on "sgd0815"."withdraw_event" using btree("withdrawn_amount_1");
create index attr_12_6_withdraw_event_withdrawn_core_usd on "sgd0815"."withdraw_event" using btree("withdrawn_core_usd");
create index attr_12_7_withdraw_event_withdrawn_percent on "sgd0815"."withdraw_event" using btree("withdrawn_percent");
create index attr_12_8_withdraw_event_owner on "sgd0815"."withdraw_event" using btree("owner", block $);
create index attr_12_9_withdraw_event_collector on "sgd0815"."withdraw_event" using btree("collector", block $);
create index attr_12_10_withdraw_event_additional_collector on "sgd0815"."withdraw_event" using btree("additional_collector", block $);
create index attr_12_11_withdraw_event_position on "sgd0815"."withdraw_event" using btree("position", block $);
create index attr_12_12_withdraw_event_lock on "sgd0815"."withdraw_event" using btree("lock", block $);
create index attr_12_13_withdraw_event_reserve on "sgd0815"."withdraw_event" using btree("reserve", block $);
create index attr_12_14_withdraw_event_aggregate on "sgd0815"."withdraw_event" using btree("aggregate", block $);
create index attr_12_15_withdraw_event_manager on "sgd0815"."withdraw_event" using btree("manager", block $);
create index attr_12_16_withdraw_event_locker on "sgd0815"."withdraw_event" using btree("locker", block $);
create index attr_12_17_withdraw_event_unlock_date on "sgd0815"."withdraw_event" using btree("unlock_date");
create index attr_12_18_withdraw_event_block_number on "sgd0815"."withdraw_event" using btree("block_number");
create index attr_12_19_withdraw_event_timestamp on "sgd0815"."withdraw_event" using btree("timestamp");
create index attr_12_20_withdraw_event_transaction on "sgd0815"."withdraw_event" using btree(substring("transaction", 1, 64));
create index attr_12_21_withdraw_event_events_collection on "sgd0815"."withdraw_event" using btree("events_collection", block $);
create table "sgd0815"."increase_event" (
    vid bigserial primary key,
    block $ int not null,
    "id" text not null,
    "lock_id" text not null,
    "main_token" text not null,
    "base_token" text not null,
    "locked_liquidity_before" numeric not null,
    "locked_amount_0_before" numeric not null,
    "locked_amount_1_before" numeric not null,
    "locked_core_usd_before" numeric not null,
    "locked_percent_before" numeric not null,
    "locked_liquidity_after" numeric not null,
    "locked_amount_0_after" numeric not null,
    "locked_amount_1_after" numeric not null,
    "locked_core_usd_after" numeric not null,
    "locked_percent_after" numeric not null,
    "owner" text not null,
    "collector" text not null,
    "additional_collector" text not null,
    "position" text,
    "lock" text,
    "reserve" text not null,
    "aggregate" text not null,
    "manager" text not null,
    "locker" text not null,
    "unlock_date" numeric not null,
    "block_number" numeric not null,
    "timestamp" numeric not null,
    "transaction" bytea not null,
    "events_collection" text not null,
    unique(id)
);
create index brin_increase_event on "sgd0815"."increase_event" using brin(block $ int4_minmax_ops, vid int8_minmax_ops);
create index attr_13_0_increase_event_lock_id on "sgd0815"."increase_event" using btree(left("lock_id", 256));
create index attr_13_1_increase_event_main_token on "sgd0815"."increase_event" using btree("main_token", block $);
create index attr_13_2_increase_event_base_token on "sgd0815"."increase_event" using btree("base_token", block $);
create index attr_13_3_increase_event_locked_liquidity_before on "sgd0815"."increase_event" using btree("locked_liquidity_before");
create index attr_13_4_increase_event_locked_amount_0_before on "sgd0815"."increase_event" using btree("locked_amount_0_before");
create index attr_13_5_increase_event_locked_amount_1_before on "sgd0815"."increase_event" using btree("locked_amount_1_before");
create index attr_13_6_increase_event_locked_core_usd_before on "sgd0815"."increase_event" using btree("locked_core_usd_before");
create index attr_13_7_increase_event_locked_percent_before on "sgd0815"."increase_event" using btree("locked_percent_before");
create index attr_13_8_increase_event_locked_liquidity_after on "sgd0815"."increase_event" using btree("locked_liquidity_after");
create index attr_13_9_increase_event_locked_amount_0_after on "sgd0815"."increase_event" using btree("locked_amount_0_after");
create index attr_13_10_increase_event_locked_amount_1_after on "sgd0815"."increase_event" using btree("locked_amount_1_after");
create index attr_13_11_increase_event_locked_core_usd_after on "sgd0815"."increase_event" using btree("locked_core_usd_after");
create index attr_13_12_increase_event_locked_percent_after on "sgd0815"."increase_event" using btree("locked_percent_after");
create index attr_13_13_increase_event_owner on "sgd0815"."increase_event" using btree("owner", block $);
create index attr_13_14_increase_event_collector on "sgd0815"."increase_event" using btree("collector", block $);
create index attr_13_15_increase_event_additional_collector on "sgd0815"."increase_event" using btree("additional_collector", block $);
create index attr_13_16_increase_event_position on "sgd0815"."increase_event" using btree("position", block $);
create index attr_13_17_increase_event_lock on "sgd0815"."increase_event" using btree("lock", block $);
create index attr_13_18_increase_event_reserve on "sgd0815"."increase_event" using btree("reserve", block $);
create index attr_13_19_increase_event_aggregate on "sgd0815"."increase_event" using btree("aggregate", block $);
create index attr_13_20_increase_event_manager on "sgd0815"."increase_event" using btree("manager", block $);
create index attr_13_21_increase_event_locker on "sgd0815"."increase_event" using btree("locker", block $);
create index attr_13_22_increase_event_unlock_date on "sgd0815"."increase_event" using btree("unlock_date");
create index attr_13_23_increase_event_block_number on "sgd0815"."increase_event" using btree("block_number");
create index attr_13_24_increase_event_timestamp on "sgd0815"."increase_event" using btree("timestamp");
create index attr_13_25_increase_event_transaction on "sgd0815"."increase_event" using btree(substring("transaction", 1, 64));
create index attr_13_26_increase_event_events_collection on "sgd0815"."increase_event" using btree("events_collection", block $);
create table "sgd0815"."relock_event" (
    vid bigserial primary key,
    block $ int not null,
    "id" text not null,
    "lock_id" text not null,
    "main_token" text not null,
    "base_token" text not null,
    "locked_liquidity" numeric not null,
    "locked_amount_0" numeric not null,
    "locked_amount_1" numeric not null,
    "locked_core_usd" numeric not null,
    "locked_percent" numeric not null,
    "owner" text not null,
    "collector" text not null,
    "additional_collector" text not null,
    "position" text,
    "lock" text,
    "reserve" text not null,
    "aggregate" text not null,
    "manager" text not null,
    "locker" text not null,
    "unlock_date_before" numeric not null,
    "unlock_date_after" numeric not null,
    "block_number" numeric not null,
    "timestamp" numeric not null,
    "transaction" bytea not null,
    "events_collection" text not null,
    unique(id)
);
create index brin_relock_event on "sgd0815"."relock_event" using brin(block $ int4_minmax_ops, vid int8_minmax_ops);
create index attr_14_0_relock_event_lock_id on "sgd0815"."relock_event" using btree(left("lock_id", 256));
create index attr_14_1_relock_event_main_token on "sgd0815"."relock_event" using btree("main_token", block $);
create index attr_14_2_relock_event_base_token on "sgd0815"."relock_event" using btree("base_token", block $);
create index attr_14_3_relock_event_locked_liquidity on "sgd0815"."relock_event" using btree("locked_liquidity");
create index attr_14_4_relock_event_locked_amount_0 on "sgd0815"."relock_event" using btree("locked_amount_0");
create index attr_14_5_relock_event_locked_amount_1 on "sgd0815"."relock_event" using btree("locked_amount_1");
create index attr_14_6_relock_event_locked_core_usd on "sgd0815"."relock_event" using btree("locked_core_usd");
create index attr_14_7_relock_event_locked_percent on "sgd0815"."relock_event" using btree("locked_percent");
create index attr_14_8_relock_event_owner on "sgd0815"."relock_event" using btree("owner", block $);
create index attr_14_9_relock_event_collector on "sgd0815"."relock_event" using btree("collector", block $);
create index attr_14_10_relock_event_additional_collector on "sgd0815"."relock_event" using btree("additional_collector", block $);
create index attr_14_11_relock_event_position on "sgd0815"."relock_event" using btree("position", block $);
create index attr_14_12_relock_event_lock on "sgd0815"."relock_event" using btree("lock", block $);
create index attr_14_13_relock_event_reserve on "sgd0815"."relock_event" using btree("reserve", block $);
create index attr_14_14_relock_event_aggregate on "sgd0815"."relock_event" using btree("aggregate", block $);
create index attr_14_15_relock_event_manager on "sgd0815"."relock_event" using btree("manager", block $);
create index attr_14_16_relock_event_locker on "sgd0815"."relock_event" using btree("locker", block $);
create index attr_14_17_relock_event_unlock_date_before on "sgd0815"."relock_event" using btree("unlock_date_before");
create index attr_14_18_relock_event_unlock_date_after on "sgd0815"."relock_event" using btree("unlock_date_after");
create index attr_14_19_relock_event_block_number on "sgd0815"."relock_event" using btree("block_number");
create index attr_14_20_relock_event_timestamp on "sgd0815"."relock_event" using btree("timestamp");
create index attr_14_21_relock_event_transaction on "sgd0815"."relock_event" using btree(substring("transaction", 1, 64));
create index attr_14_22_relock_event_events_collection on "sgd0815"."relock_event" using btree("events_collection", block $);
create table "sgd0815"."transfer_ownership_event" (
    vid bigserial primary key,
    block $ int not null,
    "id" text not null,
    "lock_id" text not null,
    "main_token" text not null,
    "base_token" text not null,
    "locked_liquidity" numeric not null,
    "locked_amount_0" numeric not null,
    "locked_amount_1" numeric not null,
    "locked_core_usd" numeric not null,
    "locked_percent" numeric not null,
    "owner_before" text not null,
    "owner_after" text not null,
    "collector" text not null,
    "additional_collector" text not null,
    "position" text,
    "lock" text,
    "reserve" text not null,
    "aggregate" text not null,
    "manager" text not null,
    "locker" text not null,
    "unlock_date" numeric not null,
    "block_number" numeric not null,
    "timestamp" numeric not null,
    "transaction" bytea not null,
    "events_collection" text not null,
    unique(id)
);
create index brin_transfer_ownership_event on "sgd0815"."transfer_ownership_event" using brin(block $ int4_minmax_ops, vid int8_minmax_ops);
create index attr_15_0_transfer_ownership_event_lock_id on "sgd0815"."transfer_ownership_event" using btree(left("lock_id", 256));
create index attr_15_1_transfer_ownership_event_main_token on "sgd0815"."transfer_ownership_event" using btree("main_token", block $);
create index attr_15_2_transfer_ownership_event_base_token on "sgd0815"."transfer_ownership_event" using btree("base_token", block $);
create index attr_15_3_transfer_ownership_event_locked_liquidity on "sgd0815"."transfer_ownership_event" using btree("locked_liquidity");
create index attr_15_4_transfer_ownership_event_locked_amount_0 on "sgd0815"."transfer_ownership_event" using btree("locked_amount_0");
create index attr_15_5_transfer_ownership_event_locked_amount_1 on "sgd0815"."transfer_ownership_event" using btree("locked_amount_1");
create index attr_15_6_transfer_ownership_event_locked_core_usd on "sgd0815"."transfer_ownership_event" using btree("locked_core_usd");
create index attr_15_7_transfer_ownership_event_locked_percent on "sgd0815"."transfer_ownership_event" using btree("locked_percent");
create index attr_15_8_transfer_ownership_event_owner_before on "sgd0815"."transfer_ownership_event" using btree("owner_before", block $);
create index attr_15_9_transfer_ownership_event_owner_after on "sgd0815"."transfer_ownership_event" using btree("owner_after", block $);
create index attr_15_10_transfer_ownership_event_collector on "sgd0815"."transfer_ownership_event" using btree("collector", block $);
create index attr_15_11_transfer_ownership_event_additional_collector on "sgd0815"."transfer_ownership_event" using btree("additional_collector", block $);
create index attr_15_12_transfer_ownership_event_position on "sgd0815"."transfer_ownership_event" using btree("position", block $);
create index attr_15_13_transfer_ownership_event_lock on "sgd0815"."transfer_ownership_event" using btree("lock", block $);
create index attr_15_14_transfer_ownership_event_reserve on "sgd0815"."transfer_ownership_event" using btree("reserve", block $);
create index attr_15_15_transfer_ownership_event_aggregate on "sgd0815"."transfer_ownership_event" using btree("aggregate", block $);
create index attr_15_16_transfer_ownership_event_manager on "sgd0815"."transfer_ownership_event" using btree("manager", block $);
create index attr_15_17_transfer_ownership_event_locker on "sgd0815"."transfer_ownership_event" using btree("locker", block $);
create index attr_15_18_transfer_ownership_event_unlock_date on "sgd0815"."transfer_ownership_event" using btree("unlock_date");
create index attr_15_19_transfer_ownership_event_block_number on "sgd0815"."transfer_ownership_event" using btree("block_number");
create index attr_15_20_transfer_ownership_event_timestamp on "sgd0815"."transfer_ownership_event" using btree("timestamp");
create index attr_15_21_transfer_ownership_event_transaction on "sgd0815"."transfer_ownership_event" using btree(substring("transaction", 1, 64));
create index attr_15_22_transfer_ownership_event_events_collection on "sgd0815"."transfer_ownership_event" using btree("events_collection", block $);
create table "sgd0815"."migrate_event" (
    vid bigserial primary key,
    block $ int not null,
    "id" text not null,
    "lock_id" text not null,
    "main_token" text not null,
    "base_token" text not null,
    "locked_liquidity" numeric not null,
    "locked_amount_0" numeric not null,
    "locked_amount_1" numeric not null,
    "locked_core_usd" numeric not null,
    "locked_percent" numeric not null,
    "owner" text not null,
    "collector" text not null,
    "additional_collector" text not null,
    "position" text,
    "lock" text,
    "reserve" text not null,
    "aggregate" text not null,
    "manager" text not null,
    "locker" text not null,
    "unlock_date" numeric not null,
    "block_number" numeric not null,
    "timestamp" numeric not null,
    "transaction" bytea not null,
    "events_collection" text not null,
    unique(id)
);
create index brin_migrate_event on "sgd0815"."migrate_event" using brin(block $ int4_minmax_ops, vid int8_minmax_ops);
create index attr_16_0_migrate_event_lock_id on "sgd0815"."migrate_event" using btree(left("lock_id", 256));
create index attr_16_1_migrate_event_main_token on "sgd0815"."migrate_event" using btree("main_token", block $);
create index attr_16_2_migrate_event_base_token on "sgd0815"."migrate_event" using btree("base_token", block $);
create index attr_16_3_migrate_event_locked_liquidity on "sgd0815"."migrate_event" using btree("locked_liquidity");
create index attr_16_4_migrate_event_locked_amount_0 on "sgd0815"."migrate_event" using btree("locked_amount_0");
create index attr_16_5_migrate_event_locked_amount_1 on "sgd0815"."migrate_event" using btree("locked_amount_1");
create index attr_16_6_migrate_event_locked_core_usd on "sgd0815"."migrate_event" using btree("locked_core_usd");
create index attr_16_7_migrate_event_locked_percent on "sgd0815"."migrate_event" using btree("locked_percent");
create index attr_16_8_migrate_event_owner on "sgd0815"."migrate_event" using btree("owner", block $);
create index attr_16_9_migrate_event_collector on "sgd0815"."migrate_event" using btree("collector", block $);
create index attr_16_10_migrate_event_additional_collector on "sgd0815"."migrate_event" using btree("additional_collector", block $);
create index attr_16_11_migrate_event_position on "sgd0815"."migrate_event" using btree("position", block $);
create index attr_16_12_migrate_event_lock on "sgd0815"."migrate_event" using btree("lock", block $);
create index attr_16_13_migrate_event_reserve on "sgd0815"."migrate_event" using btree("reserve", block $);
create index attr_16_14_migrate_event_aggregate on "sgd0815"."migrate_event" using btree("aggregate", block $);
create index attr_16_15_migrate_event_manager on "sgd0815"."migrate_event" using btree("manager", block $);
create index attr_16_16_migrate_event_locker on "sgd0815"."migrate_event" using btree("locker", block $);
create index attr_16_17_migrate_event_unlock_date on "sgd0815"."migrate_event" using btree("unlock_date");
create index attr_16_18_migrate_event_block_number on "sgd0815"."migrate_event" using btree("block_number");
create index attr_16_19_migrate_event_timestamp on "sgd0815"."migrate_event" using btree("timestamp");
create index attr_16_20_migrate_event_transaction on "sgd0815"."migrate_event" using btree(substring("transaction", 1, 64));
create index attr_16_21_migrate_event_events_collection on "sgd0815"."migrate_event" using btree("events_collection", block $);
create table "sgd0815"."collector_event" (
    vid bigserial primary key,
    block $ int not null,
    "id" text not null,
    "lock_id" text not null,
    "main_token" text not null,
    "base_token" text not null,
    "locked_liquidity" numeric not null,
    "locked_amount_0" numeric not null,
    "locked_amount_1" numeric not null,
    "locked_core_usd" numeric not null,
    "locked_percent" numeric not null,
    "owner" text not null,
    "collector_before" text not null,
    "collector_after" text not null,
    "additional_collector" text not null,
    "position" text,
    "lock" text,
    "reserve" text not null,
    "aggregate" text not null,
    "manager" text not null,
    "locker" text not null,
    "unlock_date" numeric not null,
    "block_number" numeric not null,
    "timestamp" numeric not null,
    "transaction" bytea not null,
    "events_collection" text not null,
    unique(id)
);
create index brin_collector_event on "sgd0815"."collector_event" using brin(block $ int4_minmax_ops, vid int8_minmax_ops);
create index attr_17_0_collector_event_lock_id on "sgd0815"."collector_event" using btree(left("lock_id", 256));
create index attr_17_1_collector_event_main_token on "sgd0815"."collector_event" using btree("main_token", block $);
create index attr_17_2_collector_event_base_token on "sgd0815"."collector_event" using btree("base_token", block $);
create index attr_17_3_collector_event_locked_liquidity on "sgd0815"."collector_event" using btree("locked_liquidity");
create index attr_17_4_collector_event_locked_amount_0 on "sgd0815"."collector_event" using btree("locked_amount_0");
create index attr_17_5_collector_event_locked_amount_1 on "sgd0815"."collector_event" using btree("locked_amount_1");
create index attr_17_6_collector_event_locked_core_usd on "sgd0815"."collector_event" using btree("locked_core_usd");
create index attr_17_7_collector_event_locked_percent on "sgd0815"."collector_event" using btree("locked_percent");
create index attr_17_8_collector_event_owner on "sgd0815"."collector_event" using btree("owner", block $);
create index attr_17_9_collector_event_collector_before on "sgd0815"."collector_event" using btree("collector_before", block $);
create index attr_17_10_collector_event_collector_after on "sgd0815"."collector_event" using btree("collector_after", block $);
create index attr_17_11_collector_event_additional_collector on "sgd0815"."collector_event" using btree("additional_collector", block $);
create index attr_17_12_collector_event_position on "sgd0815"."collector_event" using btree("position", block $);
create index attr_17_13_collector_event_lock on "sgd0815"."collector_event" using btree("lock", block $);
create index attr_17_14_collector_event_reserve on "sgd0815"."collector_event" using btree("reserve", block $);
create index attr_17_15_collector_event_aggregate on "sgd0815"."collector_event" using btree("aggregate", block $);
create index attr_17_16_collector_event_manager on "sgd0815"."collector_event" using btree("manager", block $);
create index attr_17_17_collector_event_locker on "sgd0815"."collector_event" using btree("locker", block $);
create index attr_17_18_collector_event_unlock_date on "sgd0815"."collector_event" using btree("unlock_date");
create index attr_17_19_collector_event_block_number on "sgd0815"."collector_event" using btree("block_number");
create index attr_17_20_collector_event_timestamp on "sgd0815"."collector_event" using btree("timestamp");
create index attr_17_21_collector_event_transaction on "sgd0815"."collector_event" using btree(substring("transaction", 1, 64));
create index attr_17_22_collector_event_events_collection on "sgd0815"."collector_event" using btree("events_collection", block $);
create table "sgd0815"."additional_collector_event" (
    vid bigserial primary key,
    block $ int not null,
    "id" text not null,
    "lock_id" text not null,
    "main_token" text not null,
    "base_token" text not null,
    "locked_liquidity" numeric not null,
    "locked_amount_0" numeric not null,
    "locked_amount_1" numeric not null,
    "locked_core_usd" numeric not null,
    "locked_percent" numeric not null,
    "owner" text not null,
    "collector" text not null,
    "additional_collector_before" text not null,
    "additional_collector_after" text not null,
    "position" text,
    "lock" text,
    "reserve" text not null,
    "aggregate" text not null,
    "manager" text not null,
    "locker" text not null,
    "unlock_date" numeric not null,
    "block_number" numeric not null,
    "timestamp" numeric not null,
    "transaction" bytea not null,
    "events_collection" text not null,
    unique(id)
);
create index brin_additional_collector_event on "sgd0815"."additional_collector_event" using brin(block $ int4_minmax_ops, vid int8_minmax_ops);
create index attr_18_0_additional_collector_event_lock_id on "sgd0815"."additional_collector_event" using btree(left("lock_id", 256));
create index attr_18_1_additional_collector_event_main_token on "sgd0815"."additional_collector_event" using btree("main_token", block $);
create index attr_18_2_additional_collector_event_base_token on "sgd0815"."additional_collector_event" using btree("base_token", block $);
create index attr_18_3_additional_collector_event_locked_liquidity on "sgd0815"."additional_collector_event" using btree("locked_liquidity");
create index attr_18_4_additional_collector_event_locked_amount_0 on "sgd0815"."additional_collector_event" using btree("locked_amount_0");
create index attr_18_5_additional_collector_event_locked_amount_1 on "sgd0815"."additional_collector_event" using btree("locked_amount_1");
create index attr_18_6_additional_collector_event_locked_core_usd on "sgd0815"."additional_collector_event" using btree("locked_core_usd");
create index attr_18_7_additional_collector_event_locked_percent on "sgd0815"."additional_collector_event" using btree("locked_percent");
create index attr_18_8_additional_collector_event_owner on "sgd0815"."additional_collector_event" using btree("owner", block $);
create index attr_18_9_additional_collector_event_collector on "sgd0815"."additional_collector_event" using btree("collector", block $);
create index attr_18_10_additional_collector_event_additional_collector_before on "sgd0815"."additional_collector_event" using btree("additional_collector_before", block $);
create index attr_18_11_additional_collector_event_additional_collector_after on "sgd0815"."additional_collector_event" using btree("additional_collector_after", block $);
create index attr_18_12_additional_collector_event_position on "sgd0815"."additional_collector_event" using btree("position", block $);
create index attr_18_13_additional_collector_event_lock on "sgd0815"."additional_collector_event" using btree("lock", block $);
create index attr_18_14_additional_collector_event_reserve on "sgd0815"."additional_collector_event" using btree("reserve", block $);
create index attr_18_15_additional_collector_event_aggregate on "sgd0815"."additional_collector_event" using btree("aggregate", block $);
create index attr_18_16_additional_collector_event_manager on "sgd0815"."additional_collector_event" using btree("manager", block $);
create index attr_18_17_additional_collector_event_locker on "sgd0815"."additional_collector_event" using btree("locker", block $);
create index attr_18_18_additional_collector_event_unlock_date on "sgd0815"."additional_collector_event" using btree("unlock_date");
create index attr_18_19_additional_collector_event_block_number on "sgd0815"."additional_collector_event" using btree("block_number");
create index attr_18_20_additional_collector_event_timestamp on "sgd0815"."additional_collector_event" using btree("timestamp");
create index attr_18_21_additional_collector_event_transaction on "sgd0815"."additional_collector_event" using btree(substring("transaction", 1, 64));
create index attr_18_22_additional_collector_event_events_collection on "sgd0815"."additional_collector_event" using btree("events_collection", block $);