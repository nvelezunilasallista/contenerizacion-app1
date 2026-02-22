FROM mysql:8.0

ENV MYSQL_ROOT_PASSWORD=poligran2024
ENV MYSQL_DATABASE=politecnico_db
ENV MYSQL_USER=poligran_user
ENV MYSQL_PASSWORD=poligran_pass

COPY init.sql /docker-entrypoint-initdb.d/init.sql

EXPOSE 3306
