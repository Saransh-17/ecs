#!/bin/bash
if [ ! -e /var/www/html/bagisto/public/index.php ]; then
    echo "Files not found!"
    echo "Copying now..."
    unzip -q bagisto.zip -d /var/www/html
    sleep 5
    echo "giving permisiions"
    cp /var/www/html/bagisto/.env.example /var/www/html/bagisto/.env
    php /var/www/html/bagisto/artisan key:generate
    chown -R www-data:www-data /var/www/html/
    echo "Files copied..."
	
else
    echo "file were present"	
	
fi

sleep 10
apache2-foreground
