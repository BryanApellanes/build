#!/bin/bash

# specify /Group:<testGroupName> to run tests for a specific test group

pushd ../common > /dev/null
source ./init.sh
popd > /dev/null
ensure_bamtest
set_git_commit

if [[ -d ${GITCOMMIT} ]]; then
    rm -fr ${GITCOMMIT}
fi

mkdir ${GITCOMMIT}
pushd ${GITCOMMIT}
printf "executing=>${BAMTEST} /Zip:`pwd`/../../recipes/${RUNTIME}-bamtoolkit-tests.json $1 $2 $3"
${BAMTEST} /Recipe:`pwd`/../../recipes/${RUNTIME}-bamtoolkit-tests.json /tag:${GITCOMMIT} $1 $2 $3
popd
