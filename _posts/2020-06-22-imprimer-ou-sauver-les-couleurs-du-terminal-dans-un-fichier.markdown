---
layout: post
title: "Imprimer ou sauver les couleurs du terminal dans un fichier"
categories: blog personnal
# featured-image: 
# featured-source: 
summary: "Il m'arrive régulièrement de me dire que l'affichage sur mon terminal n'est pas si mal, et que j'aimerais bien le sauver en PDF, voire l'imprimer. Avec les couleurs."
---
Jusque là, la solution que j'ai pu trouver passe via un fichier intermédiaire en HTML.

## Création du fichier HTML

Il y a `ansi2html` issu du paquet `kbtin`, que j'avais installé un jour :

``` shell
commande | ansi2html >fichier.html
```

Ceci me définit un fond en noir. [Je pensais que c'était dépendant de ma configuration, mais cela reste vrai si je choisis blanc comme fond.] C'est cependant simple à modifier, puisque toutes les définitions de couleur sont en début de fichier.

Dans mon navigateur, si je diminue la taille de ma fenêtre, le texte se "wrappe". Ceci a une incidence sur la conversion en PDF : les fins de lignes manquent.

Mais j'ai aussi vu passer `aha` [^1], 
qui s'utilise similairement, 
mais m'a mis un fond blanc par défaut.
Si je diminue la taille de ma fenêtre, le texte ne se "wrappe" pas. Ceci a une incidence sur la conversion en PDF : les lignes sont très longues, et l'outil que j'utilise diminue la taille des caractères en conséquence pour que ça rentre. Par contre on peut utiliser une option pour changer cela:

``` shell
commande | aha -w >fichier.html
```

et hop !

## Création du fichier PDF

J'ai vu recommandé [^1] plusieurs fois [^2] `wkhtmltopdf` et je l'ai utilisé.

``` shell
wkhtmltopdf fichier.html fichier.pdf
```
ou, si on préfère les *brace expansion*,
``` shell
wkhtmltopdf fichier.{html,pdf}
```

À noter que cet outil fonctionne bien avec des fichiers HTML simples, tels que ceux produits par `aha` ou `ansi2html`, mais va (probablement) avoir du mal sur des documents plus complexes utilisant du CSS3 ou JavaScript : on trouvera d'autres outils dans [^2].

[^1]: <https://askubuntu.com/a/647809/> 

[^2]: <https://stackoverflow.com/questions/176476/how-can-i-automate-html-to-pdf-conversions>
