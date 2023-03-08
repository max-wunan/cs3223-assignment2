#!/usr/bin/env bash

# CS3223 Assignment 2: install_pg.sh
# Script to re-install postgresql server

VERSION=15.0

ASSIGN_DIR=$HOME/cs3223_assign2
DOWNLOAD_DIR=$HOME
SRC_DIR=${DOWNLOAD_DIR}/postgresql-${VERSION}
INSTALL_DIR=$HOME/pgsql
DATA_DIR=$HOME/pgdata
FILE=postgresql-${VERSION}.tar.gz

rm -rf ${SRC_DIR}
rm -rf ${INSTALL_DIR}
rm -rf ${DATA_DIR}
mkdir -p ${INSTALL_DIR}
mkdir -p ${DATA_DIR}

# Download PostgreSQL source files
cd ${DOWNLOAD_DIR}
wget https://ftp.postgresql.org/pub/source/v${VERSION}/$FILE
tar xvfz ${FILE}


# Install PostgreSQL
cd ${SRC_DIR}
export CFLAGS="-O2"
./configure --prefix=${INSTALL_DIR} --enable-debug  --enable-cassert
make clean
make world
make install
# make install-docs


# Create a database cluster
${INSTALL_DIR}/bin/initdb -D ${DATA_DIR}

