#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: bake-zip-appservices.sh\r\n"
    printf "\r\n"
    printf "Uses 'bake' to zip the bam toolkit as specified in the recipe\r\n"
    printf "./recipes/$RUNTIME-appservices.json.\r\n"
    printf "\r\n"
    exit 0
fi

source ./get-os-runtime.sh

BAKE=`which bake`

if [[ -z $BAKE ]]; then
    printf "bake utility not found; please build bake first\r\n"  
fi

mkdir -p /tmp/bam/appservices
OUTPUT=/tmp/bam/appservices
printf "OUTPUT = $OUTPUT\r\n"
$BAKE /zip /zipRecipe:./recipes/${RUNTIME}-bamappservices.json /output:${OUTPUT}
