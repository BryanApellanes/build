#!/bin/bash

# The first argument should be the local filesystem path to the root of the Bam.Net git repository

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]
then
    printf "usage: bake-discover-tools-recipe {{path to Bam.Net.Core}}\r\n"
    printf "\r\n"
    printf "Builds a temporary copy of 'bake' and uses it to discover tools in the specified Bam.Net.Core root.\r\n"
    printf "'bake' looks for *.csproj files in the child directories of the _tools directory in the specified root.\r\n"
    printf "\r\n"
    exit 0
fi

source ./get-os-runtime.sh

OUTPUTRECIPES=./recipes/

BAKE=`which bake`

if [[ -z $BAKE ]]; then
    printf "bake utility not found; please build bake first\r\n"  
fi

$BAKE /discover:./_tools/ /output:/tmp/bam/bin /outputRecipe:${OUTPUTRECIPES}${RUNTIME}-bamappservices-tools.json
