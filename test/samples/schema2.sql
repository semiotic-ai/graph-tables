-- This file is generated from graph-node postgres database schema generation
-- see store/postgres/src/relational/ddl_tests.rs under graph-node repository

create type sgd0815."prize_pool_state" as enum ('Awarded', 'Opened', 'Started');
create type sgd0815."prize_pool_type" as enum ('Compound', 'yVault');
create table "sgd0815"."comptroller" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "owner" bytea not null
);
alter table "sgd0815"."comptroller"
add constraint comptroller_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_comptroller on "sgd0815"."comptroller" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index comptroller_block_range_closed on "sgd0815"."comptroller"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_0_0_comptroller_id on "sgd0815"."comptroller" using btree("id");
create index attr_0_1_comptroller_owner on "sgd0815"."comptroller" using btree(substring("owner", 1, 64));
create table "sgd0815"."prize_pool" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "deactivated" boolean not null,
    "owner" bytea,
    "reserve_registry" bytea,
    "prize_strategy" text,
    "prize_pool_type" "sgd0815"."prize_pool_type",
    "compound_prize_pool" text,
    "reserve_fee_controlled_token" bytea not null,
    "underlying_collateral_token" bytea,
    "underlying_collateral_decimals" numeric,
    "underlying_collateral_name" text,
    "underlying_collateral_symbol" text,
    "max_exit_fee_mantissa" numeric not null,
    "max_timelock_duration" numeric not null,
    "timelock_total_supply" numeric,
    "liquidity_cap" numeric not null,
    "cumulative_prize_gross" numeric not null,
    "cumulative_prize_reserve_fee" numeric not null,
    "cumulative_prize_net" numeric not null,
    "current_prize_id" numeric not null,
    "current_state" "sgd0815"."prize_pool_state" not null,
    "prizes_count" numeric not null
);
alter table "sgd0815"."prize_pool"
add constraint prize_pool_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_prize_pool on "sgd0815"."prize_pool" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index prize_pool_block_range_closed on "sgd0815"."prize_pool"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_1_0_prize_pool_id on "sgd0815"."prize_pool" using btree("id");
create index attr_1_1_prize_pool_deactivated on "sgd0815"."prize_pool" using btree("deactivated");
create index attr_1_2_prize_pool_owner on "sgd0815"."prize_pool" using btree(substring("owner", 1, 64));
create index attr_1_3_prize_pool_reserve_registry on "sgd0815"."prize_pool" using btree(substring("reserve_registry", 1, 64));
create index attr_1_4_prize_pool_prize_strategy on "sgd0815"."prize_pool" using gist("prize_strategy", block_range);
create index attr_1_5_prize_pool_prize_pool_type on "sgd0815"."prize_pool" using btree("prize_pool_type");
create index attr_1_6_prize_pool_compound_prize_pool on "sgd0815"."prize_pool" using gist("compound_prize_pool", block_range);
create index attr_1_7_prize_pool_reserve_fee_controlled_token on "sgd0815"."prize_pool" using btree(substring("reserve_fee_controlled_token", 1, 64));
create index attr_1_8_prize_pool_underlying_collateral_token on "sgd0815"."prize_pool" using btree(substring("underlying_collateral_token", 1, 64));
create index attr_1_9_prize_pool_underlying_collateral_decimals on "sgd0815"."prize_pool" using btree("underlying_collateral_decimals");
create index attr_1_10_prize_pool_underlying_collateral_name on "sgd0815"."prize_pool" using btree(left("underlying_collateral_name", 256));
create index attr_1_11_prize_pool_underlying_collateral_symbol on "sgd0815"."prize_pool" using btree(left("underlying_collateral_symbol", 256));
create index attr_1_12_prize_pool_max_exit_fee_mantissa on "sgd0815"."prize_pool" using btree("max_exit_fee_mantissa");
create index attr_1_13_prize_pool_max_timelock_duration on "sgd0815"."prize_pool" using btree("max_timelock_duration");
create index attr_1_14_prize_pool_timelock_total_supply on "sgd0815"."prize_pool" using btree("timelock_total_supply");
create index attr_1_15_prize_pool_liquidity_cap on "sgd0815"."prize_pool" using btree("liquidity_cap");
create index attr_1_16_prize_pool_cumulative_prize_gross on "sgd0815"."prize_pool" using btree("cumulative_prize_gross");
create index attr_1_17_prize_pool_cumulative_prize_reserve_fee on "sgd0815"."prize_pool" using btree("cumulative_prize_reserve_fee");
create index attr_1_18_prize_pool_cumulative_prize_net on "sgd0815"."prize_pool" using btree("cumulative_prize_net");
create index attr_1_19_prize_pool_current_prize_id on "sgd0815"."prize_pool" using btree("current_prize_id");
create index attr_1_20_prize_pool_current_state on "sgd0815"."prize_pool" using btree("current_state");
create index attr_1_21_prize_pool_prizes_count on "sgd0815"."prize_pool" using btree("prizes_count");
create table "sgd0815"."compound_prize_pool" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "c_token" bytea
);
alter table "sgd0815"."compound_prize_pool"
add constraint compound_prize_pool_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_compound_prize_pool on "sgd0815"."compound_prize_pool" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index compound_prize_pool_block_range_closed on "sgd0815"."compound_prize_pool"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_2_0_compound_prize_pool_id on "sgd0815"."compound_prize_pool" using btree("id");
create index attr_2_1_compound_prize_pool_c_token on "sgd0815"."compound_prize_pool" using btree(substring("c_token", 1, 64));
create table "sgd0815"."prize_strategy" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "single_random_winner" text,
    "multiple_winners" text
);
alter table "sgd0815"."prize_strategy"
add constraint prize_strategy_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_prize_strategy on "sgd0815"."prize_strategy" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index prize_strategy_block_range_closed on "sgd0815"."prize_strategy"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_3_0_prize_strategy_id on "sgd0815"."prize_strategy" using btree("id");
create index attr_3_1_prize_strategy_single_random_winner on "sgd0815"."prize_strategy" using gist("single_random_winner", block_range);
create index attr_3_2_prize_strategy_multiple_winners on "sgd0815"."prize_strategy" using gist("multiple_winners", block_range);
create table "sgd0815"."single_random_winner_prize_strategy" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "owner" bytea,
    "token_listener" text,
    "prize_pool" text,
    "rng" bytea,
    "ticket" text,
    "sponsorship" text,
    "prize_period_seconds" numeric not null,
    "prize_period_started_at" numeric not null,
    "prize_period_end_at" numeric not null
);
alter table "sgd0815"."single_random_winner_prize_strategy"
add constraint single_random_winner_prize_strategy_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_single_random_winner_prize_strategy on "sgd0815"."single_random_winner_prize_strategy" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index single_random_winner_prize_strategy_block_range_closed on "sgd0815"."single_random_winner_prize_strategy"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_4_0_single_random_winner_prize_strategy_id on "sgd0815"."single_random_winner_prize_strategy" using btree("id");
create index attr_4_1_single_random_winner_prize_strategy_owner on "sgd0815"."single_random_winner_prize_strategy" using btree(substring("owner", 1, 64));
create index attr_4_2_single_random_winner_prize_strategy_token_listener on "sgd0815"."single_random_winner_prize_strategy" using gist("token_listener", block_range);
create index attr_4_3_single_random_winner_prize_strategy_prize_pool on "sgd0815"."single_random_winner_prize_strategy" using gist("prize_pool", block_range);
create index attr_4_4_single_random_winner_prize_strategy_rng on "sgd0815"."single_random_winner_prize_strategy" using btree(substring("rng", 1, 64));
create index attr_4_5_single_random_winner_prize_strategy_ticket on "sgd0815"."single_random_winner_prize_strategy" using gist("ticket", block_range);
create index attr_4_6_single_random_winner_prize_strategy_sponsorship on "sgd0815"."single_random_winner_prize_strategy" using gist("sponsorship", block_range);
create index attr_4_7_single_random_winner_prize_strategy_prize_period_seconds on "sgd0815"."single_random_winner_prize_strategy" using btree("prize_period_seconds");
create index attr_4_8_single_random_winner_prize_strategy_prize_period_started_at on "sgd0815"."single_random_winner_prize_strategy" using btree("prize_period_started_at");
create index attr_4_9_single_random_winner_prize_strategy_prize_period_end_at on "sgd0815"."single_random_winner_prize_strategy" using btree("prize_period_end_at");
create table "sgd0815"."prize" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "prize_pool" text not null,
    "award_start_operator" bytea,
    "awarded_operator" bytea,
    "prize_period_started_timestamp" numeric,
    "lock_block" numeric,
    "awarded_block" numeric,
    "awarded_timestamp" numeric,
    "rng_request_id" numeric,
    "random_number" numeric,
    "amount" numeric,
    "total_ticket_supply" numeric,
    "winners" bytea []
);
alter table "sgd0815"."prize"
add constraint prize_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_prize on "sgd0815"."prize" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index prize_block_range_closed on "sgd0815"."prize"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_5_0_prize_id on "sgd0815"."prize" using btree("id");
create index attr_5_1_prize_prize_pool on "sgd0815"."prize" using gist("prize_pool", block_range);
create index attr_5_2_prize_award_start_operator on "sgd0815"."prize" using btree(substring("award_start_operator", 1, 64));
create index attr_5_3_prize_awarded_operator on "sgd0815"."prize" using btree(substring("awarded_operator", 1, 64));
create index attr_5_4_prize_prize_period_started_timestamp on "sgd0815"."prize" using btree("prize_period_started_timestamp");
create index attr_5_5_prize_lock_block on "sgd0815"."prize" using btree("lock_block");
create index attr_5_6_prize_awarded_block on "sgd0815"."prize" using btree("awarded_block");
create index attr_5_7_prize_awarded_timestamp on "sgd0815"."prize" using btree("awarded_timestamp");
create index attr_5_8_prize_rng_request_id on "sgd0815"."prize" using btree("rng_request_id");
create index attr_5_9_prize_random_number on "sgd0815"."prize" using btree("random_number");
create index attr_5_10_prize_amount on "sgd0815"."prize" using btree("amount");
create index attr_5_11_prize_total_ticket_supply on "sgd0815"."prize" using btree("total_ticket_supply");
create table "sgd0815"."awarded_external_erc_20_token" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "address" bytea not null,
    "name" text,
    "symbol" text,
    "decimals" numeric,
    "balance_awarded" numeric,
    "prize" text not null
);
alter table "sgd0815"."awarded_external_erc_20_token"
add constraint awarded_external_erc_20_token_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_awarded_external_erc_20_token on "sgd0815"."awarded_external_erc_20_token" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index awarded_external_erc_20_token_block_range_closed on "sgd0815"."awarded_external_erc_20_token"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_6_0_awarded_external_erc_20_token_id on "sgd0815"."awarded_external_erc_20_token" using btree("id");
create index attr_6_1_awarded_external_erc_20_token_address on "sgd0815"."awarded_external_erc_20_token" using btree(substring("address", 1, 64));
create index attr_6_2_awarded_external_erc_20_token_name on "sgd0815"."awarded_external_erc_20_token" using btree(left("name", 256));
create index attr_6_3_awarded_external_erc_20_token_symbol on "sgd0815"."awarded_external_erc_20_token" using btree(left("symbol", 256));
create index attr_6_4_awarded_external_erc_20_token_decimals on "sgd0815"."awarded_external_erc_20_token" using btree("decimals");
create index attr_6_5_awarded_external_erc_20_token_balance_awarded on "sgd0815"."awarded_external_erc_20_token" using btree("balance_awarded");
create index attr_6_6_awarded_external_erc_20_token_prize on "sgd0815"."awarded_external_erc_20_token" using gist("prize", block_range);
create table "sgd0815"."awarded_external_erc_721_nft" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "address" bytea not null,
    "token_ids" numeric [],
    "prize" text
);
alter table "sgd0815"."awarded_external_erc_721_nft"
add constraint awarded_external_erc_721_nft_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_awarded_external_erc_721_nft on "sgd0815"."awarded_external_erc_721_nft" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index awarded_external_erc_721_nft_block_range_closed on "sgd0815"."awarded_external_erc_721_nft"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_7_0_awarded_external_erc_721_nft_id on "sgd0815"."awarded_external_erc_721_nft" using btree("id");
create index attr_7_1_awarded_external_erc_721_nft_address on "sgd0815"."awarded_external_erc_721_nft" using btree(substring("address", 1, 64));
create index attr_7_2_awarded_external_erc_721_nft_prize on "sgd0815"."awarded_external_erc_721_nft" using gist("prize", block_range);
create table "sgd0815"."controlled_token" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "name" text not null,
    "symbol" text not null,
    "decimals" numeric,
    "controller" text,
    "total_supply" numeric not null,
    "number_of_holders" numeric not null
);
alter table "sgd0815"."controlled_token"
add constraint controlled_token_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_controlled_token on "sgd0815"."controlled_token" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index controlled_token_block_range_closed on "sgd0815"."controlled_token"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_8_0_controlled_token_id on "sgd0815"."controlled_token" using btree("id");
create index attr_8_1_controlled_token_name on "sgd0815"."controlled_token" using btree(left("name", 256));
create index attr_8_2_controlled_token_symbol on "sgd0815"."controlled_token" using btree(left("symbol", 256));
create index attr_8_3_controlled_token_decimals on "sgd0815"."controlled_token" using btree("decimals");
create index attr_8_4_controlled_token_controller on "sgd0815"."controlled_token" using gist("controller", block_range);
create index attr_8_5_controlled_token_total_supply on "sgd0815"."controlled_token" using btree("total_supply");
create index attr_8_6_controlled_token_number_of_holders on "sgd0815"."controlled_token" using btree("number_of_holders");
create table "sgd0815"."controlled_token_balance" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "account" text not null,
    "controlled_token" text not null,
    "balance" numeric
);
alter table "sgd0815"."controlled_token_balance"
add constraint controlled_token_balance_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_controlled_token_balance on "sgd0815"."controlled_token_balance" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index controlled_token_balance_block_range_closed on "sgd0815"."controlled_token_balance"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_9_0_controlled_token_balance_id on "sgd0815"."controlled_token_balance" using btree("id");
create index attr_9_1_controlled_token_balance_account on "sgd0815"."controlled_token_balance" using gist("account", block_range);
create index attr_9_2_controlled_token_balance_controlled_token on "sgd0815"."controlled_token_balance" using gist("controlled_token", block_range);
create index attr_9_3_controlled_token_balance_balance on "sgd0815"."controlled_token_balance" using btree("balance");
create table "sgd0815"."single_random_winner_external_erc_20_award" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "address" bytea not null,
    "name" text,
    "symbol" text,
    "decimals" numeric,
    "prize_strategy" text
);
alter table "sgd0815"."single_random_winner_external_erc_20_award"
add constraint single_random_winner_external_erc_20_award_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_single_random_winner_external_erc_20_award on "sgd0815"."single_random_winner_external_erc_20_award" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index single_random_winner_external_erc_20_award_block_range_closed on "sgd0815"."single_random_winner_external_erc_20_award"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_10_0_single_random_winner_external_erc_20_award_id on "sgd0815"."single_random_winner_external_erc_20_award" using btree("id");
create index attr_10_1_single_random_winner_external_erc_20_award_address on "sgd0815"."single_random_winner_external_erc_20_award" using btree(substring("address", 1, 64));
create index attr_10_2_single_random_winner_external_erc_20_award_name on "sgd0815"."single_random_winner_external_erc_20_award" using btree(left("name", 256));
create index attr_10_3_single_random_winner_external_erc_20_award_symbol on "sgd0815"."single_random_winner_external_erc_20_award" using btree(left("symbol", 256));
create index attr_10_4_single_random_winner_external_erc_20_award_decimals on "sgd0815"."single_random_winner_external_erc_20_award" using btree("decimals");
create index attr_10_5_single_random_winner_external_erc_20_award_prize_strategy on "sgd0815"."single_random_winner_external_erc_20_award" using gist("prize_strategy", block_range);
create table "sgd0815"."single_random_winner_external_erc_721_award" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "address" bytea not null,
    "token_ids" numeric [],
    "prize_strategy" text
);
alter table "sgd0815"."single_random_winner_external_erc_721_award"
add constraint single_random_winner_external_erc_721_award_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_single_random_winner_external_erc_721_award on "sgd0815"."single_random_winner_external_erc_721_award" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index single_random_winner_external_erc_721_award_block_range_closed on "sgd0815"."single_random_winner_external_erc_721_award"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_11_0_single_random_winner_external_erc_721_award_id on "sgd0815"."single_random_winner_external_erc_721_award" using btree("id");
create index attr_11_1_single_random_winner_external_erc_721_award_address on "sgd0815"."single_random_winner_external_erc_721_award" using btree(substring("address", 1, 64));
create index attr_11_2_single_random_winner_external_erc_721_award_prize_strategy on "sgd0815"."single_random_winner_external_erc_721_award" using gist("prize_strategy", block_range);
create table "sgd0815"."prize_pool_account" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "prize_pool" text not null,
    "account" text not null,
    "timelocked_balance" numeric not null,
    "unlock_timestamp" numeric not null,
    "cumulative_winnings" numeric not null
);
alter table "sgd0815"."prize_pool_account"
add constraint prize_pool_account_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_prize_pool_account on "sgd0815"."prize_pool_account" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index prize_pool_account_block_range_closed on "sgd0815"."prize_pool_account"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_12_0_prize_pool_account_id on "sgd0815"."prize_pool_account" using btree("id");
create index attr_12_1_prize_pool_account_prize_pool on "sgd0815"."prize_pool_account" using gist("prize_pool", block_range);
create index attr_12_2_prize_pool_account_account on "sgd0815"."prize_pool_account" using gist("account", block_range);
create index attr_12_3_prize_pool_account_timelocked_balance on "sgd0815"."prize_pool_account" using btree("timelocked_balance");
create index attr_12_4_prize_pool_account_unlock_timestamp on "sgd0815"."prize_pool_account" using btree("unlock_timestamp");
create index attr_12_5_prize_pool_account_cumulative_winnings on "sgd0815"."prize_pool_account" using btree("cumulative_winnings");
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
create table "sgd0815"."credit_rate" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "prize_pool" text not null,
    "credit_limit_mantissa" numeric not null,
    "credit_rate_mantissa" numeric not null
);
alter table "sgd0815"."credit_rate"
add constraint credit_rate_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_credit_rate on "sgd0815"."credit_rate" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index credit_rate_block_range_closed on "sgd0815"."credit_rate"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_14_0_credit_rate_id on "sgd0815"."credit_rate" using btree("id");
create index attr_14_1_credit_rate_prize_pool on "sgd0815"."credit_rate" using gist("prize_pool", block_range);
create index attr_14_2_credit_rate_credit_limit_mantissa on "sgd0815"."credit_rate" using btree("credit_limit_mantissa");
create index attr_14_3_credit_rate_credit_rate_mantissa on "sgd0815"."credit_rate" using btree("credit_rate_mantissa");
create table "sgd0815"."credit_balance" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "prize_pool" text not null,
    "balance" numeric,
    "timestamp" numeric,
    "initialized" boolean
);
alter table "sgd0815"."credit_balance"
add constraint credit_balance_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_credit_balance on "sgd0815"."credit_balance" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index credit_balance_block_range_closed on "sgd0815"."credit_balance"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_15_0_credit_balance_id on "sgd0815"."credit_balance" using btree("id");
create index attr_15_1_credit_balance_prize_pool on "sgd0815"."credit_balance" using gist("prize_pool", block_range);
create index attr_15_2_credit_balance_balance on "sgd0815"."credit_balance" using btree("balance");
create index attr_15_3_credit_balance_timestamp on "sgd0815"."credit_balance" using btree("timestamp");
create index attr_15_4_credit_balance_initialized on "sgd0815"."credit_balance" using btree("initialized");
create table "sgd0815"."drip_token_player" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "comptroller" text not null,
    "drip_token" bytea not null,
    "address" bytea not null,
    "balance" numeric not null
);
alter table "sgd0815"."drip_token_player"
add constraint drip_token_player_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_drip_token_player on "sgd0815"."drip_token_player" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index drip_token_player_block_range_closed on "sgd0815"."drip_token_player"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_16_0_drip_token_player_id on "sgd0815"."drip_token_player" using btree("id");
create index attr_16_1_drip_token_player_comptroller on "sgd0815"."drip_token_player" using gist("comptroller", block_range);
create index attr_16_2_drip_token_player_drip_token on "sgd0815"."drip_token_player" using btree(substring("drip_token", 1, 64));
create index attr_16_3_drip_token_player_address on "sgd0815"."drip_token_player" using btree(substring("address", 1, 64));
create index attr_16_4_drip_token_player_balance on "sgd0815"."drip_token_player" using btree("balance");
create table "sgd0815"."balance_drip_player" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "balance_drip" text not null,
    "address" bytea not null
);
alter table "sgd0815"."balance_drip_player"
add constraint balance_drip_player_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_balance_drip_player on "sgd0815"."balance_drip_player" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index balance_drip_player_block_range_closed on "sgd0815"."balance_drip_player"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_17_0_balance_drip_player_id on "sgd0815"."balance_drip_player" using btree("id");
create index attr_17_1_balance_drip_player_balance_drip on "sgd0815"."balance_drip_player" using gist("balance_drip", block_range);
create index attr_17_2_balance_drip_player_address on "sgd0815"."balance_drip_player" using btree(substring("address", 1, 64));
create table "sgd0815"."balance_drip" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "comptroller" text not null,
    "source_address" bytea not null,
    "measure_token" bytea not null,
    "drip_token" bytea not null,
    "drip_rate_per_second" numeric,
    "exchange_rate_mantissa" numeric,
    "timestamp" numeric,
    "deactivated" boolean not null
);
alter table "sgd0815"."balance_drip"
add constraint balance_drip_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_balance_drip on "sgd0815"."balance_drip" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index balance_drip_block_range_closed on "sgd0815"."balance_drip"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_18_0_balance_drip_id on "sgd0815"."balance_drip" using btree("id");
create index attr_18_1_balance_drip_comptroller on "sgd0815"."balance_drip" using gist("comptroller", block_range);
create index attr_18_2_balance_drip_source_address on "sgd0815"."balance_drip" using btree(substring("source_address", 1, 64));
create index attr_18_3_balance_drip_measure_token on "sgd0815"."balance_drip" using btree(substring("measure_token", 1, 64));
create index attr_18_4_balance_drip_drip_token on "sgd0815"."balance_drip" using btree(substring("drip_token", 1, 64));
create index attr_18_5_balance_drip_drip_rate_per_second on "sgd0815"."balance_drip" using btree("drip_rate_per_second");
create index attr_18_6_balance_drip_exchange_rate_mantissa on "sgd0815"."balance_drip" using btree("exchange_rate_mantissa");
create index attr_18_7_balance_drip_timestamp on "sgd0815"."balance_drip" using btree("timestamp");
create index attr_18_8_balance_drip_deactivated on "sgd0815"."balance_drip" using btree("deactivated");
create table "sgd0815"."volume_drip_player" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "volume_drip" text not null,
    "address" bytea not null,
    "period_index" numeric not null,
    "balance" numeric not null
);
alter table "sgd0815"."volume_drip_player"
add constraint volume_drip_player_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_volume_drip_player on "sgd0815"."volume_drip_player" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index volume_drip_player_block_range_closed on "sgd0815"."volume_drip_player"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_19_0_volume_drip_player_id on "sgd0815"."volume_drip_player" using btree("id");
create index attr_19_1_volume_drip_player_volume_drip on "sgd0815"."volume_drip_player" using gist("volume_drip", block_range);
create index attr_19_2_volume_drip_player_address on "sgd0815"."volume_drip_player" using btree(substring("address", 1, 64));
create index attr_19_3_volume_drip_player_period_index on "sgd0815"."volume_drip_player" using btree("period_index");
create index attr_19_4_volume_drip_player_balance on "sgd0815"."volume_drip_player" using btree("balance");
create table "sgd0815"."volume_drip_period" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "volume_drip" text not null,
    "period_index" numeric not null,
    "total_supply" numeric,
    "drip_amount" numeric,
    "end_time" numeric,
    "is_dripping" boolean not null
);
alter table "sgd0815"."volume_drip_period"
add constraint volume_drip_period_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_volume_drip_period on "sgd0815"."volume_drip_period" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index volume_drip_period_block_range_closed on "sgd0815"."volume_drip_period"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_20_0_volume_drip_period_id on "sgd0815"."volume_drip_period" using btree("id");
create index attr_20_1_volume_drip_period_volume_drip on "sgd0815"."volume_drip_period" using gist("volume_drip", block_range);
create index attr_20_2_volume_drip_period_period_index on "sgd0815"."volume_drip_period" using btree("period_index");
create index attr_20_3_volume_drip_period_total_supply on "sgd0815"."volume_drip_period" using btree("total_supply");
create index attr_20_4_volume_drip_period_drip_amount on "sgd0815"."volume_drip_period" using btree("drip_amount");
create index attr_20_5_volume_drip_period_end_time on "sgd0815"."volume_drip_period" using btree("end_time");
create index attr_20_6_volume_drip_period_is_dripping on "sgd0815"."volume_drip_period" using btree("is_dripping");
create table "sgd0815"."volume_drip" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "comptroller" text not null,
    "source_address" bytea not null,
    "measure_token" bytea not null,
    "drip_token" bytea not null,
    "referral" boolean not null,
    "period_seconds" numeric,
    "drip_amount" numeric,
    "period_count" numeric,
    "deactivated" boolean not null
);
alter table "sgd0815"."volume_drip"
add constraint volume_drip_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_volume_drip on "sgd0815"."volume_drip" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index volume_drip_block_range_closed on "sgd0815"."volume_drip"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_21_0_volume_drip_id on "sgd0815"."volume_drip" using btree("id");
create index attr_21_1_volume_drip_comptroller on "sgd0815"."volume_drip" using gist("comptroller", block_range);
create index attr_21_2_volume_drip_source_address on "sgd0815"."volume_drip" using btree(substring("source_address", 1, 64));
create index attr_21_3_volume_drip_measure_token on "sgd0815"."volume_drip" using btree(substring("measure_token", 1, 64));
create index attr_21_4_volume_drip_drip_token on "sgd0815"."volume_drip" using btree(substring("drip_token", 1, 64));
create index attr_21_5_volume_drip_referral on "sgd0815"."volume_drip" using btree("referral");
create index attr_21_6_volume_drip_period_seconds on "sgd0815"."volume_drip" using btree("period_seconds");
create index attr_21_7_volume_drip_drip_amount on "sgd0815"."volume_drip" using btree("drip_amount");
create index attr_21_8_volume_drip_period_count on "sgd0815"."volume_drip" using btree("period_count");
create index attr_21_9_volume_drip_deactivated on "sgd0815"."volume_drip" using btree("deactivated");
create table "sgd0815"."multiple_winners_prize_strategy" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "owner" bytea,
    "number_of_winners" numeric,
    "token_listener" bytea,
    "prize_pool" text,
    "rng" bytea,
    "ticket" text,
    "sponsorship" text,
    "prize_period_seconds" numeric not null,
    "prize_period_started_at" numeric not null,
    "prize_period_end_at" numeric not null
);
alter table "sgd0815"."multiple_winners_prize_strategy"
add constraint multiple_winners_prize_strategy_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_multiple_winners_prize_strategy on "sgd0815"."multiple_winners_prize_strategy" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index multiple_winners_prize_strategy_block_range_closed on "sgd0815"."multiple_winners_prize_strategy"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_22_0_multiple_winners_prize_strategy_id on "sgd0815"."multiple_winners_prize_strategy" using btree("id");
create index attr_22_1_multiple_winners_prize_strategy_owner on "sgd0815"."multiple_winners_prize_strategy" using btree(substring("owner", 1, 64));
create index attr_22_2_multiple_winners_prize_strategy_number_of_winners on "sgd0815"."multiple_winners_prize_strategy" using btree("number_of_winners");
create index attr_22_3_multiple_winners_prize_strategy_token_listener on "sgd0815"."multiple_winners_prize_strategy" using btree(substring("token_listener", 1, 64));
create index attr_22_4_multiple_winners_prize_strategy_prize_pool on "sgd0815"."multiple_winners_prize_strategy" using gist("prize_pool", block_range);
create index attr_22_5_multiple_winners_prize_strategy_rng on "sgd0815"."multiple_winners_prize_strategy" using btree(substring("rng", 1, 64));
create index attr_22_6_multiple_winners_prize_strategy_ticket on "sgd0815"."multiple_winners_prize_strategy" using gist("ticket", block_range);
create index attr_22_7_multiple_winners_prize_strategy_sponsorship on "sgd0815"."multiple_winners_prize_strategy" using gist("sponsorship", block_range);
create index attr_22_8_multiple_winners_prize_strategy_prize_period_seconds on "sgd0815"."multiple_winners_prize_strategy" using btree("prize_period_seconds");
create index attr_22_9_multiple_winners_prize_strategy_prize_period_started_at on "sgd0815"."multiple_winners_prize_strategy" using btree("prize_period_started_at");
create index attr_22_10_multiple_winners_prize_strategy_prize_period_end_at on "sgd0815"."multiple_winners_prize_strategy" using btree("prize_period_end_at");
create table "sgd0815"."multiple_winners_external_erc_20_award" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "address" bytea not null,
    "name" text,
    "symbol" text,
    "decimals" numeric,
    "balance_awarded" numeric,
    "prize_strategy" text
);
alter table "sgd0815"."multiple_winners_external_erc_20_award"
add constraint multiple_winners_external_erc_20_award_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_multiple_winners_external_erc_20_award on "sgd0815"."multiple_winners_external_erc_20_award" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index multiple_winners_external_erc_20_award_block_range_closed on "sgd0815"."multiple_winners_external_erc_20_award"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_23_0_multiple_winners_external_erc_20_award_id on "sgd0815"."multiple_winners_external_erc_20_award" using btree("id");
create index attr_23_1_multiple_winners_external_erc_20_award_address on "sgd0815"."multiple_winners_external_erc_20_award" using btree(substring("address", 1, 64));
create index attr_23_2_multiple_winners_external_erc_20_award_name on "sgd0815"."multiple_winners_external_erc_20_award" using btree(left("name", 256));
create index attr_23_3_multiple_winners_external_erc_20_award_symbol on "sgd0815"."multiple_winners_external_erc_20_award" using btree(left("symbol", 256));
create index attr_23_4_multiple_winners_external_erc_20_award_decimals on "sgd0815"."multiple_winners_external_erc_20_award" using btree("decimals");
create index attr_23_5_multiple_winners_external_erc_20_award_balance_awarded on "sgd0815"."multiple_winners_external_erc_20_award" using btree("balance_awarded");
create index attr_23_6_multiple_winners_external_erc_20_award_prize_strategy on "sgd0815"."multiple_winners_external_erc_20_award" using gist("prize_strategy", block_range);
create table "sgd0815"."multiple_winners_external_erc_721_award" (
    vid bigserial primary key,
    block_range int4range not null,
    "id" text not null,
    "address" bytea not null,
    "token_ids" numeric [],
    "prize_strategy" text
);
alter table "sgd0815"."multiple_winners_external_erc_721_award"
add constraint multiple_winners_external_erc_721_award_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_multiple_winners_external_erc_721_award on "sgd0815"."multiple_winners_external_erc_721_award" using brin(
    lower(block_range) int4_minmax_ops,
    coalesce(upper(block_range), 2147483647) int4_minmax_ops,
    vid int8_minmax_ops
);
create index multiple_winners_external_erc_721_award_block_range_closed on "sgd0815"."multiple_winners_external_erc_721_award"(coalesce(upper(block_range), 2147483647))
where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_24_0_multiple_winners_external_erc_721_award_id on "sgd0815"."multiple_winners_external_erc_721_award" using btree("id");
create index attr_24_1_multiple_winners_external_erc_721_award_address on "sgd0815"."multiple_winners_external_erc_721_award" using btree(substring("address", 1, 64));
create index attr_24_2_multiple_winners_external_erc_721_award_prize_strategy on "sgd0815"."multiple_winners_external_erc_721_award" using gist("prize_strategy", block_range);