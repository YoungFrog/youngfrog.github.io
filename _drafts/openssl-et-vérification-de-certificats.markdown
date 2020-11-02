---
layout: post
title: "OpenSSL et vérification de certificats"
categories: informatique
# featured-image: 
# featured-source: 
summary: "Pour déboguer certains problèmes de connexion en HTTPS, je m'intéresse à l'inspection de certificats SSL avec `openssl`"
---
# Le concept de base
Avec HTTPS, on utilise des certificats pour identifier un site Web grâce à l'idée d'une chaîne de confiance.

Ces certificats sont des documents publics, et chacune peut en vérifier la validité si elle a le certificat sur son ordinateur.

# La chaîne de confiance

Cette chaîne de confiance est construite comme suit : 

Pour visiter https://mon-site.example/

1. Le site en question fournit son propre certificat, signé par
2. un premier intermédiaire de confiance, qui a un certificat signé par
3. ...
4. un dernier intermédiaire de confiance, qui a un certificat signé par
5. une [autorité de certification](https://fr.wikipedia.org/wiki/Autorit%C3%A9_de_certification) (CA), en laquelle on fait aveuglément confiance.

Pour effectivement vérifier cette chaîne de confiance, il suffit d'avoir, pour chaque intervenant (CA, intermédiaires, site web) un *certificat* (en cours de validité).

# Les certificats

Un certificat contient des informations telles que :

- L'organisation à qui appartient le certificat
