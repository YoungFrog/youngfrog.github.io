---
layout: post
title: "PHP8 without PHP8, thanks to Docker "
categories: informatique
# featured-image: 
# featured-source: 
summary: ""
---
Sur ma machine j'ai une application en PHP7, ce qui fait que je ne veux pas màj PHP globalement, 
et là je voudrais lancer une application qui a besoin de PHP8 (c'est un Laravel récent).

Docker à la rescousse !

    docker run --rm --interactive --tty --volume $PWD:/app --user $(id -u):$(id -g) composer install
    
va récupérer l'image [composer:latest](https://hub.docker.com/_/composer/) et installer tout ce qu'il faut ! Ensuite pour lancer

    docker run --network=host -it --rm -v "$PWD:/app" -w /app php:latest php artisan serve
    
va lancer le script artisan. Si besoin de mysql, il faut utiliser une image

J'ai utilisé un Dockerfile

    FROM php:latest
    RUN docker-php-ext-install -j$(nproc) pdo_mysql

et après `docker build`, j'ai pu lancer cette image-là (l'identifiant est donné après le build) à la place de `php:latest`



## varia

Si on n'utilise pas le `--network=host`, il faut alors forwarder un port et dire à artisan d'accepter les connexions depuis l'extérieur, par exemple

    docker run -p 8000:8000 -it --rm -v "$PWD:/app" -w /app php:latest php artisan serve --host=0.0.0.0

J'ai aussi envisagé ceci pour donner accès au socket mysql directement :

    docker run -v /var/run/mysqld:/var/run/mysqld (...)

mais ça ne marche pas tel quel (il faut sans doute configurer Laravel pour utiliser le socket). Source: <https://saravanaj.github.io/2020/01/09/sharing-a-mysql-database-across-docker-containers/>
