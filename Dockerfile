FROM ubuntu
RUN apt-get update && apt-get install -y php5 php5-xdebug php5-mysql php5-gd
RUN apt-get install -yq mysql-server


RUN a2enmod rewrite
ADD startup.sh /opt/startup.sh
RUN mysqld_safe & \
	sleep 10s &&\
	mysql -e "CREATE DATABASE yourdb;"

EXPOSE 80
CMD ["/bin/bash", "/opt/startup.sh"]