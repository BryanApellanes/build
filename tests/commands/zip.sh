#!/bin/bash

pushd ../common > /dev/null
source ./init.sh
popd > /dev/null

ensure_bake
ensure_bamtest
set_git_commit


echo ${GITCOMMIT} > ${TESTBIN}/${GITCOMMIT}
echo ${RUNTIME} > ${TESTBIN}/${RUNTIME}
${BAKE} /zip:${RUNTIME}-bamtoolkit-${GITCOMMIT}-tests.zip /zipRecipe:${OUTPUTRECIPES}${RUNTIME}-bamtoolkit-tests.json /output:${TESTBIN}

if [[ -f ${TESTBIN}/../bamtoolkit-tests.zip ]]; then
    rm ${TESTBIN}/../bamtoolkit-tests.zip
fi
mv ${TESTBIN}/../${RUNTIME}-bamtoolkit-${GITCOMMIT}-tests.zip ${BAMARTIFACTS}/bamtoolkit-tests-${GITCOMMIT}.zip
rm -fr ${BAMARTIFACTS}/bamtest/
cp -R ${BAMTOOLKITHOME}/bamtest/ ${BAMARTIFACTS}/bamtest/
