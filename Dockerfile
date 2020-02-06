FROM nextcloud:17.0.3-apache

RUN export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get --no-install-recommends install -y \
    supervisor \
    sudo \
    postfix && \    
    rm -rf /var/lib/apt/lists/*

RUN mkdir /var/log/supervisord /var/run/supervisord
   
COPY main.cf /etc/postfix/main.cf

COPY supervisord.conf /etc/supervisor/supervisord.conf

ENV NEXTCLOUD_UPDATE=1

CMD ["/usr/bin/supervisord"]
