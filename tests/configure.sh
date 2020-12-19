#!/bin/bash

pushd ../common > /dev/null
source ./init.sh
popd > /dev/null

ensure_bake

echo "BAMLIFECYLE = ${BAMLIFECYCLE}"

./commands/discover.sh

echo "$BAKE /version:Patch /${BAMLIFECYCLE}:1 /versionRecipe:./recipes/${RUNTIME}-bamtoolkit-tests.json"
$BAKE /version:Patch /${BAMLIFECYCLE}:1 /versionRecipe:./recipes/${RUNTIME}-bamtoolkit-tests.json
