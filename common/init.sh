#!/bin/bash

source ../common/functions.sh
source ../common/git-functions.sh

initialize_defaults
expand_tildes

mkdir -p ${BAMTOOLKITHOME}
mkdir -p ${BAMARTIFACTS}