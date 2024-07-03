FROM anapsix/alpine-java:8

RUN apk update && apk upgrade && apk --update add curl && rm -rf /tmp/* /var/cache/apk/*

ENV VERSION 1.0.1
ENV JAR jmx_prometheus_httpserver-$VERSION.jar

RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64
RUN chmod +x /usr/local/bin/dumb-init

RUN mkdir -p /opt/jmx_exporter
RUN curl -L https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_httpserver/$VERSION/$JAR -o /opt/jmx_exporter/$JAR
COPY start.sh /opt/jmx_exporter/
COPY config.yml /opt/jmx_exporter/

CMD ["usr/local/bin/dumb-init", "/opt/jmx_exporter/start.sh"]