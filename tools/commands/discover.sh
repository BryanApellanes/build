#!/bin/bash

pushd ../common > /dev/null
source ./init.sh
popd > /dev/null

ensure_bake

printf "$BAKE /discover:${BAMSRCROOT}/_tools/ /recipeOutputDirectory:${OUTPUTBIN} /outputRecipe:${OUTPUTRECIPES}${RUNTIME}-bamtoolkit.json\r\n"
$BAKE /discover:${BAMSRCROOT}/_tools/ /recipeOutputDirectory:${OUTPUTBIN} /outputRecipe:${OUTPUTRECIPES}${RUNTIME}-bamtoolkit.json
