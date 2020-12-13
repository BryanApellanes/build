#!/bin/bash

source ./functions.sh
source ./git-functions.sh

initialize_defaults
expand_tildes

mkdir -p ${BAMTOOLKITHOME}
mkdir -p ${BAMARTIFACTS}