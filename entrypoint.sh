#!/usr/bin/env bash
if [ ! -f  "/etc/nginx/ssl/key.pem" ]; then
  echo "Generating temporary certs"
  openssl req -x509 -newkey rsa:4096 -keyout /etc/nginx/ssl/key.pem -out /etc/nginx/ssl/certificate.pem -sha256 -days 3650 -nodes -subj "/C=XX/ST=StateName/L=CityName/O=CompanyName/OU=CompanySectionName/CN=CommonNameOrHostname"
fi
if [ ! -f  "/etc/nginx/ssl/dhparam.pem" ]; then
  openssl dhparam -out /etc/nginx/ssl/dhparam.pem 2048
fi

if [ -z "$HT_PASSWD_CONTENTS" ]; then
  echo "==========================================================================="
  echo "Found contents of nginx password file, creating / appending to htpasswd"
  echo "Appending $HT_PASSWD_CONTENTS"
  echo $HT_PASSWD_CONTENTS >>  /etc/nginx/htpasswd
  echo "==========================================================================="
fi

if [ ! -f  "/etc/nginx/htpasswd" ]; then
  echo "==========================================================================="
  echo "No passwd file found - generating random user and password"
  HT_USER=`pwgen -A 5 1`
  HT_PASS=`pwgen -B 20 1`
  htpasswd -cbB /etc/nginx/htpasswd $HT_USER $HT_PASS
  echo "Login with $HT_USER / $HT_PASS"
  echo "==========================================================================="
fi
/etc/init.d/nginx start
echo "$@"
/flink_docker_entrypoint.sh "$@"
