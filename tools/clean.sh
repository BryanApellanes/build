#!/bin/bash

pushd ../common
source ./init.sh
popd

ensure_bake

$BAKE /clean:${OUTPUTRECIPES}${RUNTIME}-bamtoolkit.json
