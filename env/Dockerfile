FROM php:apache
RUN apt-get update && apt-get install -y git unzip \
    && rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-install mysqli pdo pdo_mysql \
    && a2enmod rewrite
RUN apt-get update; apt-get install -y libonig-dev; docker-php-ext-install mbstring; rm -fr /var/lib/apt/lists/*

