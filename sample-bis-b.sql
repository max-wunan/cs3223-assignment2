-- sample-bis-b.sql
SET enable_seqscan = OFF;
SET enable_bitmapscan = ON;
EXPLAIN ANALYZE  SELECT * FROM r WHERE b=9;
