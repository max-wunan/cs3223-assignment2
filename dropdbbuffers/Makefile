# contrib/test_buffer/Makefile

MODULE_big	= dropdbbuffers
OBJS		= dropdbbuffers.o

EXTENSION = dropdbbuffers
DATA = dropdbbuffers--1.0.sql

ifdef USE_PGXS
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
else
subdir = contrib/dropdbbuffers
top_builddir = ../..
include $(top_builddir)/src/Makefile.global
include $(top_srcdir)/contrib/contrib-global.mk
endif
