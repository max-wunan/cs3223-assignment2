-- sample-is-b.sql
SET enable_seqscan = OFF;
SET enable_bitmapscan = OFF;
EXPLAIN ANALYZE  SELECT * FROM r WHERE b=9;
