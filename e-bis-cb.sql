-- e-bis-cb.sql
BEGIN;


SET enable_bitmapscan = ON;


SET enable_seqscan = OFF;


SET enable_indexonlyscan = OFF;


DROP INDEX c_idx;


DROP INDEX b_idx;


SELECT *
FROM r
WHERE b = 6
    AND c < 7;


ROLLBACK;