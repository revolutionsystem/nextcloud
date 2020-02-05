FROM nextcloud:17.0.3-apache

RUN export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get --no-install-recommends install -y \
    supervisor \
    sudo \
    postfix && \    
    rm -rf /var/lib/apt/lists/*

COPY package/tzdata_2019c-3_all.deb /tmp/

RUN dpkg -i /tmp/tzdata_2019c-3_all.deb && \
    cp  -f /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    rm -f /tmp/tzdata_2019c-3_all.deb && \
    mkdir /var/log/supervisord /var/run/supervisord
   
COPY main.cf /etc/postfix/main.cf

COPY supervisord.conf /etc/supervisor/supervisord.conf

ENV NEXTCLOUD_UPDATE=1

CMD ["/usr/bin/supervisord"]
