#!/bin/bash

BAMSRCROOT=$1

source ./functions.sh
source ./git-functions.sh

initialize ${BAMSRCROOT}

mkdir -p ${BAMTOOLKITHOME}
mkdir -p ${BAMARTIFACTS}
