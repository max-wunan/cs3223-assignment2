#!/usr/bin/env bash

# CS3223 Assignment 2: createdb.sh

VERSION=15.0

DOWNLOAD_DIR=$HOME
SRC_DIR=${DOWNLOAD_DIR}/postgresql-${VERSION}
DATA_DIR=$HOME/pgdata
ASSIGN_DIR=$HOME/cs3223_assign2
DBNAME=assign2
DATA_FILE=data.csv


if [ ! -d ${SRC_DIR} ]; then
	echo "ERROR: ${SRC_DIR} missing!"
	exit 1
fi

if [ ! -d ${ASSIGN_DIR} ]; then
	echo "ERROR: ${ASSIGN_DIR} missing!"
	exit 1
fi


# check that server is running
if ! pg_ctl status > /dev/null; then
        echo "ERROR: postgres server is not running!"
        exit 1;
else
	PORT_NUMBER=$(sed -n 4p ${DATA_DIR}/postmaster.pid)
	if [ -z ${PORT_NUMBER} ]; then
		echo "ERROR: Missing ${DATA_DIR}/postmaster.pid file"
		exit 1
	fi
fi
PGPORT=${PORT_NUMBER}

# check if database named $DBNAME exists; if not, create it
if ! psql -l | grep -q "$DBNAME"; then
	createdb "${DBNAME}"
fi

# check that number of shared buffer pages is configured to 5000 pages
if ! psql -c "SHOW shared_buffers;" $DBNAME | grep "40000kB"; then
	echo "ERROR: restart server using -B 5000!"
	exit 1;
fi


# create table r, load data, create indexes, and collect statistics on table
echo "Creating table r & indexes b_idx, c_idx, cb_idx ..."
psql -d ${DBNAME} <<EOF
CREATE EXTENSION IF NOT EXISTS dropdbbuffers;

-- create and load table
DROP INDEX IF EXISTS b_idx, c_idx, cb_idx;
DROP TABLE IF EXISTS r;
CREATE TABLE r (
a bigint,
b bigint,
c bigint,
d bigint
);
ALTER TABLE r ALTER COLUMN b SET STATISTICS 1000, ALTER COLUMN c SET STATISTICS 1000;
\copy r FROM ${DATA_FILE} DELIMITER ',';
ALTER TABLE r ADD PRIMARY KEY (a);
CREATE INDEX b_idx ON r (b);
CREATE INDEX c_idx ON r (c) ;
CREATE INDEX cb_idx ON r (c,b) ;
-- collect statistics  on relation r
VACUUM ANALYZE r;
EOF


