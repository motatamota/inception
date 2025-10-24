FROM debian:11.11

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install -y php-fpm php-mysql curl wget tar && \
	# キャッシュ削除
    rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html
RUN curl -O https://ja.wordpress.org/latest-ja.tar.gz && \
    tar -xzf latest-ja.tar.gz --strip-components=1 && \
    rm latest-ja.tar.gz

COPY ./mariadb/conf/my.cnf /etc/mysql/my.cnf
COPY ./tools/setup.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/setup.sh

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/setup.sh"]

CMD ["mysqld_safe"]
