#!/bin/bash

if [[ -z ${BAMSRCROOT} ]]; then 
    BAMSRCROOT=$1
fi
BUILDDIR="${BAMSRCROOT}/.bam/build"
STARTDIR=`pwd`

echo "configure.sh: BAMSRCROOT = ${BAMSRCROOT}" ${YELLOW}
cd ../common
source ./init.sh ${BAMSRCROOT}
cd ${STARTDIR}

print_line "baking" ${BLUE}
ensure_bake ${BAMSRCROOT}

echo "BAMLIFECYLE = ${BAMLIFECYCLE}"
print_line "${BUILDDIR}/commands/discover.sh"
${BUILDDIR}/lib/commands/discover.sh

echo "$BAKE /version:Patch /${BAMLIFECYCLE}:1 /versionRecipe:./recipes/${RUNTIME}-bamfx-lib.json"
$BAKE /version:Patch /${BAMLIFECYCLE}:1 /versionRecipe:./recipes/${RUNTIME}-bamfx-lib.json
cd ${STARTDIR}