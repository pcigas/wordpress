FROM wordpress:latest

RUN apt-get update \
    && apt-get install -y libpq-dev wget unzip \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pdo pdo_pgsql pgsql


RUN wget https://downloads.wordpress.org/plugin/wppg.1.0.1.zip \
&& unzip wppg.1.0.1.zip \
&& rm wppg.1.0.1.zip \
&& mv wppg /usr/src/wordpress/wp-content/plugins/ \
&& cp /usr/src/wordpress/wp-content/plugins/wppg/pg4wp/db.php /usr/src/wordpress/wp-content/ \
&& chown -R www-data:www-data /usr/src/wordpress/wp-content/ \
&& sed -i "s|define( 'PG4WP_ROOT.*|define( 'PG4WP_ROOT', ABSPATH.'wp-content/plugins/wppg/pg4wp');|g" /usr/src/wordpress/wp-content/db.php 
