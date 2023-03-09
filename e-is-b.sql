-- e-is-b.sql
BEGIN;


SET enable_seqscan = OFF;


SET enable_bitmapscan = OFF;


DROP INDEX cb_idx;


DROP INDEX c_idx;


SELECT *
FROM r
WHERE b = 6
    AND c < 7;


ROLLBACK;