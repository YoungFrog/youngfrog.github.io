---
layout: post
title: "clef gpg vs apt"
categories: informatique
# featured-image: 
# featured-source: 
summary: ""
---


Je pose ça là en vrac. 

J'avais un souci similaire à https://github.com/albertlauncher/albert/issues/1087 (la clef d'une personne a expiré)

Je comprends que le fichier qu'on nous fait mettre dans /etc/apt/trusted.gpg.d/ est en fait un keyring de GPG.
On peut donc consulter son contenu via

    gpg --no-default-keyring --keyring chemin/absolu/vers/le/fichier.gpg -k
    
on peut aussi ajouter des clefs via --recv-keys, etc. si les clefs sont publiées sur un serveur de clef
(apparemment la clef

Sources: 
- https://stackoverflow.com/questions/22136029/how-to-display-gpg-key-details-without-importing-it/22147506#22147506
