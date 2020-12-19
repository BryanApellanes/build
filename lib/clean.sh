#!/bin/bash

pushd ../common > /dev/null
source ./init.sh
popd > /dev/null

ensure_bake

$BAKE /clean:${OUTPUTRECIPES}${RUNTIME}-bamfx-lib.json
