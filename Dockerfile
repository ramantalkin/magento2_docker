FROM ubuntu

MAINTAINER Nitin Agnihotri <nitin124@webkul.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install lamp-server^

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server-5.6

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php5-intl php5-xsl

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install wget supervisor git

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install unzip pwgen

RUN DEBIAN_FRONTEND=noninteractive sudo apt-get -y install mcrypt php5-mcrypt curl php5-curl php5-gd

RUN DEBIAN_FRONTEND=noninteractive php5enmod mcrypt
RUN cd /var/www/html/ && wget https://github.com/magento/magento2/archive/develop.zip
RUN cd /var/www/html/ && unzip develop.zip
RUN mv /var/www/html/magento2-develop /var/www/html/magento2
RUN wget -O /usr/local/bin/composer http://getcomposer.org/composer.phar
RUN chmod +x /usr/local/bin/composer
RUN a2enmod rewrite
ADD adminer.php /var/www/html/magento2/
ADD my.cnf /etc/mysql/conf.d/my.cnf
ADD start-apache2.sh /start-apache2.sh
ADD start-mysqld.sh /start-mysqld.sh
ADD supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
ADD supervisord-mysqld.conf /etc/supervisor/conf.d/supervisord-mysqld.conf
ADD create_mysql_admin_user.sh /create_mysql_admin_user.sh
ADD apache2.conf /etc/apache2/apache2.conf
RUN cd /var/www/html/magento2 && export COMPOSER_PROCESS_TIMEOUT=900 && composer install -vvv --no-dev --prefer-dist  
RUN chmod 755 /*.sh
RUN rm -rf /var/lib/mysql/*

EXPOSE 80

EXPOSE 3306


RUN cd /var/www/html && chown -R www-data:www-data magento2 

ADD startupscript.sh /var/www/startupscript.sh

RUN chmod 755 /var/www/*.sh

CMD ["/var/www/startupscript.sh"]
