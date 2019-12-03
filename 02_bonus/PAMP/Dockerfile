FROM debian

# APT UPDATE
RUN apt-get update && apt-get upgrade -y

# APACHE
RUN apt-get install -y apache2

# MARIA_DB
RUN apt-get install -y mariadb-server

# PHP
RUN apt-get install -y php libapache2-mod-php php-mysql

ENTRYPOINT bash