FROM ubuntu
RUN apt-get update && apt-get install -y php5 php5-xdebug php5-mysql php5-gd
RUN apt-get install -yq mysql-server


RUN a2enmod rewrite
ADD startup.sh /opt/startup.sh
ADD templates/000-default.conf /etc/apache2/sites-available/000-default.conf
RUN mysqld_safe & \
	sleep 10s &&\
	mysql -e "CREATE DATABASE yourdb;"


RUN         echo "xdebug.remote_enable=on" >> /etc/php5/apache2/conf.d/xdebug.ini
RUN         echo "xdebug.remote_connect_back=on" >> /etc/php5/apache2/conf.d/xdebug.ini
RUN 		echo "xdebug.max_nesting_level=256" >> /etc/php5/apache2/conf.d/xdebug.ini
EXPOSE 80
RUN chown -R www-data:www-data /var/www/html
RUN usermod -u 1000 www-data

RUN apt-get install -y curl
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

RUN composer global require drush/drush:7.*
RUN echo 'export PATH="$HOME/.composer/vendor/bin:$PATH"' >> /root/.bashrc
CMD ["/bin/bash", "/opt/startup.sh"]
VOLUME ["/var/www/html"]