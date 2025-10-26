FROM debian:11.11

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install -y mariadb-server && \
	# キャッシュ削除
    rm -rf /var/lib/apt/lists/*

COPY ./mariadb/conf/my.cnf /etc/mysql/my.cnf
COPY ./tools/setup_mariadb.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/setup_mariadb.sh

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/setup_mariadb.sh"]

CMD ["mysqld_safe"]
