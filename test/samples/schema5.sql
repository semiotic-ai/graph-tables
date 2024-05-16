create type sgd0815."bridge_type"
    as enum ('AMB', 'XDAI');
create type sgd0815."transaction_status"
    as enum ('COLLECTING', 'COMPLETED', 'ERROR', 'INITIATED', 'UNCLAIMED');

    create table "sgd0815"."validator" (
        vid                  bigserial primary key,
        block_range          int4range not null,
        "id"                 text not null,
        "name"               text,
        "bridge_type"        "sgd0815"."bridge_type",
        "address"            bytea not null,
        "last_activity"      numeric,
        "hash_added"         text not null,
        "hash_removed"       text,
        "removed"            boolean
    );

    alter table "sgd0815"."validator"
        add constraint validator_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_validator
    on "sgd0815"."validator"
 using brin(lower(block_range) int4_minmax_ops, coalesce(upper(block_range), 2147483647) int4_minmax_ops, vid int8_minmax_ops);
create index validator_block_range_closed
    on "sgd0815"."validator"(coalesce(upper(block_range), 2147483647))
 where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_0_0_validator_id
    on "sgd0815"."validator" using btree("id");
create index attr_0_1_validator_name
    on "sgd0815"."validator" using btree(left("name", 256));
create index attr_0_2_validator_bridge_type
    on "sgd0815"."validator" using btree("bridge_type");
create index attr_0_3_validator_address
    on "sgd0815"."validator" using btree(substring("address", 1, 64));
create index attr_0_4_validator_last_activity
    on "sgd0815"."validator" using btree("last_activity");
create index attr_0_5_validator_hash_added
    on "sgd0815"."validator" using btree(left("hash_added", 256));
create index attr_0_6_validator_hash_removed
    on "sgd0815"."validator" using btree(left("hash_removed", 256));
create index attr_0_7_validator_removed
    on "sgd0815"."validator" using btree("removed");


    create table "sgd0815"."transaction_validation" (
        vid                  bigserial primary key,
        block_range          int4range not null,
        "id"                 text not null,
        "transaction"        text not null,
        "transaction_hash"   bytea,
        "validator"          text not null,
        "validator_addr"     bytea,
        "timestamp"          numeric not null
    );

    alter table "sgd0815"."transaction_validation"
        add constraint transaction_validation_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_transaction_validation
    on "sgd0815"."transaction_validation"
 using brin(lower(block_range) int4_minmax_ops, coalesce(upper(block_range), 2147483647) int4_minmax_ops, vid int8_minmax_ops);
create index transaction_validation_block_range_closed
    on "sgd0815"."transaction_validation"(coalesce(upper(block_range), 2147483647))
 where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_1_0_transaction_validation_id
    on "sgd0815"."transaction_validation" using btree("id");
create index attr_1_1_transaction_validation_transaction
    on "sgd0815"."transaction_validation" using gist("transaction", block_range);
create index attr_1_2_transaction_validation_transaction_hash
    on "sgd0815"."transaction_validation" using btree(substring("transaction_hash", 1, 64));
create index attr_1_3_transaction_validation_validator
    on "sgd0815"."transaction_validation" using gist("validator", block_range);
create index attr_1_4_transaction_validation_validator_addr
    on "sgd0815"."transaction_validation" using btree(substring("validator_addr", 1, 64));
create index attr_1_5_transaction_validation_timestamp
    on "sgd0815"."transaction_validation" using btree("timestamp");


    create table "sgd0815"."transaction_execution" (
        vid                  bigserial primary key,
        block_range          int4range not null,
        "id"                 text not null,
        "transaction"        text not null,
        "transaction_hash"   bytea not null,
        "timestamp"          numeric not null,
        "executor"           text,
        "validator_addr"     bytea
    );

    alter table "sgd0815"."transaction_execution"
        add constraint transaction_execution_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_transaction_execution
    on "sgd0815"."transaction_execution"
 using brin(lower(block_range) int4_minmax_ops, coalesce(upper(block_range), 2147483647) int4_minmax_ops, vid int8_minmax_ops);
create index transaction_execution_block_range_closed
    on "sgd0815"."transaction_execution"(coalesce(upper(block_range), 2147483647))
 where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_2_0_transaction_execution_id
    on "sgd0815"."transaction_execution" using btree("id");
create index attr_2_1_transaction_execution_transaction
    on "sgd0815"."transaction_execution" using gist("transaction", block_range);
create index attr_2_2_transaction_execution_transaction_hash
    on "sgd0815"."transaction_execution" using btree(substring("transaction_hash", 1, 64));
create index attr_2_3_transaction_execution_timestamp
    on "sgd0815"."transaction_execution" using btree("timestamp");
create index attr_2_4_transaction_execution_executor
    on "sgd0815"."transaction_execution" using gist("executor", block_range);
create index attr_2_5_transaction_execution_validator_addr
    on "sgd0815"."transaction_execution" using btree(substring("validator_addr", 1, 64));


    create table "sgd0815"."xdai_transaction" (
        vid                  bigserial primary key,
        block_range          int4range not null,
        "id"                 text not null,
        "transaction_hash"   bytea,
        "bridge_name"        text,
        "initiator"          bytea,
        "initiator_network"  text,
        "initiator_amount"   numeric,
        "initiator_token"    bytea,
        "receiver"           bytea,
        "receiver_network"   text,
        "receiver_amount"    numeric,
        "receiver_token"     bytea,
        "transaction_status" "sgd0815"."transaction_status",
        "timestamp"          numeric,
        "execution"          text,
        "message_id"         bytea
    );

    alter table "sgd0815"."xdai_transaction"
        add constraint xdai_transaction_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_xdai_transaction
    on "sgd0815"."xdai_transaction"
 using brin(lower(block_range) int4_minmax_ops, coalesce(upper(block_range), 2147483647) int4_minmax_ops, vid int8_minmax_ops);
