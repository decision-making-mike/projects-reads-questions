#!/usr/bin/bash

set -eo pipefail

PORT="$1"
if [[ -z "$PORT" ]]
then PORT=5432
fi
TABLES_CREATION_FILE=create-tables.sql
DATA_INSERTION_FILE=insert-data.sql

if [[ ! -f "$TABLES_CREATION_FILE" || ! -f "$DATA_INSERTION_FILE" ]]
then
    echo "File missing error" 1>&2
    exit 1
fi

psql \
    -U postgres \
    -p "$PORT" \
    template1 \
    -c 'drop database "transport-company";' \
    -c 'create database "transport-company";'

if [[ $? != 0 ]]
then
    echo "Database creation error" 1>&2
    exit 1
fi

psql \
    -U postgres \
    -p "$PORT" \
    transport-company \
    -f "$TABLES_CREATION_FILE"

if [[ $? != 0 ]]
then
    echo "Tables creation error" 1>&2
    exit 1
fi

psql \
    -U postgres \
    -p "$PORT" \
    transport-company \
    -f "$DATA_INSERTION_FILE"

if [[ $? != 0 ]]
then
    echo "Data insertion error" 1>&2
    exit 1
fi
