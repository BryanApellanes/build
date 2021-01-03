#!/bin/bash

# $1 = BAMSRCROOT value

source ./functions.sh
source ./git-functions.sh

initialize $1

mkdir -p ${BAMTOOLKITHOME}
mkdir -p ${BAMARTIFACTS}
