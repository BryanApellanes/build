#!/bin/bash
# The first argument should be the local filesystem path to the root of the Bam.Net git repository

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: bake-recipe.sh [bamNetRootDirectory]\r\n"
    printf "\r\n"
    printf "Uses 'bake' to build bamappservices as specified in the recipe\r\n"
    printf "./recipes/$RUNTIME-bamappservices.json.\r\n"
    printf "\r\n"
    exit 0
fi

source ./get-os-runtime.sh

BAKE=`which bake`

if [[ -z $BAKE ]]; then
    printf "bake utility not found; please build bake first\r\n"    
fi

echo baking `pwd`/recipes/$RUNTIME-bamappservices.json
$BAKE /recipe:./recipes/$RUNTIME-bamappservices.json
