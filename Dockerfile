FROM mysql
COPY DoAnSQL.sql  /docker-entrypoint-initdb.d
EXPOSE 3306