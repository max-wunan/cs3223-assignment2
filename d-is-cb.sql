-- d-is-cb.sql
BEGIN;


SET enable_seqscan = OFF;


SET enable_bitmapscan = OFF;


SET enable_indexscan = ON;


DROP INDEX b_idx;


DROP INDEX c_idx;


SELECT *
FROM r
WHERE b > 9
    AND c = 10;


ROLLBACK;