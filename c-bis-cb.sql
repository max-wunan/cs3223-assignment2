-- c-bis-cb.sql
BEGIN;


SET enable_seqscan = OFF;


SET enable_indexonlyscan = OFF;


SET enable_bitmapscan = ON;


DROP INDEX b_idx;


DROP INDEX c_idx;

EXPLAIN ANALYZE
SELECT *
FROM r
WHERE b = 9
    AND c = 10;


ROLLBACK;