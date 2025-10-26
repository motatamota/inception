FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

ARG DOMAIN_NAME=tashiget.42.fr
ENV DOMAIN_NAME=${DOMAIN_NAME}

RUN apt-get update -y && \
    apt-get install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

# SSL証明書と秘密鍵を生成（開発用）
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 \
      -newkey rsa:2048 \
      -keyout /etc/nginx/ssl/server.key \
      -out /etc/nginx/ssl/server.crt \
      -subj "/C=JP/ST=Tokyo/L=Tokyo/O=42Tokyo/OU=student/CN=${DOMAIN_NAME}"

COPY ./nginx/conf/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/conf/default.conf /etc/nginx/conf.d/default.conf

RUN mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
