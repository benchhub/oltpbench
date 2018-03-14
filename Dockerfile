FROM openjdk:8-jre

COPY lib /opt/oltpbench/lib
COPY build /opt/oltpbench/build
COPY config /opt/oltpbench/config
COPY classpath.sh /opt/oltpbench/classpath.sh
COPY oltpbenchmark /opt/oltpbench/oltpbenchmark
COPY log4j.properties /opt/oltpbench/log4j.properties

ENTRYPOINT [ "/opt/oltpbench/oltpbenchmark" ]
CMD [ "-h" ]

# export BENCH=tpcc
# export DB=mysql
# ./travis_start
# config/config.py generate --bench=${BENCH} --db=${DB}
# TODO: might bind result as well
# docker run --network host --mount type=bind,source=$(pwd)/config,target=/opt/oltpbench/config a7da -bench tpcc --config config/generated_tpcc_mysql_config.xml --create true --load true --execute true
