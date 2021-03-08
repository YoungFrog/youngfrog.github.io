---
layout: post
title: "Installer Nextcloud aux côtés de Valet for Linux"
categories: informatique
# featured-image: 
# featured-source: 
summary: "J'utilise [Valet for Linux](https://github.com/cpriego/valet-linux), qui installe Nginx et php-fpm pour faire son taf. J'ai voulu installer `nextcloud` en local."
---
## HTTPS et php-fpm

Si on suit les instructions d'[installation de nextcloud avec nginx](https://docs.nextcloud.com/server/21/admin_manual/installation/nginx.html), on se retrouve à :
- activer HTTPS par défaut (via une redirection dans la première partie du fichier `nginx.conf`, et la ligne `fastcgi_param HTTPS on;` dans la section ssl du fichier de configuration)
- utiliser php-fpm via la ligne `server 127.0.0.1:9000;` alors que sur mon installation, un socket était utilisé par défaut

## Questions de propriété

Par ailleurs Valet configure nginx pour utiliser l'utilisateur courant (`youngfrog` pour ce qui me concerne). 

Or par défaut sur mon Ubuntu c'est `www-data` qui est propriétaire de `/var/www/`,
et `php-fpm` utilise également l'utilisateur `www-data` dans le pool par défaut (voir `/etc/php/*/fpm/pool.d/www.conf`).

J'ai tout modifié (à coup de `chown` dans `/var/www/nextcloud` et `/var/lib/nginx/fastcgi/` ainsi que `php7.4-fpm.sock`) pour utiliser mon utilisateur courant, comme dans valet.
J'ai réalisé plus tard que j'aurais peut être pu utiliser le même pool php-fpm que valet. (pool.d/valet.conf)

L'utilisateur "nginx" doit aussi avoir accès aux espaces de [stockages locaux](#external-storage) définis dans nextcloud .

## External storage

L'utilisateur "nginx" doit aussi avoir accès aux espaces de stockages locaux définis dans nextcloud 
(et, pour mémoire, il faut ajouter "External Storage" à la liste des applications, configurer globalement, puis chaque utilisateur peut l'ajouter à ses fichiers.)

## HTTPS

I followed this to make a self signed certificate :

https://medium.com/@antelle/how-to-generate-a-self-signed-ssl-certificate-for-an-ip-address-f0dd8dddf754

Named the files as `/etc/ssl/nginx/nc-{cert,key}.pem`. 
I notice that Firefox warns me about it being a self-signed certificate, but does not warn about the IP being the wrong one (e.g. if I use 127.0.0.1 instead of 192.168.2.30 [which is the IP I wrote in the certificate]) IOW it doesn't seem to work correctly.
