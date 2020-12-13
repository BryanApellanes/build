#!/bin/bash

pushd ./common
source ./init.sh
popd

ensure_bake

printf "deleting ${OUTPUTBIN}\r\n"
rm -fr ${OUTPUTBIN}

${BAKE} /recipe:./recipes/${RUNTIME}-bamtoolkit.json /output:${OUTPUTBIN} #/debug:true

./commands/zip.sh