#!/bin/bash

pushd ../common
source ./init.sh
popd

ensure_bake

echo ${BAKE} /discover:${BAMSRCROOT}/_lib/ /recipeOutputDirectory:${OUTPUTLIB} /outputRecipe:${OUTPUTRECIPES}${RUNTIME}-bamfx-lib.json
${BAKE} /discover:${BAMSRCROOT}/_lib/ /recipeOutputDirectory:${OUTPUTLIB} /outputRecipe:${OUTPUTRECIPES}${RUNTIME}-bamfx-lib.json