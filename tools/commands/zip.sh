#!/bin/bash

source ../common/init.sh

ensure_bake
set_git_commit

echo ${GITCOMMIT} > ${OUTPUTBIN}/${GITCOMMIT}
echo ${RUNTIME} > ${OUTPUTBIN}/${RUNTIME}
${BAKE} /zip:${RUNTIME}-bamtoolkit-${GITCOMMIT}.zip /zipRecipe:${OUTPUTRECIPES}${RUNTIME}-bamtoolkit.json /output:${OUTPUTBIN}

# move for artifact upload
if [[ -f ${OUTPUTBIN}/../bamtoolkit.zip ]]; then
    rm ${OUTPUTBIN}/../bamtoolkit.zip
fi
echo "mv ${OUTPUTBIN}/../${RUNTIME}-bamtoolkit-${GITCOMMIT}.zip ${OUTPUTBIN}/../bamtoolkit.zip"
mv ${OUTPUTBIN}/../${RUNTIME}-bamtoolkit-${GITCOMMIT}.zip ${BAMARTIFACTS}/${RUNTIME}-bamtoolkit-${GITCOMMIT}.zip
cp ${BAMARTIFACTS}/${RUNTIME}-bamtoolkit-${GITCOMMIT}.zip ${OUTPUTBIN}/../bamtoolkit.zip