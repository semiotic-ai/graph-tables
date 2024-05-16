    create table "sgd0815"."ownership_transferred" (
        vid                  bigserial primary key,
        block$                int not null,
"id"                 bytea not null,
        "previous_owner"     bytea not null,
        "new_owner"          bytea not null,
        "block_number"       numeric not null,
        "block_timestamp"    numeric not null,
        "transaction_hash"   bytea not null,
        unique(id)
    );
create index brin_ownership_transferred
    on "sgd0815"."ownership_transferred"
 using brin(block$ int4_minmax_ops, vid int8_minmax_ops);
create index attr_0_0_ownership_transferred_previous_owner
    on "sgd0815"."ownership_transferred" using btree(substring("previous_owner", 1, 64));
create index attr_0_1_ownership_transferred_new_owner
    on "sgd0815"."ownership_transferred" using btree(substring("new_owner", 1, 64));
create index attr_0_2_ownership_transferred_block_number
    on "sgd0815"."ownership_transferred" using btree("block_number");
create index attr_0_3_ownership_transferred_block_timestamp
    on "sgd0815"."ownership_transferred" using btree("block_timestamp");
create index attr_0_4_ownership_transferred_transaction_hash
    on "sgd0815"."ownership_transferred" using btree(substring("transaction_hash", 1, 64));


    create table "sgd0815"."swap" (
        vid                  bigserial primary key,
        block$                int not null,
"id"                 bytea not null,
        "sender"             bytea not null,
        "input_amount"       numeric not null,
        "input_token"        bytea not null,
        "amount_out"         numeric not null,
        "output_token"       bytea not null,
        "slippage"           numeric not null,
        "referral_code"      numeric not null,
        "block_number"       numeric not null,
        "block_timestamp"    numeric not null,
        "transaction_hash"   bytea not null,
        unique(id)
    );
create index brin_swap
    on "sgd0815"."swap"
 using brin(block$ int4_minmax_ops, vid int8_minmax_ops);
create index attr_1_0_swap_sender
    on "sgd0815"."swap" using btree(substring("sender", 1, 64));
create index attr_1_1_swap_input_amount
    on "sgd0815"."swap" using btree("input_amount");
create index attr_1_2_swap_input_token
    on "sgd0815"."swap" using btree(substring("input_token", 1, 64));
create index attr_1_3_swap_amount_out
    on "sgd0815"."swap" using btree("amount_out");
create index attr_1_4_swap_output_token
    on "sgd0815"."swap" using btree(substring("output_token", 1, 64));
create index attr_1_5_swap_slippage
    on "sgd0815"."swap" using btree("slippage");
create index attr_1_6_swap_referral_code
    on "sgd0815"."swap" using btree("referral_code");
create index attr_1_7_swap_block_number
    on "sgd0815"."swap" using btree("block_number");
create index attr_1_8_swap_block_timestamp
    on "sgd0815"."swap" using btree("block_timestamp");
create index attr_1_9_swap_transaction_hash
    on "sgd0815"."swap" using btree(substring("transaction_hash", 1, 64));


    create table "sgd0815"."swap_multi" (
        vid                  bigserial primary key,
        block$                int not null,
"id"                 bytea not null,
        "sender"             bytea not null,
        "amounts_in"         numeric[] not null,
        "tokens_in"          bytea[] not null,
        "amounts_out"        numeric[] not null,
        "tokens_out"         bytea[] not null,
        "referral_code"      numeric not null,
        "block_number"       numeric not null,
        "block_timestamp"    numeric not null,
        "transaction_hash"   bytea not null,
        unique(id)
    );
create index brin_swap_multi
    on "sgd0815"."swap_multi"
 using brin(block$ int4_minmax_ops, vid int8_minmax_ops);
create index attr_2_0_swap_multi_sender
    on "sgd0815"."swap_multi" using btree(substring("sender", 1, 64));
create index attr_2_3_swap_multi_referral_code
    on "sgd0815"."swap_multi" using btree("referral_code");
create index attr_2_4_swap_multi_block_number
    on "sgd0815"."swap_multi" using btree("block_number");
create index attr_2_5_swap_multi_block_timestamp
    on "sgd0815"."swap_multi" using btree("block_timestamp");
create index attr_2_6_swap_multi_transaction_hash
    on "sgd0815"."swap_multi" using btree(substring("transaction_hash",