create index xdai_transaction_block_range_closed
    on "sgd0815"."xdai_transaction"(coalesce(upper(block_range), 2147483647))
 where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_3_0_xdai_transaction_id
    on "sgd0815"."xdai_transaction" using btree("id");
create index attr_3_1_xdai_transaction_transaction_hash
    on "sgd0815"."xdai_transaction" using btree(substring("transaction_hash", 1, 64));
create index attr_3_2_xdai_transaction_bridge_name
    on "sgd0815"."xdai_transaction" using btree(left("bridge_name", 256));
create index attr_3_3_xdai_transaction_initiator
    on "sgd0815"."xdai_transaction" using btree(substring("initiator", 1, 64));
create index attr_3_4_xdai_transaction_initiator_network
    on "sgd0815"."xdai_transaction" using btree(left("initiator_network", 256));
create index attr_3_5_xdai_transaction_initiator_amount
    on "sgd0815"."xdai_transaction" using btree("initiator_amount");
create index attr_3_6_xdai_transaction_initiator_token
    on "sgd0815"."xdai_transaction" using btree(substring("initiator_token", 1, 64));
create index attr_3_7_xdai_transaction_receiver
    on "sgd0815"."xdai_transaction" using btree(substring("receiver", 1, 64));
create index attr_3_8_xdai_transaction_receiver_network
    on "sgd0815"."xdai_transaction" using btree(left("receiver_network", 256));
create index attr_3_9_xdai_transaction_receiver_amount
    on "sgd0815"."xdai_transaction" using btree("receiver_amount");
create index attr_3_10_xdai_transaction_receiver_token
    on "sgd0815"."xdai_transaction" using btree(substring("receiver_token", 1, 64));
create index attr_3_11_xdai_transaction_transaction_status
    on "sgd0815"."xdai_transaction" using btree("transaction_status");
create index attr_3_12_xdai_transaction_timestamp
    on "sgd0815"."xdai_transaction" using btree("timestamp");
create index attr_3_13_xdai_transaction_execution
    on "sgd0815"."xdai_transaction" using gist("execution", block_range);
create index attr_3_14_xdai_transaction_message_id
    on "sgd0815"."xdai_transaction" using btree(substring("message_id", 1, 64));


    create table "sgd0815"."amb_transaction" (
        vid                  bigserial primary key,
        block_range          int4range not null,
        "id"                 text not null,
        "transaction_hash"   bytea,
        "bridge_name"        text,
        "initiator"          bytea,
        "initiator_network"  text,
        "initiator_amount"   numeric,
        "initiator_token"    bytea,
        "receiver"           bytea,
        "receiver_network"   text,
        "receiver_amount"    numeric,
        "receiver_token"     bytea,
        "transaction_status" "sgd0815"."transaction_status",
        "timestamp"          numeric,
        "execution"          text,
        "message_id"         bytea
    );

    alter table "sgd0815"."amb_transaction"
        add constraint amb_transaction_id_block_range_excl exclude using gist (id with =, block_range with &&);
create index brin_amb_transaction
    on "sgd0815"."amb_transaction"
 using brin(lower(block_range) int4_minmax_ops, coalesce(upper(block_range), 2147483647) int4_minmax_ops, vid int8_minmax_ops);
create index amb_transaction_block_range_closed
    on "sgd0815"."amb_transaction"(coalesce(upper(block_range), 2147483647))
 where coalesce(upper(block_range), 2147483647) < 2147483647;
create index attr_4_0_amb_transaction_id
    on "sgd0815"."amb_transaction" using btree("id");
create index attr_4_1_amb_transaction_transaction_hash
    on "sgd0815"."amb_transaction" using btree(substring("transaction_hash", 1, 64));
create index attr_4_2_amb_transaction_bridge_name
    on "sgd0815"."amb_transaction" using btree(left("bridge_name", 256));
create index attr_4_3_amb_transaction_initiator
    on "sgd0815"."amb_transaction" using btree(substring("initiator", 1, 64));
create index attr_4_4_amb_transaction_initiator_network
    on "sgd0815"."amb_transaction" using btree(left("initiator_network", 256));
create index attr_4_5_amb_transaction_initiator_amount
    on "sgd0815"."amb_transaction" using btree("initiator_amount");
create index attr_4_6_amb_transaction_initiator_token
    on "sgd0815"."amb_transaction" using btree(substring("initiator_token", 1, 64));
create index attr_4_7_amb_transaction_receiver
    on "sgd0815"."amb_transaction" using btree(substring("receiver", 1, 64));
create index attr_4_8_amb_transaction_receiver_network
    on "sgd0815"."amb_transaction" using btree(left("receiver_network", 256));
create index attr_4_9_amb_transaction_receiver_amount
    on "sgd0815"."amb_transaction" using btree("receiver_amount");
create index attr_4_10_amb_transaction_receiver_token
    on "sgd0815"."amb_transaction" using btree(substring("receiver_token", 1, 64));
create index attr_4_11_amb_transaction_transaction_status
    on "sgd0815"."amb_transaction" using btree("transaction_status");
create index attr_4_12_amb_transaction_timestamp
    on "sgd0815"."amb_transaction" using btree("timestamp");
create index attr_4_13_amb_transaction_execution
    on "sgd0815"."amb_transaction" using gist("execution", block_range);
create index attr_4_14_amb_transaction_message_id
    on "sgd0815"."amb_transaction" using btree(substring("message_id", 1, 64));