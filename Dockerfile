# Usa la imagen oficial de PHP 8.3 con Apache [cite: 156]
FROM php:8.3-apache

# Instala paquetes y extensiones necesarias [cite: 157-159]
RUN apt-get update && \
    apt-get install -y --no-install-recommends unzip git curl libzip-dev libjpeg-dev libpng-dev libfreetype6-dev libicu-dev libxml2-dev libpng-dev libpq-dev libxml2-dev zlib1g-dev libicu-dev g++

# Configura e instala extensiones de PHP requeridas por Moodle [cite: 160-163]
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install mysqli zip gd intl soap exif opcache && \
    docker-php-ext-enable mysqli zip gd intl soap exif opcache

# Limpieza para reducir el tamaño de la imagen [cite: 164-165]
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Clona el repositorio de Moodle (Versión 4.5 estable) [cite: 166, 174-177]
RUN git clone git://git.moodle.org/moodle.git /var/www/html/moodle && \
    cd /var/www/html/moodle && \
    git checkout MOODLE_405_STABLE && \
    cp -rf ./* /var/www/html/ && \
    rm -rf /var/www/html/moodle

# Configuraciones de PHP para Moodle [cite: 179-181]
RUN echo "max_input_vars=5000" >> /usr/local/etc/php/conf.d/docker-php-moodle.ini && \
    echo "opcache.enable=1" >> /usr/local/etc/php/conf.d/docker-php-moodle.ini

# Crea el directorio para los datos de Moodle [cite: 182-183]
RUN mkdir -p /var/www/moodledata

# Define el directorio de trabajo y permisos [cite: 184-188]
WORKDIR /var/www/html
RUN chown -R www-data:www-data /var/www/ && \
    chmod -R 755 /var/www

# Expone el puerto 80 [cite: 189-190]
EXPOSE 80
