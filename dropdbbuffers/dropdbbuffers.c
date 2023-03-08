#include "postgres.h"
#include "catalog/catalog.h"
#include "catalog/namespace.h"
#include "catalog/pg_type.h"
#include "funcapi.h"
#include "miscadmin.h"
#include "storage/bufmgr.h"
#include "utils/builtins.h"
#include "utils/rel.h"
#include "commands/dbcommands.h"

PG_MODULE_MAGIC;

PG_FUNCTION_INFO_V1(dropdbbuffers);


Datum
dropdbbuffers (PG_FUNCTION_ARGS)
{
	text       *dbname = PG_GETARG_TEXT_P(0); // database name
	char       *dbstr;
        Oid       db_oid;
	bool 	   result = true;

	dbstr = text_to_cstring(dbname);
	db_oid = get_database_oid(dbstr, true);
	if (OidIsValid(db_oid))
	{
		FlushDatabaseBuffers(db_oid);
		DropDatabaseBuffers(db_oid);
	} else {
		result = false;
		elog(LOG, "dropdbbuffers failed for %s", dbstr);
	}
	pfree(dbstr);
	PG_RETURN_BOOL(result);
}

