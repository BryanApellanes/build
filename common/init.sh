#!/bin/bash

export BAMSRCROOT=$1

source ./functions.sh
source ./git-functions.sh

print_line "BAMSRCROOT = ${BAMSRCROOT}" ${BLUE}
initialize ${BAMSRCROOT}

if [[ !(-z ${BAMTOOLKITHOME}) ]]; then
    print_line "creating BAMTOOLKITHOME: ${BAMTOOLKITHOME}" ${YELLOW}
    mkdir -p ${BAMTOOLKITHOME}
fi

if [[ !(-z ${BAMARTIFACTS}) ]]; then
    print_line "creating BAMARTIFACTS: ${BAMARTIFACTS}" ${YELLOW}
    mkdir -p ${BAMARTIFACTS}
fi


