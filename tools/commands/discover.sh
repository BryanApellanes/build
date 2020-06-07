#!/bin/bash

source ../common/init.sh

ensure_bake

printf "$BAKE /discover:${BAMSRCROOT}/_tools/ /output:${OUTPUTBIN} /outputRecipe:${OUTPUTRECIPES}${RUNTIME}-bamtoolkit.json\r\n"
$BAKE /discover:${BAMSRCROOT}/_tools/ /output:${OUTPUTBIN} /outputRecipe:${OUTPUTRECIPES}${RUNTIME}-bamtoolkit.json
