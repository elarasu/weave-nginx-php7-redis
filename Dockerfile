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


# Add Supervisord config files
ADD conf/redis.sv.conf /etc/supervisor/conf.d/redis.conf

CMD supervisord

