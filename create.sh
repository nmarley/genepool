#! /bin/bash

# random password
echo 'G3n3PO0L'
createuser genepool -DRSPl
createdb -O genepool -E UTF8 genepool

