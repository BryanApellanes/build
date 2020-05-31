#!/bin/bash
# The first argument should be the local filesystem path to the root of the Bam.Net git repository

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: bake-recipe.sh\r\n"
    printf "\r\n"
    printf "First builds the 'bake' utility found at the specified root directory.\r\n"
    printf "Then uses 'bake' to build the bam toolkit as specified in the recipe\r\n"
    printf "./recipes/$RUNTIME-bamtoolkit.json.\r\n"
    printf "\r\n"
    exit 0
fi

source ./get-os-runtime.sh

BAKE=`which bake`

if [[ -z $BAKE ]]; then
    printf "bake utility not found; please build bake first\r\n"    
fi

echo baking `pwd`/recipes/${RUNTIME}-bamappservices-lib.json
${BAKE} /recipe:./recipes/${RUNTIME}-bamappservices-lib.json