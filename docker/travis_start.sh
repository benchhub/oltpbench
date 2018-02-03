#!/usr/bin/env bash

# switch folder http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null
ORIGINAL_WD=${PWD}
cd ${SCRIPTPATH}

CREATE_DB_SQL="CREATE DATABASE IF NOT EXISTS ${BENCH};"

if [ "$DB" == 'mysql' ]; then 
    docker-compose -f mysql.yml up -d
    sleep 10
    # FIXME: CREATE_DB_SQL does not work ....
    docker-compose -f mysql.yml exec mysql bash -c 'mysql -u root -poltpbenchpassword -e "CREATE DATABASE IF NOT EXISTS tpcc;"'
fi

if [ "$DB" == 'postgres' ]; then 
    docker-compose -f postgres.yml up -d
    sleep 5
    # FIXME: CREATE_DB_SQL does not work ....
    docker-compose -f postgres.yml exec postgres bash -c 'psql -U oltpbench -h 127.0.0.1 -c "CREATE DATABASE IF NOT EXISTS tpcc;"'
fi

cd ${ORIGINAL_WD}