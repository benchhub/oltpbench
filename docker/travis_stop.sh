#!/usr/bin/env bash

set -e

# switch folder http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null
ORIGINAL_WD=${PWD}
cd ${SCRIPTPATH}

docker-compose -f database/${DB}/docker-compose.yml down

cd ${ORIGINAL_WD}