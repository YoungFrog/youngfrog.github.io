---
layout: post
title: "Les formules de mise en forme conditionnelle de Google Sheets"
categories: informatique
# featured-image: 
# featured-source: 
summary: ""
---

(Ce post s'applique peut-être à LibreOffice Calc, Gnumeric ou encore Microsoft Excel, mais je n'en sais rien.)

Parfois je cherche à mettre en évidence (fond coloré) des cases dans Google Sheets. Cela se fait avec la mise en forme conditionnelle.

J'ai toujours trouvé la [doc][0] un peu vague ou avare d'exemple sur les points suivants:

- Mise en forme d'une plage de cases. Comment référencer la case courante ?
- Mise en forme d'une case par rapport à la valeur d'une autre case. Comment référencer une case en décalage par rapport à la case Courante ?
- Mise en forme d'une case par rapport à la valeur dans une autre feuille de données. Comment ?


## Le cas débile : mise en forme d'une seule case par rapport à sa propre valeur

C'est le cas le plus simple et intuitif.

Google propose de nombreux choix OOTB (la case est vide, n'est pas vide, est entre deux dates, est entre deux valeurs, le texte se termine par, etc.)

Si on veut le faire avec une formule personnalisée, c'est très simple aussi. Il faut entrer la formule précédée de `=`

Par exemple pour formatter la case `D42` si son carré est négatif, on peut faire `=D42*D42 < 0`.

## Mise en forme d'une plage de cases

Appliquer la mise en forme à une plage est simple, mais comment construire une formule personnalisée ?

La solution est intuitive mais je trouve peu ou mal documentée : il faut construire la formule par rapport à la première case (première ligne, première colonne) de la plage.
Les formules pour les autres cases seront adaptées par le [mécanisme habituel](#le-mécanisme-habituel-de-copiage-de-formule--références-relatives-et-absolues) des références relatives.

## Mise en forme avec référence à une autre feuille.

La documentation mentionne cela explicitement mais c'est contre-intuitif : 

> Note: Formulas can only reference the same sheet, using standard notation "(='sheetname'!cell)." To reference another sheet in the formula, use the INDIRECT function.

Donc au lieu d'écrire `'sheetname'!cell` il faut écrire `INDIRECT("'sheetname'!cell")`.

Un exemple que j'ai écrit : `=VLOOKUP($A2;INDIRECT("'Cotes 2020-2021'!$A$13:$AE$383");29+COLUMN()-4;FALSE)<>""` -- Je n'en suis pas particulièrement fier, mais je suis content que ça marche.

Ceci implique notamment qu'on n'a pas les références relative. C'est généralement raisonnable comme restriction puisqu'on pioche dans une autre feuille, mais si on a un besoin particulier, il suffit d'utiliser les fonctions `ROW()` et `COLUMN()` pour construire la référence. Par exemple `INDIRECT("'sheetname'!A" & ROW())` va aller piocher la valeur dans la colonne A de la feuille sheetname, à la ligne correspondant à la ligne courante.

## Le mécanisme habituel de copiage de formule : références relatives et absolues.

Ce mécanisme est [étrangement non-documenté][1] sur Google Sheets, mais est commun à tous les tableurs que je connais.

En clair quand on copie une formule[^1], les références relatives sont adaptées, mais pas les absolues.

Une référence (à une cellule) est *absolue* si elle est précédée d'un signe dollar `$`. Sinon elle est *relative*.

Par exemple si dans la cellule `D42` on indique 
- `=A$13` : le numéro de ligne (13) est absolu, mais pas le numéro de colonne. Donc si cette formule est recopiée vers la cellule `E43` la valeur de la nouvelle formule sera `B$13` : la colonne a été adaptée (une colonne de plus), mais pas le numéro de ligne.
- `=$A13` : la colonne est absolue mais ligne est relative. 
- `=$A$13` : tout est absolu.
- `=A13` : tout est relatif.

Quand on édite une formule, le raccourci `F4` permet d'ajuster le caractère relatif ou absolu de la référence courante.


[0]: https://support.google.com/docs/answer/78413?hl=en&co=GENIE.Platform%3DDesktop#zippy=%2Cuse-custom-formulas-with-conditional-formatting

[1]: https://support.google.com/docs/thread/5225132/can-i-prevent-down-fill-from-incrementing-every-cell-reference-in-a-formula?hl=en&msgid=5228310

[^1]: Que ce soit par copier-coller (raccourci `C-c` et `C-v`), ou via la fonction "Remplir vers le bas" (raccourci `C-d`)
