---
layout: post
title: "Gitlab Runners avec Docker"
categories: informatique
# featured-image: 
# featured-source: 
summary: "Quelques mots sur mes déboires avec les Runners, et ce que j'ai compris."
---


# Contexte

Pour exécuter les jobs CI/CD, un instance Gitlab a besoin d'au moins un Runner (= un ordinateur) disponible pour exécuter le job.
Deux types de Runner :
- les Runners mis à dispositions par l'instance (par exemple l'instance Gitlab.com propose des Runners partagés libre d'accès)
- les Runners mis à disposition par un utilisateur

Mon but était donc de proposer mon propre Runner pour un de mes projets.

On peut créer un Runner sur sa machine, et dans mon cas j'ai installé dans un conteneur Docker.

## Documentation officielle
- Généricités sur le CI/CD à la mode Gitlab : <https://docs.gitlab.com/ee/ci/index.html>
- Installation d'un Runner https://docs.gitlab.com/runner/install/index.html
- Installation d'un Runner dans un conteneur Docker https://docs.gitlab.com/runner/install/docker.html

## Le problème

La [doc](https://docs.gitlab.com/runner/install/docker.html#option-1-use-local-system-volume-mounts-to-start-the-runner-container) indique d'exécuter la commande suivante :

     docker run -d --name gitlab-runner --restart always \
       -v /srv/gitlab-runner/config:/etc/gitlab-runner \
       -v /var/run/docker.sock:/var/run/docker.sock \
       gitlab/gitlab-runner:latest
       
ce qui lance un conteneur avec gitlab-runner en fonctionnement dedans. On peut le constater avec `docker ps` ; le conteneur s'appelle `gitlab-runner`.

