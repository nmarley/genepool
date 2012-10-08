#! /bin/bash

dbicdump -o db_schema=genepool GenePool::DBIC 'dbi:Pg:dbname=genepool' genepool 'G3n3PO0L' '{pg_enable_utf8 => 1}'

