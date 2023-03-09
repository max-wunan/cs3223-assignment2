-- d-abis-b-c.sql
SET enable_bitmapscan = ON;


SET enable_indexscan = ON;


SET enable_indexonlyscan = OFF;


SET enable_seqscan = OFF;


DROP INDEX cb_idx;


SELECT *
FROM r
WHERE b > 9
    AND c = 10;


ROLLBACK;