FROM ubuntu
RUN apt-get update && apt-get install -y php5 php5-xdebug php5-mysql php5-gd
RUN apt-get install -yq mysql-server


RUN a2enmod rewrite
ADD startup.sh /opt/startup.sh
RUN mysqld_safe & \
	sleep 10s &&\
	mysql -e "CREATE DATABASE yourdb;"


RUN         echo "xdebug.remote_enable=on" >> /etc/php5/apache2/conf.d/xdebug.ini
RUN         echo "xdebug.remote_connect_back=on" >> /etc/php5/apache2/conf.d/xdebug.ini
RUN 		echo "xdebug.max_nesting_level=256"
EXPOSE 80
RUN chown -R www-data:www-data /var/www/html
RUN usermod -u 1000 www-data
CMD ["/bin/bash", "/opt/startup.sh"]
