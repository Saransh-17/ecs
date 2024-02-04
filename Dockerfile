FROM php:8.1-apache
#WORKDIR /var/www/html
RUN apt-get update \
&& apt install vim git -y \
&& php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
&& php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
&& php composer-setup.php \
&& php -r "unlink('composer-setup.php');" && mv composer.phar /usr/local/bin/composer \
&& apt-get install -y libicu-dev \
&& apt-get install -y libzip-dev \
&& apt install zip unzip -y \
&& apt-get install -y zlib1g-dev \
&& apt-get install -y libpng-dev \
&& docker-php-ext-install calendar && docker-php-ext-install intl && docker-php-ext-install pdo_mysql \
&& docker-php-ext-install gd && docker-php-ext-install exif && docker-php-ext-install zip 
WORKDIR /
COPY bagisto.zip .
RUN chown -R www-data:www-data /var/www/html \
&& chmod -R 755 /var/www/html \
&& a2enmod rewrite && service apache2 restart
#CMD ["df","-h"]
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
CMD ["/usr/local/bin/docker-entrypoint.sh"]
#CMD ["apache2-foreground"]
