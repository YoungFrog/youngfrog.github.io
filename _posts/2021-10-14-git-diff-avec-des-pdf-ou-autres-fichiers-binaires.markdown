---
layout: post
title: "git diff avec des pdf, ou autres fichiers binaires"
categories: informatique
# featured-image: 
# featured-source: 
summary: ""
---
Par défaut si `git diff` doit montrer des fichiers binaires, il indique juste 

> Binary files a/... and b/... differ

Il y a essentiellement deux techniques pour avoir un diff pertinent.

- [Utiliser un textconv](#utiliser-un-textconv)
- [Invoquer un difftool](#invoquer-un-difftool)

## Utiliser un textconv

On peut définir un convertisseur (appelé "textconv") qui sera appelé avant le diff. Son but est de transformer le PDF (ou autre format) en texte ; et après c'est `diff` qui fait le boulot.

En pseudo-code `diff -u <(converitsseur fichier1) <(converitsseur fichier2)` serait appelé par git au lieu de `diff -u fichier1 fichier2`. 

Pour cela il faut :

1. créer le convertisseur, et
2. l'utiliser pour les fichiers PDF (ou autre...)

### Créer le convertisseur

Là c'est via gitconfig[^1] (`~/.gitconfig`, `.git/config`, `/etc/gitconfig`), par exemple
```
git config --global diff.pdffilter.textconv pdftotext
```
où
- `pdffilter` est le nom (choisi arbitrairement) du convertisseur, et
- `pdftotext` le nom d'un programme qui peut convertir un pdf en texte pur (qui sera ensuite "diffé" à la place du vrai fichier).

Perso mon textconv il ressemble à ça:

```sh
#!/bin/sh
if [ -s "$1" ]; then
   java -jar ~/bin/pdfbox-app-1.8.4.jar ExtractText "$1" /dev/stdout
else
   cat "$1"
fi
# pdf2text "$1" -
```

où pdfbox vient de <https://pdfbox.apache.org/download.html> (il y a une version 2 et même une version 3. Je sais : je suis à la traine...)


### Utiliser le convertisseur
Ceci est une simple configuration via `.gitattributes` ou `.git/info/attributes` ou `~/.config/git/attributes` ou `/etc/gitattributes` (pour les détails sur quel fichier est lu à quel moment : voir [git help attributes](https://git-scm.com/docs/gitattributes#_description)).

```
*.pdf diff=pdffilter
```
où `pdffilter` est le nom du convertisseur, choisi précédemment.
(`diff` est ici le nom d'un attribut. Il y en a d'autres pour faire d'autres choses.)


## Invoquer un difftool

On peut configurer un truc pour pouvoir appeler `git difftool` mais j'ai plus ça en tête.


On peut aussi faire ça, mais...

```bash
GIT_EXTERNAL_DIFF=diffpdf git diff
```

où `diffpdf` est un programme qui sait comparer ce qu'il y a à comparer.

...mais ça marchera sans doute pas si les fichiers en question sont pas des PDF. Et aussi le programme sera appelé avec [7 paramètres](https://git-scm.com/docs/git#Documentation/git.txt-codeGITEXTERNALDIFFcode), donc il faudra sans doute un wrapper. Bref ça peut marcher, mais c'est pas fiable.

[^1]: à ce sujet je note qu'on peut utiliser `git config --local include.path ../.gitconfig` pour inclure automatiquement un fichier gitconfig à la racine du dépôt. Source: <https://stackoverflow.com/questions/18329621/how-to-store-a-git-config-as-part-of-the-repository>
