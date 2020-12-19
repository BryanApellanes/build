#!/bin/bash

pushd ../common > /dev/null
source ./init.sh
popd > /dev/null

ensure_bake

echo "$BAKE /clean:${OUTPUTRECIPES}${RUNTIME}-bamtoolkit-tests.json"
$BAKE /clean:${OUTPUTRECIPES}${RUNTIME}-bamtoolkit-tests.json
