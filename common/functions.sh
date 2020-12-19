#!/bin/bash

BLACK='\033[0;30m'
DARKRED='\033[0;31m'
DARKGREEN='\033[0;32m'
DARKYELLOW='\033[0;33m'
DARKBLUE='\033[0;34m'
DARKPURPLE='\033[0;35m'
DARKCYAN='\033[0;36m'
GRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NOCOLOR='\033[0m'
NC='\033[0m'

function initialize_defaults() {
    if [[ -d ./env ]]; then
        pushd ./env
        source defaults.sh
        popd
    fi
}

function build_tool(){
    TOOLNAME=$1
    TOOLVARIABLE=${1^^}
    rm -fr ~/.bam/tmp/${TOOLNAME}
    dotnet publish ${BAMSRCROOT}/_tools/${TOOLNAME}/${TOOLNAME}.csproj -c Debug -r ${RUNTIME} -o ${BAMTOOLKITHOME}/${TOOLNAME}
    export $TOOLVARIABLE=${BAMTOOLKITHOME}/${TOOLNAME}/${TOOLNAME}    
}

function rebuild_bake(){
    rm `echo $BAKE`    
    ensure_bake
}

function ensure_bake(){
    if [[ -z ${BAKE} || !(-f ${BAKE}) ]]; then
        build_tool bake    
    fi
}

function ensure_bamtest(){
    if [[ -z ${BAMTEST} || !(-f ${BAMTEST}) ]]; then
        build_tool bamtest
    fi
}

function expand_tildes(){    
    export BAMTOOLKITBIN="${BAMTOOLKITBIN/#\~/$HOME}"
    export BAMTOOLKITSYMLINKS="${BAMTOOLKITSYMLINKS/#\~/$HOME}"
    echo "BAMTOOLKITBIN = ${BAMTOOLKITBIN}"
    echo "BAMTOOLKITSYMLINKS = ${BAMTOOLKITSYMLINKS}"
}

function add_to_path(){
    if [[ ! -z "$1" ]]; then
        printf "adding ${1} to the PATH\r\n\r\n"
        [[ ":$PATH:" != *":${1}:"* ]] && export PATH="${1}:${PATH}"
    fi
    printf "PATH = ${PATH}\r\n\r\n"
}

function add_symlinks_to_path(){
    if [[ -z ${BAMTOOLKITSYMLINKS} ]]; then
        printf "BAMTOOLKITSYMLINKS is not set\r\n"
        return 1
    fi
    printf "adding BAMTOOLKITSYMLINKS to the PATH\r\n\r\n"
    HOME=~

    [[ ":$PATH:" != *":${HOME}/.bam/toolkit:"* ]] && export PATH="${HOME}/.bam/toolkit:${PATH}"

    if [[ ! -z ${BAMTOOLKITSYMLINKS} ]]; then
        printf "adding ${BAMTOOLKITSYMLINKS} to the PATH\r\n"
        [[ ":$PATH:" != *":${BAMTOOLKITSYMLINKS}:"* ]] && export PATH="${BAMTOOLKITSYMLINKS}:${PATH}"
    fi
    printf "PATH = ${PATH}\r\n\r\n"
    export PATH=${PATH}
}

function clean_artifacts(){
    if [[ -d ${BAMARTIFACTS} ]]; then
        printf "cleaning artifacts: ${BAMARTIFACTS}"
        pushd ${BAMARTIFACTS}
        rm * -fr
        popd
    fi
}

function set_git_commit(){
    cd ${BAMSRCROOT}
    if [[ -z ${GITCOMMIT} ]]; then
        printf "Setting GITCOMMIT from `pwd`\r\n"
        export GITCOMMIT=`git rev-parse --short HEAD`
    fi
    printf "GITCOMMIT = ${GITCOMMIT}\r\n"
    cd -
}

function push_nugets(){
    if [[ -z ${GITHUB_USERNAME} ]]; then
        echo "push_nugets: GITHUB_USERNAME variable not set"
        return
    fi
    if [[ -z ${GITHUB_ACCESS_TOKEN} ]]; then
        echo "push_nugets: GITHUB_ACCESS_TOKEN variable not set"
        return
    fi
    echo "preparing to push nuget packages"
    GITHUB_PACKAGE_SOURCE="https://nuget.pkg.github.com/okta/index.json"
    echo "adding github package source: ${GITHUB_PACKAGE_SOURCE}"
    dotnet nuget add source ${GITHUB_PACKAGE_SOURCE} -n github -u ${GITHUB_USERNAME} -p ${GITHUB_ACCESS_TOKEN} --store-password-in-clear-text
    echo "setting nuget source to github"
    NUGET_SOURCE="github"
    NUGET_API_KEY=${GITHUB_ACCESS_TOKEN}   
    pushd ${BAMARTIFACTS}/nugetPackages > /dev/null
    for NUGETPACKAGE in $(ls ./*.nupkg)
    do
        echo "Pushing nuget package ${NUGETPACKAGE} to ${NUGET_SOURCE}"
        echo "dotnet nuget push ${NUGETPACKAGE} -k ${NUGET_API_KEY} -s ${NUGET_SOURCE}"
        dotnet nuget push ${NUGETPACKAGE} -k ${NUGET_API_KEY} -s ${NUGET_SOURCE}
    done
    popd > /dev/null
}