-- b-ios-cb.sql
BEGIN;


SET enable_indexonlyscan = ON;


SET enable_bitmapscan = OFF;


SET enable_seqscan = OFF;


SET enable_indexscan = OFF;


DROP INDEX b_idx;


DROP INDEX c_idx;

EXPLAIN ANALYZE
SELECT b
FROM r
WHERE c > 15;


ROLLBACK;