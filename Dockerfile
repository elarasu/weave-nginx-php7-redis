# nginx-php image 
#   docker build -t elarasu/weave-nginx-php7-redis .
#
FROM elarasu/weave-nginx-php7
MAINTAINER elarasu@outlook.com

# Install requirements
RUN  apt-get update  \
  && apt-get install -yq redis-server --no-install-recommends \
  && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*

# Install redis-php components
WORKDIR /tmp
RUN git clone -b php7 --single-branch https://github.com/phpredis/phpredis.git
WORKDIR /tmp/phpredis
RUN phpize && ./configure && make && make install

ADD conf/redis.ini /etc/php/mods-available/redis.ini
RUN ln -s /etc/php/mods-available/redis.ini /etc/php/7.0/fpm/conf.d/20-redis.ini
RUN ln -s /etc/php/mods-available/redis.ini /etc/php/7.0/cli/conf.d/20-redis.ini

# Add Supervisord config files
ADD conf/redis.sv.conf /etc/supervisor/conf.d/redis.conf

CMD supervisord

