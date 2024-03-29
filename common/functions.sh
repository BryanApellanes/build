#!/bin/bash

#echo colors
#BOLD=$(tput bold)
#BLACK=$(tput setaf 0)
#WHITE=$(tput setaf 7)
#BLUE=$(tput setaf 4)
#GREEN=$(tput setaf 2)
#NORMAL=$(tput sgr0)

# printf colors
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

function print(){
    MSG=$1
    COLOR=$2
    if [[ -z ${COLOR} ]]; then 
        COLOR=${NOCOLOR}
    fi
    printf "${COLOR}${MSG}${NC}"
}

function print_line(){
    MSG=$1
    COLOR=${GRAY}
    if [[ !(-z ${2+x}) ]]; then
        COLOR=${2}
    fi
    print "${MSG}" "${COLOR}"
    printf "\r\n"
}

function export_windows_overrides(){ 
    print_line "exporting windows overrides" ${CYAN}   
    if [[ "${OSTYPE}" == "cygwin" || "${OSTYPE}" == "msys" ]]; then
        print_line "*** WINDOWS OVERRIDES ***" ${BLUE}
        print_line "setting BAMHOME=${BAMHOMEWINDOWS}" ${BLUE}
        export BAMHOME=${BAMHOMEWINDOWS}
        print_line "setting BAMTOOLKITHOME=${BAMTOOLKITHOMEWINDOWS}" ${BLUE}
        export BAMTOOLKITHOME=${BAMTOOLKITHOMEWINDOWS}
        print_line "setting BAMARTIFACTS=${BAMARTIFACTSWINDOWS}" ${BLUE}
        export BAMARTIFACTS=${BAMARTIFACTSWINDOWS}
        print_line "setting DIST=${DISTWINDOWS}" ${BLUE}
        export DIST=${DISTWINDOWS}
        print_line "setting OUTPUTBIN=${OUTPUTBINWINDOWS}" ${BLUE}
        export OUTPUTBIN=${OUTPUTBINWINDOWS}
        print_line "setting OUTPUTLIB=${OUTPUTLIBWINDOWS}" ${BLUE}
        export OUTPUTLIB=${OUTPUTLIBWINDOWS}
        print_line "setting TESTBIN=${TESTBINWINDOWS}" ${BLUE}
        export TESTBIN=${TESTBINWINDOWS}

        print_line "checking for ${BAMHOME}/env/windows_overrides" ${DARKCYAN}
        if [[ -d ${BAMHOME}/env/windows_overrides ]]; then
            unset_var_dir ${BAMHOME}/env/windows_overrides
            export_var_dir ${BAMHOME}/env/windows_overrides
        else
            print_line "${BAMHOME}/env/windows_overrides doesn't exist" ${DARKYELLOW}
        fi

        print_line "*** / WINDOWS OVERRIDES ***" ${BLUE}
        return
    fi
    print_line "not windows" ${YELLOW}
}

