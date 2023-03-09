-- c-abis-b-c.sql
BEGIN;


SET enable_bitmapscan = ON;


SET enable_indexscan = ON;


SET enable_seqscan = OFF;


SET enable_indexonlyscan = OFF;


DROP INDEX cb_idx;

EXPLAIN ANALYZE
SELECT *
FROM r
WHERE b = 9
    AND c = 10;


ROLLBACK;