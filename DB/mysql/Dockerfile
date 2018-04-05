FROM mysql:5.7

ADD my.cnf /etc/mysql/conf.d/my.cnf

RUN chown -R mysql:root /var/lib/mysql/

ARG MYSQL_DATABASE=default_database
ARG MYSQL_USER=default_user
ARG MYSQL_PASSWORD=secret
ARG MYSQL_ROOT_PASSWORD=root

ENV MYSQL_DATABASE=foodapp
ENV MYSQL_USER=adam
ENV MYSQL_PASSWORD=ashcraft
ENV MYSQL_ROOT_PASSWORD=password

CMD ["mysqld"]
EXPOSE 3306