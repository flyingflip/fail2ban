FROM ubuntu:22.04

# Set our our meta data for this container.
LABEL name="Example Of Using Fail2Ban Within A Container"
LABEL author="Michael R. Bagnall <mbagnall@flyingflip.com>"

WORKDIR /root

ENV TERM=xterm

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN apt-get update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  build-essential \
  software-properties-common \
  sudo \
  vim \
  wget \
  zip \
  fail2ban \
  inetutils-syslogd \
  iptables \
  curl \
  net-tools \
  gettext \
  unzip \
  zlib1g \
  libssl3 \
  apache2 \
  apache2-utils

  # Add ondrej/php PPA repository for PHP.
RUN add-apt-repository ppa:ondrej/php \
  && apt-get update -y \
  && apt-get upgrade -y \
  && apt-get install dialog

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
  php8.3 \
  php8.3-bcmath \
  php8.3-bz2 \
  php8.3-cli \
  php8.3-common \
  php8.3-curl \
  php8.3-dba \
  php8.3-gd \
  php8.3-mbstring \
  php8.3-mysql \
  php8.3-opcache \
  php8.3-apcu \
  php8.3-readline \
  php8.3-soap \
  php8.3-zip \
  php8.3-dev \
  php8.3-xml \
  php8.3-intl \
  libapache2-mod-php8.3

# This fail2ban configuration took forever to get right because of the constantly
# changing versions of fail2ban and apache
#
# https://talk.plesk.com/threads/block-repeated-403-forbidden-requests-with-fail2ban-as-included-plesk-jail-feature-request.358827/
COPY etc/fail2ban/filter.d/httpd-forbidden.conf /etc/fail2ban/filter.d/httpd-forbidden.conf
COPY etc/fail2ban/jail.d/httpd-forbidden.conf /etc/fail2ban/jail.d/httpd-forbidden.conf

# Configure Apache. Be sure to enable apache mods or you're going to have a bad time.
RUN a2enmod rewrite \
  && a2enmod actions \
  && a2enmod alias \
  && a2enmod deflate \
  && a2enmod dir \
  && a2enmod expires \
  && a2enmod headers \
  && a2enmod mime \
  && a2enmod negotiation \
  && a2enmod setenvif \
  && a2enmod proxy \
  && a2enmod proxy_http \
  && a2enmod speling \
  && a2enmod cgid \
  && a2enmod remoteip \
  && a2enmod ssl

# Our startup script used to install Drupal (if configured) and start Apache.
ADD etc/run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

CMD [ "/run-httpd.sh" ]
