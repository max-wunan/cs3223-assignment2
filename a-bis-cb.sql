-- a-bis-cb.sql
BEGIN;


SET enable_bitmapscan = ON;


SET enable_indexscan = ON;


SET enable_seqscan = OFF;


DROP INDEX c_idx;

EXPLAIN ANALYZE
SELECT *
FROM r
WHERE c = 10;


ROLLBACK;