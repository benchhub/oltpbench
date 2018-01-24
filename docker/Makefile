B=cd ..; ./oltpbenchmark
BCONF=config/benchmarks

# TODO: might use a python file ... make file is to hard to reuse, also `sed` is different under mac

##--- database ---#
.PHONY: mysql-up
mysql-up:
	docker-compose -f mysql.yml up
.PHONY: mysql-down
mysql-down:
	docker-compose -f mysql.yml down
.PHONY: mysql-bash
mysql-bash:
	docker-compose -f mysql.yml exec mysql bash
.PHONY: mysql-db-shell
mysql-db-shell:
	docker-compose -f mysql.yml exec mysql mysql -u root -poltpbenchpassword
.PHONY: mysql-create-db
mysql-create-db:
	docker-compose -f mysql.yml exec mysql bash -c 'mysql -u root -poltpbenchpassword -e "CREATE DATABASE IF NOT EXISTS tpcc;"'
##--- database ---#

##--- benchmark ---#
.PHONY: tpcc
tpcc:
# FIXME: sample config is now using `root` and `oltpbenchpassword` instead of empty password
	$(B) -b tpcc -c $(BCONF)/sample_tpcc_config.xml --create=true --load=true --execute=true -s 5 -o tpcc.log
##--- benchmark ---#