function export_var_dir(){
    STARTDIR=`pwd`
    DIRECTORY=$1

    if [[ -z "$DIRECTORY" ]]; then
        return
    fi

    if [[ ! -d "$DIRECTORY" ]]; then
        return
    fi

    cd ${DIRECTORY}
    print_line "**** EXPORTING ENVIRONMENT VARIABLES: VARDIR = '${DIRECTORY}' ****" ${CYAN}
    for FILE in ./* 
    do
        CURRENTVARIABLE=`echo ${FILE} | sed 's#./##'`  
        export $CURRENTVARIABLE=$(<./${FILE})    
        print_line "${CURRENTVARIABLE}=$(<./${FILE})" ${DARKCYAN}
    done
    print_line "**** / EXPORTING ENVIRONMENT VARIABLES: VARDIR = '${DIRECTORY}' ****" ${CYAN}
    cd ${STARTDIR}
}

function unset_var_dir(){
    STARTDIR=`pwd`
    DIRECTORY=$1

    if [[ -z "$DIRECTORY" ]]; then
        return
    fi

    if [[ ! -d "$DIRECTORY" ]]; then
        return
    fi

    cd ${DIRECTORY}
    print_line "**** UNSETTING ENVIRONMENT VARIABLES: VARDIR = '${DIRECTORY}' ****" ${DARKYELLOW}
    for FILE in ./* 
    do
        CURRENTVARIABLE=`echo ${FILE} | sed 's#./##'`  
        export $CURRENTVARIABLE=
        print_line "${CURRENTVARIABLE}=" ${DARKYELLOW}
    done
    print_line "**** / UNSETTING ENVIRONMENT VARIABLES: VARDIR = '${DIRECTORY}' ****" ${DARKYELLOW}
    cd ${STARTDIR}
}

function set_runtime(){
    if [[ -z "${RUNTIME+x}" ]]; then 
        if [[ "${OSTYPE}" == "linux-gnu" ]]
            then RUNTIME=ubuntu.16.10-x64
        fi
        if [[ "${OSTYPE}" == "darwin"* ]]
            then RUNTIME=osx-x64
        fi
        if [[ "${OSTYPE}" == "cygwin" ]]
            then RUNTIME=win10-x64
        fi
        if [[ "${OSTYPE}" == "msys" ]]
            then RUNTIME=win10-x64
        fi
        if [[ "${OSTYPE}" == "freebsd"* ]]
            then RUNTIME=osx-x64
        fi

        export RUNTIME
        print_line "'RUNTIME is' ${RUNTIME}" ${DARKYELLOW}
    fi
}

function set_git_vars(){
      if [[ -z ${CI_USERNAME+x} ]]; then
        CI_USERNAME="ci"
      fi
      if [[ -z ${CI_EMAIL+x} ]]; then
        CI_EMAIL="ci@threeheadz.com"
      fi
      if [[ -z ${COMMIT_TO_BRANCH+x} ]]; then
        COMMIT_TO_BRANCH="bam-net-core-test"
      fi
      if [[ -z ${GIT_COMMIT_MESSAGE+x} ]]; then
        GIT_COMMIT_MESSAGE="committed by github action (bam-net-core-dev)"
      fi
      if [[ -z ${GIT_COMMIT_AUTHOR+x} ]]; then
        GIT_COMMIT_AUTHOR="ci <ci@threeheadz.com>"
      fi
      if [[ -z ${GIT_ADD_FILE_PATTERN+x} ]]; then
        GIT_ADD_FILE_PATTERN="."
      fi
      if [[ -z ${GIT_COMMIT_OPTIONS+x} ]]; then
        GIT_COMMIT_OPTIONS=""
      fi        
}

function initialize_variables() {
    print_line "*** functions.sh.initialize_variables()" ${CYAN}
    STARTDIR=`pwd`
    BAM_ENV=$1
    if [[ -z ${BAM_ENV} ]]; then
        BAM_ENV="defaults"
    fi
    set_git_vars
    SCRIPTDIR=${BAMSRCROOT}/.bam/build/common
    unset_var_dir ${SCRIPTDIR}/env/${BAM_ENV}
    export_var_dir ${SCRIPTDIR}/env/${BAM_ENV}
    
    print_line "*** / functions.sh.initialize_variables()" ${CYAN}
    
    export_windows_overrides
    
    set_runtime

    cd ${STARTDIR}
}

function initialize(){
    print_line "*** executing functions.sh_initialize() ***" ${CYAN}
    STARTDIR=`curdir`
    if [[ -z ${BAM_ENV} ]]; then
        BAM_ENV="defaults"
    fi
    SRCTEMP=$1
    if [[ -z ${SRCTEMP} ]] && [[ !(-z ${BAMSRCROOT}) ]]; then
        SRCTEMP=${BAMSRCROOT}
    fi
    if [[ -z ${SRCTEMP} ]]; then
        SRCTEMP=`curdir`
    fi
    if [[ -z ${SRCTEMP} ]]; then
        print_line "Unable to determine value for BAMSRCROOT"
        exit 1
    fi
    print_line "SRCTEMP = ${SRCTEMP}" ${DARKGREEN}
    print_line "BAM_ENV = ${BAM_ENV}" ${GREEN}
    cd ${SRCTEMP} 
    initialize_variables ${BAM_ENV}
    expand_tildes
    set_git_commit
    cd ${STARTDIR}
}

function build_tool(){
    TOOLNAME=$1
    TOOLVARIABLE=${1^^}
    dotnet publish ${BAMSRCROOT}/_tools/${TOOLNAME}/${TOOLNAME}.csproj -c Debug -r ${RUNTIME} -o ${BAMTOOLKITHOME}/${TOOLNAME}
    export $TOOLVARIABLE=${BAMTOOLKITHOME}/${TOOLNAME}/${TOOLNAME}    
}

function rebuild_tool(){
    TOOLNAME=$1
    rm ${BAMTOOLKITHOME}/${TOOLNAME}/${TOOLNAME}
    build_tool ${TOOLNAME}
}

function rebuild_bake(){
    rm `echo $BAKE`    
    ensure_bake
}

function ensure_bake(){
    BAMSRCROOT=$1
    STARTDIR=`pwd`
    print_line "BAMSRCROOT = ${BAMSRCROOT}" ${CYAN}
    print_line "CURDIR = `pwd`" ${YELLOW}
    if [[ -z ${BAKE} || !(-f ${BAKE}) ]]; then
        if [[ -f ${BAMSRCROOT}/_tools/bake/bake.csproj ]]; then
            build_tool bake
        elif [[ -f ${BAMSRCROOT}/_tools/bam/bam.csproj ]]; then
            build_tool bam
            $BAM /install:bake
        else
            print_line "UNABLE TO INSTALL BUILD TOOLS, ${BAMSRCROOT}/_tools/bake/bake.csproj NOT FOUND" $RED
            exit 1
        fi
    fi
    cd ${STARTDIR}
}

function ensure_bamtest(){
    if [[ -z ${BAMTEST} || !(-f ${BAMTEST}) ]]; then
        build_tool bamtest
    fi
}

function expand_tildes(){    
    export BAMTOOLKITBIN="${BAMTOOLKITBIN/#\~/$HOME}"
    export BAMTOOLKITSYMLINKS="${BAMTOOLKITSYMLINKS/#\~/$HOME}"
    print_line "BAMTOOLKITBIN = ${BAMTOOLKITBIN}" $DARKBLUE
    print_line "BAMTOOLKITSYMLINKS = ${BAMTOOLKITSYMLINKS}" $DARKBLUE
    print_line ""
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
    STARTDIR=`pwd`
    print_line "BAMARTIFACTS = ${BAMARTIFACTS}"
    if [[ -d ${BAMARTIFACTS} ]]; then
        print_line "cleaning artifacts: ${BAMARTIFACTS}" ${DARKYELLOW}
        pushd ${BAMARTIFACTS} > /dev/null
        rm * -fr
        popd > /dev/null
    fi
}

function set_git_commit(){
    STARTDIR=`pwd`
    cd ${BAMSRCROOT} 
    if [[ -z ${GITCOMMIT+x} ]]; then
        print_line "Setting GITCOMMIT from `pwd`" ${DARKGREEN}
        export GITCOMMIT=`git rev-parse --short HEAD`
    fi
    if [[ !(-f ./gitcommit )]]; then
        echo ${GITCOMMIT} > ./gitcommit
    fi
    print_line "GITCOMMIT = ${GITCOMMIT}" ${GREEN}

    cd ${STARTDIR}
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

function curdir(){
    if [[ "${OSTYPE}" == "cygwin" || "${OSTYPE}" == "msys" ]]; then
        pwd -W
    else
        pwd
    fi    
}