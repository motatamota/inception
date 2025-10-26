FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install -y php-fpm php-mysql curl wget tar && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html
RUN curl -O https://ja.wordpress.org/latest-ja.tar.gz && \
    tar -xzf latest-ja.tar.gz --strip-components=1 && \
    rm latest-ja.tar.gz

COPY ./tools/setup_wp.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup_wp.sh

COPY ./wordpress/conf/wp-config.php /var/www/html/wp-config.php
COPY ./wordpress/conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir -p /run/php && chown -R www-data:www-data /var/www/html

EXPOSE 9000
VOLUME ["/var/www/html"]

ENTRYPOINT ["/usr/local/bin/setup_wp.sh"]
CMD ["php-fpm7.4", "-F"]
