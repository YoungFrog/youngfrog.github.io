---
layout: post
title: "nginx + docker = ♥"
categories: informatique
# featured-image: 
# featured-source: 
summary: ""
---


# HOWTO 

Je suis les instructions ici :
<https://hub.docker.com/r/jwilder/nginx-proxy>

## Le principe

- Problème : On veut lancer des sites web variés mais on ne veut pas configurer Nginx.
- Solution : On se dit qu'on va lancer chaque site dans son conteneur Docker.
- Problème : on n'a qu'un seul port 80 à disposition. Vers quel conteneur va-t-on rediriger les requêtes ?
- Solution : on va mettre en place des vhosts,...
- Problème : zut, il faut alors quand même configurer un nginx sur la machine hôte ?!
- Solution : Eh non ! On va conteneuriser (?) ce nginx ! Et en plus... c'est déjà fait ! Il s'appelle nginx-proxy

Bref on  va lancer un conteneur nginx frontal qui va dispatcher les requêtes vers le bon conteneur en fonction d'un vhost. Voir le joli schéma ici : https://dimuthukasunwp.github.io/Articles/Hosting-multiple-sites-or-applications-using-Docker-and-NGINX-reverse-proxy-with-Letsencrypt-SSL.html

## Première étape : lancer le nginx "frontal"

Lancer sur le serveur (dans mon cas, un VPS OVH avec Docker-sur-Debian10 pré-installé) :

    docker run -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock:ro jwilder/nginx-proxy
    
Ceci indique simplement de :

- exécuter l'image `jwilder/nginx-proxy` (qui sera rapatriée du Docker Hub),
- exposer le port 80 sur le port 80, et
- monter `/var/run/docker.sock` (sur la machine hôte) sur `/tmp/docker.sock` (dans le conteneur docker) pour que le conteneur puisse avoir toute l'info sur les autres conteneurs qui seront lancés.

## Seconde étape : configurer le DNS

A priori on aimerait que le domaine `mon.domaine.top` résolve vers l'IP de la machine.

Pour mon tests, j'ai simplement ajouté une ligne contenant `ip-de-mon-serveur mon.domaine.top` dans mon `/etc/hosts` (sur ma machine client).
De la sorte, pas besoin de configurer un vrai nom de domaine juste pour tester.

À partir de ceci, on doit avoir une erreur 503 en se connectant à <http://mon.domaine.top/>. C'est normal, nginx ne sait pas encore où rediriger les requêtes.

## Troisième étape : lancer un serveur

Pour les besoins de tests, je vais juste lancer un netcat en mode écoute (`nc -l`) sur le serveur :

    docker run --expose 1234 -e VIRTUAL_HOST=mon.domaine.top -it --rm alpine:latest nc -l -p 1234

à partir de là, je retente la connexion depuis mon client vers <http://mon.domaine.top/> et les entêtes apparaissent côté serveur :

    GET / HTTP/1.1
    Host: mon.domaine.top
    Connection: close
    X-Real-IP: ip-de-mon-serveur
    X-Forwarded-For: ip-de-mon-serveur
    X-Forwarded-Proto: http
    X-Forwarded-Ssl: off
    X-Forwarded-Port: 80
    X-Original-URI: /
    User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:102.0) Gecko/20100101 Firefox/102.0
    Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8
    Accept-Language: fr-BE,fr;q=0.7,en;q=0.3
    Accept-Encoding: gzip, deflate
    DNT: 1
    Upgrade-Insecure-Requests: 1
    Sec-GPC: 1

Je peux même répondre (sur le serveur), par exemple en tapant "bazinga" suivi de `RET` puis `^D`. Mon navigateur montre alors "bazinga".

## Conclusion

C'est cool, ça marche. Il n'y a plus qu'à lancer des conteneurs qui exposent un port tout en leur définissant un VIRTUAL_HOST, et boum ça marche !
