FROM openjdk:8-jre

COPY lib /opt/oltpbench/lib
COPY build /opt/oltpbench/build
COPY config /opt/oltpbench/config
COPY classpath.sh /opt/oltpbench/classpath.sh
COPY oltpbenchmark /opt/oltpbench/oltpbenchmark
COPY log4j.properties /opt/oltpbench/log4j.properties

ENTRYPOINT [ "/opt/oltpbench/oltpbenchmark" ]
CMD [ "-h" ]