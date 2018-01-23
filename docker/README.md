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