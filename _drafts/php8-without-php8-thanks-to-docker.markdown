---
layout: post
title: "PHP8 without PHP8, thanks to Docker "
categories: informatique
# featured-image: 
# featured-source: 
summary: ""
---
Sur ma machine j'ai une application en PHP7 qui fait que je ne veux pas màj PHP globalement, 
et une autre qui a besoin de PHP8 pour lancer composer/laravel.

Docker à la rescousse !

    docker run --rm --interactive --tty --volume $PWD:/app --user $(id -u):$(id -g) composer install
    
va récupérer l'image [composer:latest](https://hub.docker.com/_/composer/); 


### FIXME not 100% tested, must check connection with DB


ensuite

    docker run --network=host -it --rm -v "$PWD:/app" -w /app php:latest php artisan serve --host=0.0.0.0
    
va lancer le script artisan.

je passe sous silence deux choses 

 -p 8001:8000
 -v /var/run/mysqld:/var/run/mysqld
