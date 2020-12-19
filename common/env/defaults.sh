#!/bin/bash

pushd defaults

printf "**** DEFAULTS ****\r\n"
for FILE in ./* 
do
    CURRENTVARIABLE=`echo ${FILE} | sed 's#./##'`    
    export $CURRENTVARIABLE=$(<./${FILE})    
    echo "${CURRENTVARIABLE}=$(<./${FILE})"
done
printf "**** / DEFAULTS ****\r\n"

if [[ "${OSTYPE}" == "cygwin" || "${OSTYPE}" == "msys" ]]; then
    echo "setting BAMTOOLKITHOME=${BAMTOOLKITHOMEWINDOWS}"
    export BAMTOOLKITHOME=${BAMTOOLKITHOMEWINDOWS}
    echo "setting BAMARTIFACTS=${BAMARTIFACTSWINDOWS}"
    export BAMARTIFACTS=${BAMARTIFACTSWINDOWS}
    echo "setting OUTPUTBIN=${OUTPUTBINWINDOWS}"
    export OUTPUTBIN=${OUTPUTBINWINDOWS}
    echo "setting OUTPUTLIB=${OUTPUTLIBWINDOWS}"
    export OUTPUTLIB=${OUTPUTLIBWINDOWS}
    echo "setting TESTBIN=${TESTBINWINDOWS}"
    export TESTBIN=${TESTBINWINDOWS}
fi

popd

source ./runtime.sh