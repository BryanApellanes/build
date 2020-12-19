#!/bin/bash

pushd ../common > /dev/null
source ./init.sh
popd > /dev/null

ensure_bake

${BAKE} /recipe:./recipes/${RUNTIME}-bamfx-lib.json
${BAKE} /nuget:./recipes/${RUNTIME}-bamfx-lib.json /nugetOutput:${BAMARTIFACTS}/nugetPackages

push_nugets