# Development Environment Setup

## DB

Just use docker at first, might have very bad result using default configuration,
but easy to test if things are correct locally.

## IDE

IDEA is the best choice, but due to some jars are not public accessable, it is not working properly.

### Oracle

- there is ongoing PR https://github.com/oltpbenchmark/oltpbench/pull/187
- Base on `pom.xml` it seems old version of jar is used
  - 10.2.0.1.0
  - http://www.oracle.com/technetwork/database/enterprise-edition/jdbc-10201-088211.html
- and you need Oracle account to download it
