#!/bin/bash

pushd ../common > /dev/null
source ./init.sh
popd > /dev/null

ensure_bake

printf "deleting ${TESTBIN}\r\n"
rm -fr ${TESTBIN}

${BAKE} /recipe:./recipes/${RUNTIME}-bamtoolkit-tests.json

./commands/zip.sh