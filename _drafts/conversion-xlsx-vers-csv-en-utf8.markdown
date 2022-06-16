---
layout: post
title: "Conversion xlsx vers csv en utf8, et d'autres choses"
categories: informatique
# featured-image: 
# featured-source: 
summary: ""
---
## Conversion de XLSX en CSV

Pour convertir un fichier LibreOffice Calc (ou Excel) en CSV, j'utilise :

    soffice --headless --convert-to csv nomDuFichier

L'argument qui suit `--convert-to` est le format désiré en sortie.

Cependant je voulais en plus que le fichier en sortie soit en UTF-8. J'ai donc utilisé l'incantation suivante :

    soffice --convert-to csv:"Text - txt - csv (StarCalc)":44,34,76 "$filename"

(le `--headless` est implicite désormais). L'explication[^1] du paramètre 44,34,76 est : 

- le premier élément correspond au séparateur (44 = la virgule),
- le second au caractère guillemet (34 = guillemet double),
- Le troisième à l'encodage (76 = utf-8).

Sources:

- <https://ask.libreoffice.org/t/how-to-convert-to-csv-with-utf-8-encoding-using-lo5-command-line/30711>
- [^1] <https://wiki.openoffice.org/wiki/Documentation/DevGuide/Spreadsheets/Filter_Options#Filter_Options_for_the_CSV_Filter>

## Liste d'extensions sous VS Codium

Voici les extensions actuellement installée sur mon VS Codium

    $ codium --show-versions --list-extensions
    bmewburn.vscode-intelephense-client@1.8.0
    dbaeumer.vscode-eslint@2.2.2
    ecmel.vscode-html-css@1.10.2
    esbenp.prettier-vscode@9.1.0
    MS-CEINTL.vscode-language-pack-fr@1.63.3
    redhat.java@1.3.0
    ritwickdey.LiveServer@5.7.4
    Zignd.html-css-class-completion@1.20.0

## 
