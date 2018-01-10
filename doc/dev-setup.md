# Development Environment Setup

There is a one page official wiki https://github.com/oltpbenchmark/oltpbench/wiki

## Usage

.travis.yml could be a start point ...

wonder where is the distributed test described in the paper, ssh into server and collect metrics etc.

## DB

Just use docker at first, might have very bad result using default configuration,
but easy to test if things are correct locally.

## IDE

IDEA is the best choice, but due to some jars are not public available, it is not working properly.

- mark `tests` directory as test source root, it is not using standard naming

### Oracle

- there is ongoing PR https://github.com/oltpbenchmark/oltpbench/pull/187
- Base on `pom.xml` it seems old version of jar is used
  - 10.2.0.1.0
  - http://www.oracle.com/technetwork/database/enterprise-edition/jdbc-10201-088211.html
- and you need Oracle account to download it
- `mvn install:install-file -DgroupId=com.oracle -DartifactId=ojdbc14 -Dversion=10.2.0.1.0 -Dpackaging=jar -Dfile=lib/ojdbc14-10.2.jar -DgeneratePom=true`
  - `mvn install:install-file -DgroupId=com.oracle -DartifactId=ojdbc14 -Dversion=10.2.0.1.0 -Dpackaging=jar -Dfile=ojdbc14.jar -DgeneratePom=true`

````bash
[INFO] Installing /home/at15/workspace/src/github.com/benchhub/oltpbench/doc/ojdbc14.jar to /home/at15/.m2/repository/com/oracle/ojdbc14/10.2.0.1.0/ojdbc14-10.2.0.1.0.jar
[INFO] Installing /tmp/mvninstall7312583839796949925.pom to /home/at15/.m2/repository/com/oracle/ojdbc14/10.2.0.1.0/ojdbc14-10.2.0.1.0.pom
````