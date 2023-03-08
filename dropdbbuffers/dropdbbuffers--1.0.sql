/* contrib/dropdbbuffers/dropdbbuffers--1.0.sql */

-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION dropdbbuffers" to load this file. \quit

--
-- dropdbbuffers()
--
CREATE FUNCTION dropdbbuffers(text) RETURNS boolean
AS 'MODULE_PATHNAME', 'dropdbbuffers'
LANGUAGE C STRICT;

