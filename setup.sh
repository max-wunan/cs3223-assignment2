#!/usr/bin/env bash

# CS3223 Assignment 2: setup.sh
# Script to disable parallel query plans & install two required PostgreSQL extensions

VERSION=15.0

DOWNLOAD_DIR=$HOME
DATA_DIR=$HOME/pgdata
SRC_DIR=${DOWNLOAD_DIR}/postgresql-${VERSION}
ASSIGN_DIR=$HOME/cs3223_assign2
DBNAME=assign2

if [ ! -d ${SRC_DIR} ]; then
	echo "ERROR: ${SRC_DIR} missing!"
	exit 1
fi

if [ ! -d ${ASSIGN_DIR} ]; then
	echo "ERROR: ${ASSIGN_DIR} missing!"
	exit 1
fi

# disable parallel processing
echo "Modifying ${DATA_DIR}/postgresql.conf ..."
echo "max_parallel_workers = 0" >> ${DATA_DIR}/postgresql.conf
echo "max_parallel_workers_per_gather = 0" >> ${DATA_DIR}/postgresql.conf

# install pgstattuple extension
echo "Installing pgstattuple extension ..."
DIR=${SRC_DIR}/contrib/pgstattuple
if [ -d ${DIR} ]; then
	cd ${DIR}
	make && make install 
else
	echo "ERROR: ${DIR} missing!"
	exit 1
fi

# install dropdbbuffers extension
echo "Installing dropdbbuffers extension ..."
DIR=${SRC_DIR}/contrib/dropdbbuffers
if [ ! -d ${DIR} ]; then
	cp -r ${ASSIGN_DIR}/dropdbbuffers ${SRC_DIR}/contrib
	cd ${DIR}
	make && make install 
fi

cd ${ASSIGN_DIR}
chmod u+x *.sh


