---
layout: post
title: "Imprimer ou sauver les couleurs du terminal dans un fichier"
categories: blog personnal
# featured-image: 
# featured-source: 
# summary: ""
---
Il m'arrive régulièrement de me dire que l'affichage sur mon terminal n'est pas si mal, et que j'aimerais bien le sauver en PDF, voire l'imprimer. Avec les couleurs.

Jusque là, la solution que j'ai pu trouver passe via un fichier intermédiaire en HTML.

## Création du fichier HTML

Il y a `ansi2html` issu du paquet `kbtin`, que j'avais installé un jour :

``` shell
commande | ansi2html >fichier.html
```

Ceci me définit comme couleur de fond, la même que celle que j'ai sur mon terminal.
Du noir, actuellement.
Si je diminue la taille de ma fenêtre, le texte se "wrappe". Ceci a une incidence sur la conversion en PDF : les fins de lignes manquent.

Mais j'ai aussi vu passer `aha` [^1], 
qui s'utilise similairement, 
mais m'a mis un fond blanc par défaut.
Si je diminue la taille de ma fenêtre, le texte ne se "wrappe" pas. Ceci a une incidence sur la conversion en PDF : les lignes sont très longues, et l'outil que j'utilise diminue la taille des caractères en conséquence pour que ça rentre.

## Création du fichier PDF

J'ai vu recommandé [^1] `wkhtmltopdf` et je l'ai utilisé.

``` shell
wkhtmltopdf fichier.html fichier.pdf
```
ou, si on aime les *brace expansion*,
``` shell
wkhtmltopdf fichier.{html,pdf}
```

[^1]: <https://askubuntu.com/a/647809/> 

https://stackoverflow.com/questions/176476/how-can-i-automate-html-to-pdf-conversions
