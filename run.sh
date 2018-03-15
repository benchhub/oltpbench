#!/usr/bin/env bash

set -e

# switch folder http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null
ORIGINAL_WD=${PWD}
cd ${SCRIPTPATH}

./docker/travis_start.sh
./config/config.py generate --bench=${BENCH} --db=${DB}
./oltpbenchmark --bench ${BENCH} --config config/generated_${BENCH}_${DB}_config.xml --create true --load true --execute true

cd ${ORIGINAL_WD}

./docker/travis_stop.sh