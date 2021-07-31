---
layout: post
title: "RDP via tunnel SSH versus Windows Defender"
categories: informatique
# featured-image: 
# featured-source: 
summary: ""
---

Le temps de cet article, supposons que j'utilise Windows...

## En théorie, ça marche

Sur un réseau local, j'ai deux serveurs.

Le serveur A est accessible via RDP (Remote Desktop Protocol).
Comme je n'y connais pas grand chose à RDP, je préfère ne pas laisser ce protocole ouvert sur le monde.
Je n'ouvre donc pas le port 3389 sur mon routeur-NAT.

Le serveur B est accessible via SSH, uniquement via un système de clef publique.
Celui là je lui fais à peu près confiance, et je forward donc le traffic du port 22 de mon routeur vers cette machine.

Dès lors si je veux accéder, depuis une machine M sur l'Internet, au serveur A (via RDP), je dois passer par le serveur B (via SSH).

Je crée donc un *tunnel ssh* via :

    ssh user@machineB -L 12345:machineA:3389

(ceci suppose que j'ai installé openssh) puis je me connecte en RDP (via la connexion "Bureau à distance" de Windows par exemple) à `localhost:12345`.
Bien sûr je peux choisir le port `12345`.

## En pratique, ça foire (mais pas longtemps)

Tout ça fonctionnait bien... jusqu'à ce que je veuille utiliser la connexion RDP.
Car là, au bout de quelques instants (au mieux), j'obtenais : `client_loop: send disconnect`

Alors j'ai tenté d'ajouter `-vvv` :

    ssh user@machineB -L 12345:machineA:3389 -vvv

et là j'ai pu constater les erreurs "CB ERROR:10013" et "ERROR:10054".
Je n'ai pas vraiment trouvé des infos sur ces erreurs en lien avec ssh.
Finalement, je pense qu'elles ne sont pas liées à ssh lui-même, mais aux sockets sous Windows de façon générique [^1].

Bref, j'ai désactivé Windows Defender, le firewall de Windows, et tout roule !

[^1]: Voici ce qui m'a mis la puce à l'oreille : <https://answers.microsoft.com/en-us/windows/forum/all/socket-10013-error-when-trying-to-connect-some/2cc71cb6-24b2-4b63-8f60-32bb444eb8fd>

## Et on va headless...

En ajoutant `-fNT` à la commande ssh c'est censé passer en background. Pas sûr que ça marche bien (ça n'a pas l'air d'être en background!), mais au moins je n'ai pas de session interactive qui se lance.

Pour lancer la connexion bureau à distance, il faut utiliser `mstsc /v:localhost:12345`[^2]

[^2]: Source: <http://infotinks.com/how-to-rdp-over-an-ssh-tunnel/>

## Alternatives

On peut aussi utiliser un client qui supporte le tunneling ssh nativement. Par exemple
[mRemoteNG](https://mremoteng.org/) [prétend pouvoir le faire](https://mremoteng.readthedocs.io/en/master/howtos/sshtunnel.html) mais je n'ai pas réussi à le mettre en place, faute d'avoir trouvé où configurer ma clef privée. Si j'ai bien compris ça utilise PuTTY en sous-main, donc ça doit être faisable...

Sous Linux j'utilise [Remmina](https://remmina.org/) et c'est très simple à configurer. Je pourrais [l'utiliser sous Windows](https://remmina.org/remmina-on-windows/) via [WSL](https://blog.namok.be/?post/2018/10/05/debian-microsoft) mais ma machine est moyennement puissante, et j'ai peur que ça n'aille pas super bien.
