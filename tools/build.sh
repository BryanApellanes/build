#!/bin/bash

# argument if supplied is treated as BAMSRCROOT

pushd ../common > /dev/null
source ./init.sh $1
popd > /dev/null

ensure_bake

printf "deleting ${OUTPUTBIN}\r\n"
rm -fr ${OUTPUTBIN}

echo "BAKING recipe ./recipes/${RUNTIME}-bamtoolkit.json into ${OUTPUTBIN}"
${BAKE} /recipe:./recipes/${RUNTIME}-bamtoolkit.json /output:${OUTPUTBIN}

echo "BAKING nugets ./recipes/${RUNTIME}-bamtoolkit.json into ${BAMARTIFACTS}/nugetPackages"
${BAKE} /nuget:./recipes/${RUNTIME}-bamtoolkit.json /nugetOutput:${BAMHOME}/nugetPackages

./commands/zip.sh