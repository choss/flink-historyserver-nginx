FROM flink:latest

# Install nginx
RUN apt-get update -y && apt-get install nginx pwgen apache2-utils -y && apt-get clean

# copy nginx config files (default.conf .htpasswd, certs)
COPY nginx/conf/ /etc/nginx/
COPY *.sh /

# changing owner for nginx files
RUN touch /run/nginx.pid \
    && chown -R flink:flink /etc/nginx/ /var/log/nginx /var/lib/nginx /run/nginx.pid \
    && rm /etc/nginx/sites-enabled/default

# run nginx and flink history server
ENTRYPOINT ["/entrypoint.sh"] 
CMD ["help"]
EXPOSE 8200