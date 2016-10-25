FROM elasticsearch:2.4
MAINTAINER Arkan M. Gerges <arkan.m.gerges@gmail.com>

# Install kibana
RUN wget "https://download.elastic.co/kibana/kibana/kibana-4.6.1-amd64.deb" -qO mktemp \
    && dpkg -i mktemp \
    && rm -Rf mktemp

RUN /opt/kibana/bin/kibana plugin --install elastic/sense

COPY ./es-and-kibana.sh /
RUN chmod a+x /es-and-kibana.sh

WORKDIR /usr/share/elasticsearch
EXPOSE 9200 9300 5601

ENTRYPOINT ["/es-and-kibana.sh"]