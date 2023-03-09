-- d-bis-b.sql
BEGIN;


SET enable_seqscan = OFF;


SET enable_indexonlyscan = OFF;


SET enable_indexscan = OFF;


SET enable_bitmapscan = ON;


DROP INDEX cb_idx;


DROP INDEX c_idx;

EXPLAIN ANALYZE
SELECT *
FROM r
WHERE b > 9
    AND c = 10;


ROLLBACK;