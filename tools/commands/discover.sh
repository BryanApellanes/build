#!/bin/bash

pushd ./common
source ./init.sh
popd

ensure_bake

printf "$BAKE /discover:${BAMSRCROOT}/_tools/ /outputDirectory:${OUTPUTBIN} /outputRecipe:${OUTPUTRECIPES}${RUNTIME}-bamtoolkit.json\r\n"
$BAKE /discover:${BAMSRCROOT}/_tools/ /outputDirectory:${OUTPUTBIN} /outputRecipe:${OUTPUTRECIPES}${RUNTIME}-bamtoolkit.json
