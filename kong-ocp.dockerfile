
FROM docker.io/ubuntu:20.04
#FROM ubi8/ubi-minimal:8.8-1014

ENV KONG_INSTALLER=https://download.konghq.com/gateway-3.x-ubuntu-focal/pool/all/k/kong-enterprise-edition/kong-enterprise-edition_3.3.0.0_amd64.deb
ENV KONG_ENTRYPOINT=https://raw.githubusercontent.com/Kong/docker-kong/master/docker-entrypoint.sh

# COPY kong.deb /tmp/kong.deb
   
# RUN set -ex; \
#     apt update \
#     && apt install wget \
#     && wget -O /tmp/kong.deb $KONG_INSTALLER \
#     && apt-get install --yes /tmp/kong.deb \
#     && rm -rf /var/lib/apt/lists/* \
#     && rm -rf /tmp/kong.deb \
#     && adduser -u 1001 kong \
#     && usermod -aG 0 kong && \
#     && chown kong:0 /usr/local/bin/kong \
#     && chown -R kong:0 /usr/local/kong \
#     && ln -s /usr/local/openresty/bin/resty /usr/local/bin/resty \
#     && ln -s /usr/local/openresty/luajit/bin/luajit /usr/local/bin/luajit \
#     && ln -s /usr/local/openresty/luajit/bin/luajit /usr/local/bin/lua \
#     && ln -s /usr/local/openresty/nginx/sbin/nginx /usr/local/bin/nginx \
#     && wget -O /docker-entrypoint.sh $KONG_ENTRYPOINT \
#     && chmod +x /docker-entrypoint.sh \
#     && kong version


RUN set -ex; 
RUN apt update 
RUN apt install --yes wget
RUN wget -O /tmp/kong.deb $KONG_INSTALLER 
RUN apt-get install --yes /tmp/kong.deb 
RUN rm -rf /var/lib/apt/lists/* 
RUN rm -rf /tmp/kong.deb 
RUN adduser -u 1001 kong 
RUN usermod -aG 0 kong && 
RUN chown kong:0 /usr/local/bin/kong 
RUN chown -R kong:0 /usr/local/kong 
RUN ln -s /usr/local/openresty/bin/resty /usr/local/bin/resty 
RUN ln -s /usr/local/openresty/luajit/bin/luajit /usr/local/bin/luajit 
RUN ln -s /usr/local/openresty/luajit/bin/luajit /usr/local/bin/lua 
RUN ln -s /usr/local/openresty/nginx/sbin/nginx /usr/local/bin/nginx 
RUN wget -O /docker-entrypoint.sh $KONG_ENTRYPOINT 
RUN chmod +x /docker-entrypoint.sh 
RUN kong version
   


#COPY docker-entrypoint.sh /docker-entrypoint.sh
   
USER 1001
   
ENTRYPOINT ["/docker-entrypoint.sh"]
   
EXPOSE 8000 8443 8001 8444 8002 8445 8003 8446 8004 8447
   
STOPSIGNAL SIGQUIT
   
HEALTHCHECK --interval=10s --timeout=10s --retries=10 CMD kong health
   
CMD ["kong", "docker-start"]
