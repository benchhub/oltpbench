# Docker config to setup and run things locally

TODO

- [ ] builder image (may require oracle jar?)
- [ ] docker compose file for database
- [ ] UI

## Installation

TODO

- [ ] links for install on mac?
- [ ] links to download `.deb` directly for ubuntu

## Usage

````bash
docker-compose -f mysql.yml up
````

 ./oltpbenchmark --bench "${TEST}" --config "${config}"  --create true    --load true   --execute true ;

````bash
# inside docker folder
export BENCH=tpcc
export DB=mysql
./travis_start
../config/config.py generate --bench=${BENCH} --db=${DB}
../oltpbenchmark --bench ${BENCH} --config config/generated_${BENCH}_${DB}_config.xml --create true --load true --execute true
````

## Development

TODO

- [ ] use variable https://docs.docker.com/compose/compose-file/#variable-substitution
  - `.env` for setting version
  - `${VARIABLE:-default}` will evaluate to `default` if `VARIABLE` is unset or empty in the environment
- [ ] add a new compose file

## Databases

- MySQL
  - 5.7 Default
  - 8.0 won't work https://github.com/benchhub/forks/issues/2
- Postgres
  - 10.1 Default