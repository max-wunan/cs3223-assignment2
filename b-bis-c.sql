-- b-bis-c.sql
BEGIN;


SET enable_bitmapscan = ON;


SET enable_seqscan = OFF;


SET enable_indexscan = ON;


DROP INDEX cb_idx;


DROP INDEX b_idx;

EXPLAIN ANALYZE
SELECT b
FROM r
WHERE c > 15;


ROLLBACK;

