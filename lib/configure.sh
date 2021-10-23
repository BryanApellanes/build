#!/bin/bash

STARTDIR=`pwd`
echo "BAMSRCROOT = ${BAMSRCROOT}"
cd ../common
source ./init.sh
cd 

ensure_bake

echo "BAMLIFECYLE = ${BAMLIFECYCLE}"

./commands/discover.sh

echo "$BAKE /version:Patch /${BAMLIFECYCLE}:1 /versionRecipe:./recipes/${RUNTIME}-bamfx-lib.json"
$BAKE /version:Patch /${BAMLIFECYCLE}:1 /versionRecipe:./recipes/${RUNTIME}-bamfx-lib.json
cd ${STARTDIR}