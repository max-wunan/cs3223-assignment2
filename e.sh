#!/usr/bin/env bash

# cs3223 Assignment 2: e.sh
# Script for Part E

# Run the query plan specified in query_file 5 times
function run ()
{
	for i in {1..5}
	do
		psql -d ${DBNAME} <<EOF
		SELECT dropdbbuffers('assign2');
		SELECT pg_stat_reset();
EOF
		psql -e -f ${query_file} ${DBNAME}

		psql -d ${DBNAME} <<EOF
		SELECT I.relname, I.heap_blks_read, I.heap_blks_hit, S.seq_scan, S.seq_tup_read
			FROM pg_statio_user_tables  I, pg_stat_user_tables  S
			WHERE I.relid = S.relid
			AND I.relname = 'r'
			;
		SELECT I.relname, I.indexrelname, I.idx_blks_read, I.idx_blks_hit, S.idx_scan, S.idx_tup_read, S.idx_tup_fetch
			FROM pg_statio_user_indexes  I, pg_stat_user_indexes  S
			WHERE I.relid = S.relid AND I.indexrelid = S.indexrelid
			AND I.relname = 'r'
			;
EOF
	done
}


DBNAME=assign2
DATA_DIR=$HOME/pgdata

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

# check that number of shared buffer pages is configured to 5000 pages
if ! psql -c "SHOW shared_buffers;" ${DBNAME} | grep "40000kB"; then
	echo "ERROR: restart server using -B 5000!"
	exit 1;
fi

# check that parallel processing is disabled
if ! psql -c "SHOW max_parallel_workers_per_gather;" ${DBNAME} | grep "0"; then
	echo "max_parallel_workers = 0" >> ${DATA_DIR}/postgresql.conf
	echo "max_parallel_workers_per_gather = 0" >> ${DATA_DIR}/postgresql.conf
	echo "ERROR: Your ${DATA_DIR}/postgresql.conf has been modified. Please restart your PG server"
	exit 1;
fi

# execute each query plan & compute its average execution time
for query_file in e-is-b.sql e-bis-cb.sql
do
	if [ -e ${query_file} ]; then
		output_file=${query_file}.txt
		run >| ${output_file}
		avgtime=$(grep Execution ${output_file} | awk -F" " '{ total += $3; count++ } END { print total/count }')
		echo ${query_file}  ${avgtime}
	else
		echo "ERROR: ${query_file} missing!"
	fi
done


