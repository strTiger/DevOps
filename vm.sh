#!/bin/bash

apt install lighttpd -y

apt install php7.4 -y
apt install php7.4-cgi php7.4-cli php7.4-fpm php7.4-pgsql -y

systemctl disable apache2.service
systemctl disable apache-htcacheclean.service

sed -i -e 's|;extension=pdo_pgsql|extension=pdo_pgsql|' /etc/php/7.4/cgi/php.ini
sed -i -e 's|;extension=pgsql|extension=pgsql|' /etc/php/7.4/cgi/php.ini

sed -i '$d' /etc/lighttpd/lighttpd.conf
sed -i -e '$a	"mod_fastcgi",' /etc/lighttpd/lighttpd.conf
sed -i -e '$a)' /etc/lighttpd/lighttpd.conf

lighttpd-enable-mod fastcgi fastcgi-php
service lighttpd force-reload
