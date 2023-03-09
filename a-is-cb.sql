-- a-is-cb.sql
BEGIN;


SET enable_bitmapscan = OFF;


SET enable_indexscan = ON;


SET enable_seqscan = OFF;


DROP INDEX c_idx;

EXPLAIN ANALYZE
SELECT *
FROM r
WHERE c = 10;


ROLLBACK;