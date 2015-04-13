       FROM ubuntu
 MAINTAINER George Georgulas IV <georgegeorgulasiv@gmail.com>
        ENV DEBIAN_FRONTEND noninteractive
       USER root
        ENV HOME /root
        ADD boottime.sh /
        ADD import.sql /
        ADD 000-default.conf /
        ADD my.cnf /
    WORKDIR /usr/bin/rathena/		
        RUN apt-get update \
         && apt-get -yqq dist-upgrade \
         && apt-get -yqq --force-yes install apache2 \
                                             gcc \
                                             git \
                                             libapache2-mod-php5 \
                                             libmysqlclient-dev \
                                             libpcre3-dev \
                                             make \
                                             mysql-client \
                                             mysql-server \
                                             php5-mysql \
                                             php-apc \
                                             php5-mcrypt \
                                             rsync \
                                             zlib1g-dev \
         && echo "ServerName localhost" >> /etc/apache2/apache2.conf \
         && rm -rf /var/www/html \
         && git clone https://github.com/rathena/FluxCP.git /var/www/html \
         && git clone https://github.com/rathena/rathena.git /usr/bin/rathena \
         && ./configure --enable-packetver=20131223 \
         && make server \
         && service mysql start \
         && mysql < /import.sql \
         && service mysql stop \
         && rm -f /import.sql \
         && apt-get -yqq remove gcc git make \
         && apt-get -yqq autoremove \
         && chmod a+x /usr/bin/rathena/*-server \
         && chmod a+x /usr/bin/rathena/athena-start \
         && chmod a+x /boottime.sh \
         && chmod -R 777 /var/www/html/data \
         && chown -R 33:33 /var/www/html/data \
         && a2enmod rewrite \
         && mkdir /datastore/ \
         && mkdir /datastore/etc-apache2/ \
         && mkdir /datastore/etc-mysql/ \
         && mkdir /datastore/usr-bin-rathena/ \
         && mkdir /datastore/var-lib-mysql/ \
         && mkdir /datastore/var-www-html/ \
         && mv -f /000-default.conf /etc/apache2/sites-available/ \
         && mv -f /my.cnf /etc/mysql/conf.d/ \
         && rsync -az /etc/apache2/ /datastore/etc-apache2/ \
         && rsync -az /etc/mysql/ /datastore/etc-mysql/ \
         && rsync -az /usr/bin/rathena/ /datastore/usr-bin-rathena/ \
         && rsync -az /var/lib/mysql/ /datastore/var-lib-mysql/ \
         && rsync -az /var/www/html/ /datastore/var-www-html/
        ENV DEBIAN_FRONTEND interactive
     EXPOSE 80 443 3306 5121 6121 6900
        ENV PHP_UPLOAD_MAX_FILESIZE 10M
        ENV PHP_POST_MAX_SIZE 10M
        CMD bash
 ENTRYPOINT /boottime.sh

# docker run -it -p 20000:80 -p 20001:443 -p 20002:3306 -p 20003:5121 -p 20004:6121 -p 20005:6900 -v /datastore/etc-apache2:/etc/apache2 -v /datastore/etc-mysql:/etc/mysql -v /datastore/usr-bin-rathena:/usr/bin/rathena -v /datastore/var-lib-mysql:/var/lib/mysql -v /datastore/var-www-html:/var/www/html -e USER=root georgegeorgulasiv/tritogeneia