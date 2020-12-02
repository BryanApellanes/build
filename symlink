#!/bin/bash

function symlink(){
    LINK=$1
    DEST=$2
    echo ""${OSTYPE}" Creatink link ${LINK} => ${DEST}"
    if [[ "${OSTYPE}" == "linux-gnu" || "${OSTYPE}" == "freebsd"* || "${OSTYPE}" == "darwin"* ]]; then
        echo "using ln"
        ln -s ${DEST} ${LINK}
    fi
    if [[ "${OSTYPE}" == "cygwin" || "${OSTYPE}" == "msys" ]]; then
        echo "using mklink"
        if [[ -d ${DEST} ]]; then
            cmd <<< "mklink /D ${LINK} ${DEST}" 
        else
            cmd <<< "mklink ${LINK} ${DEST}"
        fi
    fi
}

LINK=$1
DEST=$2

symlink ${LINK} ${DEST}