---
layout: post
title: "Où héberger un site web"
categories: informatique
# featured-image: 
# featured-source: 
summary: ""
---

Quels critères à prendre en compte pour héberger son site ?

J'ai en tête :
- Le prix (la gratuité est agréable, surtout pour de petits sites sans prétention)
- technologies côté serveur (PHP) et bases de données (MariaDB, etc.)
- L'accès SSH

## Quelques idées.

### Hébergement classique (accès ftp ou ssh)

- OVH propose [des hébergements web](https://www.ovh.com/fr/hebergement-web/hebergement-perso.xml) à partir de 3.59€/mois TTC avec PHP etc,
- ou même leur version light [kimsufi](https://www.kimsufi.com/fr/hosting.xml) dès 1.79€/mois TTC avec PHP et 1 BDD (100 Mo)

(attention qu'OVH met en avant un nom de domaine gratuit, mais il me semble que c'est juste pour un an.)

- <https://manual.uberspace.de/> <https://uberspace.de/en/product/#prices> -- avec accès ssh. Prix libre : ils suggèrent 5€, 10€ ou 15€/mois

- <https://www.freehosting.com/> : gratuit, avec la stack LAMP, mais qualité probablement très bof

- <https://siteplan.be/webhosting/> : à 39.95€/an (3.33€ par mois), y compris un nom de domaine, c'est vraiment pas cher il me semble.

- <https://alwaysdata.com/> : pour 100Mo, gratuit comprenant PHP (ou d'autres, comme Node) et une DB MySQL.

### Hébergement façon PaaS [^1]

Gitlab Pages sur gitlab.com : site statique gratuit

Github Pages : site statique gratuit

Netlify : site statique gratuit avec le plan de base, mais avec des incitants (j'ai oublié lesquels) pour prendre des plans plus avancés

Heroku : plan gratuit : site dynamique, y compris base de donnée Postgres, voir par exemple le [Getting started with PHP](https://devcenter.heroku.com/articles/getting-started-with-php), ou plus spécifiquement [avec Laravel](https://devcenter.heroku.com/articles/getting-started-with-laravel), à quoi il faut ajouter les [articles sur Postgres](https://devcenter.heroku.com/articles/heroku-postgresql), et notamment le [lien entre Postgres et Laravel](https://devcenter.heroku.com/articles/heroku-postgresql#connecting-with-laravel).

Render : similaire à Heroku, également avec des hébergements partiellement gratuits <https://render.com/pricing>


[Firebase Hosting](https://firebase.google.com/docs/hosting?hl=en) semble offrir un service similaire chez Google. Je n'ai pas tenté. Je pense que Firebase hosting est (un peu) différent de "Firebase" tout seul et je me suis paumé dans la doc.

[^1]: [PaaS versus IaaS versus SaaS](https://www.redhat.com/fr/topics/cloud-computing/iaas-vs-paas-vs-saas)

### Machines dans le cloud/ IaaS

Avec un vps, un dédié ou quelque chose comme ça : on peut viser des prix raisonnables, et héberger autant de sites qu'on veut

Chez ovh on a des VPS [type "Starter" à 3.63€/mois](https://www.ovh.com/fr/order/vps/?v=3#/vps/build?selection=~(range~'Starter~flavor~'vps-starter-1-2-20~datacenters~(SBG~1)~pricingMode~'default)) (annoncé à 3€/mois HTVA).

Chez Google Cloud, on propose des solutions [à 9$/mois](https://cloud.google.com/solutions/web-hosting) avec [une stack LAMP](https://console.cloud.google.com/marketplace/product/click-to-deploy-images/lamp)

Aws offre ce genre de chose aussi certainement.



### Site builders & co

https://www.wix.com/free/web-hosting c'est pas du vrai hosting (par exemple pas d'accès ftp -- juste il faut créer le site avec leur interface) et ça pue les pubs
