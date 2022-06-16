---
layout: post
title: "Publier un site Laravel sur alwaysdata"
categories: informatique
# featured-image: 
# featured-source: 
summary: ""
---

chez alwaysdata (https://alwaysdata.com/) on peut héberger 100Mo gratuitement.

Alors j'ai tenté de push une application Laravel simple, et c'est pas trop compliqué.

Pour le déploiement j'ai copié mon code source dans un répertoire et rsync vers le serveur

```
mkdir ~/pizza-deploy; git archive HEAD -- . | tar -x -C ~/pizza-deploy
rsync -a ~/pizza-deploy youngfrog@ssh-youngfrog.alwaysdata.net:pizza
```
(on peut sûrement faire ça sans répertoire pizza-deploy intermédiaire, mais je ne sais pas comment) puis via ssh j'ai créé/modifié mon `.env` (une clef, mettre APP_DEBUG à false, configurer mysql avec les infos alwaysdata), et enfin lancé les étapes du déploiement
```
composer install --optimize-autoloader --no-dev
php artisan config:cache
php artisan route:cache
php artisan view:cache
```
(voir <https://laravel.com/docs/9.x/deployment#server-requirements>)

Pour la config sur alwaysdata j'ai simplement dû changer "Root directory*" (par défaut `/www/`, j'ai mis `/pizza/public/`)

