#!/bin/bash

pushd ./common
source ./init.sh
popd

ensure_bake

echo "BAMLIFECYLE = ${BAMLIFECYCLE}"

./commands/discover.sh

$BAKE /version:Patch /versionRecipe:./recipes/${RUNTIME}-bamtoolkit.json
