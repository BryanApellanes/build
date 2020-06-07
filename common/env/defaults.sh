#!/bin/bash

cd defaults
printf "**** DEFAULTS ****\r\n"
for FILE in ./* 
do
    CURRENTVARIABLE=`echo ${FILE} | sed 's#./##'`    
    export $CURRENTVARIABLE=$(<./${FILE})    
    echo "${CURRENTVARIABLE}=$(<./${FILE})"
done
printf "**** / DEFAULTS ****\r\n"

cd ..

source ./runtime.sh