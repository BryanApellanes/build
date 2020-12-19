#!/bin/bash

pushd ../common > /dev/null
source ./init.sh
popd > /dev/null

ensure_bake

echo "$BAKE /discover:${BAMSRCROOT}/_tests/core/ /output:${TESTBIN} /outputRecipe:${OUTPUTRECIPES}${RUNTIME}-bamtoolkit-tests.json"
$BAKE /discover:${BAMSRCROOT}/_tests/core/ /output:${TESTBIN} /outputRecipe:${OUTPUTRECIPES}${RUNTIME}-bamtoolkit-tests.json
