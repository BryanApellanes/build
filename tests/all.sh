#!/bin/bash


function build(){
    source ./configure.sh
    ./clean.sh
    ./build.sh
}

function run_recipe(){
    pushd ./run > /dev/null
    ./run-recipe.sh $1 $2 $3
    popd > /dev/null
}
