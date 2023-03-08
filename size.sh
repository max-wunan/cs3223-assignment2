#!/bin/bash

# CS3223 Assignment 2: size.sh
# Script to show information related to the size of the table r & its indexes

DBNAME=assign2

psql -e -d ${DBNAME} <<EOF
-- relation r
select relpages, reltuples from pg_class WHERE relname = 'r';

-- indexes
create extension if not exists pgstattuple;
select tree_level, internal_pages, leaf_pages, index_size from pgstatindex('b_idx'::regclass);
select tree_level, internal_pages, leaf_pages, index_size from pgstatindex('c_idx'::regclass);
select tree_level, internal_pages, leaf_pages, index_size from pgstatindex('cb_idx'::regclass);
EOF

