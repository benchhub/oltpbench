#!/usr/bin/env bash

set -e

# switch folder http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null
ORIGINAL_WD=${PWD}
cd ${SCRIPTPATH}


if [ "$DB" == 'mysql' ]; then 
    docker-compose -f mysql.yml up -d
    sleep 10
    ./create_db.py --bench ${BENCH} --db ${DB}
fi

if [ "$DB" == 'postgres' ]; then 
    docker-compose -f postgres.yml up -d
    sleep 5
    ./create_db.py --bench ${BENCH} --db ${DB}
fi

cd ${ORIGINAL_WD}