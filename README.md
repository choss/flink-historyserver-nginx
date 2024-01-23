# Just an image with an nginx in front of flink

This image expects the following files:

- htpasswd file in /etc/nginx/htpasswd
- SSL keyfile in /etc/nginx/ssl/key.pem
- SSL certificate in /etc/nginx/ssl/certificate.pem
- DH parameters in /etc/nginx/ssl/dhparam.pem

If they do not exist, they will be created on container start. The username and password for the htpasswd file will be random and printed to stdout on container start. The entrypoint.sh contains all the code to generate the files.

# How to build and run

## Building the docker image
   ```sh
   docker build -t 'flink_and_nginx' .
   ```
## Running the docker container
   ```sh
   docker run -e "ENABLE_BUILT_IN_PLUGINS=flink-gs-fs-hadoop-1.18.0.jar" \
                -e "GOOGLE_APPLICATION_CREDENTIALS=/my_sa.json" \
				-e "FLINK_PROPERTIES=historyserver.archive.fs.dir: /path/to/my/dir"
                -p 8200:8200 flink_and_nginx
   ```
   ```sh 
    docker run -e "ENABLE_BUILT_IN_PLUGINS=flink-gs-fs-hadoop-1.18.0.jar" \
	            -e HT_PASSWD_CONTENTS="test:$2y$05$chYavpf5/zhTtt1wBESRk.Xcbs/Dv.ZJxnfpkVDonbRY9C6WMmWQq" \
                -e "GOOGLE_APPLICATION_CREDENTIALS=/my_sa.json" \
				-e "FLINK_PROPERTIES=historyserver.archive.fs.dir: /path/to/my/dir"
                -p 8200:8200 flink_and_nginx
   ```

   ```sh 
    docker run -e "ENABLE_BUILT_IN_PLUGINS=flink-gs-fs-hadoop-1.18.0.jar" \
	            -e -v htpasswd:/etc/nginx/htpasswd \
                -e "GOOGLE_APPLICATION_CREDENTIALS=/my_sa.json" \
				-e "FLINK_PROPERTIES=historyserver.archive.fs.dir: /path/to/my/dir"
                -p 8200:8200 flink_and_nginx
   ```
   
   test:$2y$05$chYavpf5/zhTtt1wBESRk.Xcbs/Dv.ZJxnfpkVDonbRY9C6WMmWQq
