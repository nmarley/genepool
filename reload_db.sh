#! /bin/bash

dropdb genepool
createdb -O genepool -E UTF8 genepool
psql -U genepool < genepool.pgsql 

