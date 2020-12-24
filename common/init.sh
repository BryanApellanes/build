#!/bin/bash

source ./functions.sh
source ./git-functions.sh

initialize_defaults
expand_tildes
export_bam_overrides

mkdir -p ${BAMTOOLKITHOME}
mkdir -p ${BAMARTIFACTS}
