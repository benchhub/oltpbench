# Config

TODO

- how to use another database
- how to use another workload

TODO: there should be a table (generated ...)

## Workloads

- auctionmark
- chbenchmark
- epinions
- hyadapt
- jpab
- linkbench
- noop
- resourcestresser
- seats
- sibench
- smallbank
- tatp
- tpcc
- tpch
- [ ] tpcds
  - pending pr https://github.com/oltpbenchmark/oltpbench/pull/222
- twitter
- voter
- wikipedia
- ycsb

## Databases

TODO: a lot of databases talk in same protocol ...

- `com.oltpbenchmark.types.DatabaseType` defines 
- DB2
- MySQL
- MyRocks
  - [ ] Pending PR https://github.com/oltpbenchmark/oltpbench/pull/189
- PostgreSQL
- Oracle
- SQLServer
  - [ ] Pending PR https://github.com/oltpbenchmark/oltpbench/pull/181
- SQLite
- Amazon RDS
  - [ ] no jdbc string
- SQL Azure 
  - [ ] no jdbc string
- ASSClOWN ... I think it is a ... joke?
- HSQLDB
- H2
- MonentDB
  - [ ] Pending PR https://github.com/oltpbenchmark/oltpbench/pull/183
- NuoDB
- TimesTen
  - [ ] Pending PR https://github.com/oltpbenchmark/oltpbench/pull/190
- Peloton
  - [ ] Known issue https://github.com/cmu-db/peloton/issues/1080
  
In coming databases

- Cassandra https://github.com/oltpbenchmark/oltpbench/pull/220
- Comdb2 https://github.com/oltpbenchmark/oltpbench/pull/184
  - tpcc
  - wikipedia
  - tpch (partitial)
- SAP Hana https://github.com/oltpbenchmark/oltpbench/pull/193
- Splice Machine https://github.com/oltpbenchmark/oltpbench/pull/185
  - https://github.com/splicemachine/spliceengine
- FireBird https://github.com/oltpbenchmark/oltpbench/pull/192
  - https://github.com/FirebirdSQL/firebird
- Cubrid https://github.com/oltpbenchmark/oltpbench/pull/188
  - https://github.com/CUBRID/cubrid
- Clickhouse https://github.com/oltpbenchmark/oltpbench/pull/186
  - https://github.com/yandex/ClickHouse
- MemSQL https://github.com/oltpbenchmark/oltpbench/pull/182
  - https://www.memsql.com/