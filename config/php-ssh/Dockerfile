FROM php:7.0-cli
MAINTAINER Arkan M. Gerges <arkan.m.gerges@gmail.com>

RUN apt-get update \
	&& apt-get install -y wget \
		openssh-server \
		libcurl4-gnutls-dev \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
		libmcrypt-dev \
		libpng12-dev \
		libxml2-dev \
		libicu-dev \
		build-essential \
		libtool \
		autoconf \
		automake \
		uuid-dev \
		git \
		pkg-config \
		php5-dev \
		libsodium-dev \
        supervisor \
	&& pecl install xdebug \
    && docker-php-ext-enable xdebug
		
RUN mkdir /var/run/sshd \
	&& echo 'root:1234' | chpasswd \
	&& sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Install php extensions
RUN docker-php-ext-install gettext intl mcrypt mysqli pcntl pdo_mysql

# Install libsodium
RUN mkdir -p /tmpbuild/libsodium \
    && cd /tmpbuild/libsodium \
    && curl -kLo libsodium-1.0.11.tar.gz https://download.libsodium.org/libsodium/releases/libsodium-1.0.11.tar.gz \
    && tar xvzf libsodium-1.0.11.tar.gz \
    && cd /tmpbuild/libsodium/libsodium-1.0.11/ \
    && ./configure \
    && make && make check \
    && make install \
    && mv src/libsodium /usr/local/ \
    && rm -Rf /tmpbuild/

# Install zmq
RUN mkdir -p /tmpbuild/zeromq \
    && cd /tmpbuild/zeromq \
    && curl -kLsSo zeromq.tar.gz http://download.zeromq.org/zeromq-4.1.4.tar.gz \
    && tar -xvzf zeromq.tar.gz \
    && cd zeromq-4.1.4/ \
    && ./configure \
    && make \
    && make install \
    && rm -Rf /tmpbuild/ \
    && yes '' | pecl install zmq-beta \
    && echo "extension=zmq.so" >> $PHP_INI_DIR/conf.d/zmq.ini

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]