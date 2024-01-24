#!/bin/bash

set -e
set -u

psql -v ON_ERROR_STOP=1 --username "$DB_USER" <<-EOSQL
		CREATE DATABASE ${DB_NAME}_test;
	    GRANT ALL PRIVILEGES ON DATABASE ${DB_NAME}_test TO "$DB_USER";
EOSQL
