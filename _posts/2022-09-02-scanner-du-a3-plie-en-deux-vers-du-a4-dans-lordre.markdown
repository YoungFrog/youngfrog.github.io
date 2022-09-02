---
layout: post
title: "Scanner du A3 plié en deux vers du A4 dans l'ordre"
categories: informatique
# featured-image: 
# featured-source: 
summary: ""
---

Disons que j'écris sur une feuille A3 pliée en deux comme un livret. 
Je peux donc écrire 4 faces, que je note 1, 2, 3, 4. 
(1 = "couverture", 2, 3 = "l'intérieur", et 4 = "couverture")

Si j'ouvre ce livret et que je le scanne, ça me donne :

- pour le recto: 2 3
- pour le verso: 4 1

Je voudrais couper ces pages et les mettre dans l'ordre. Pour le découpage, je suis parti sur pdfposter :

<https://askubuntu.com/questions/206468/split-tile-a3-landscape-pdf-to-a4-portrait>

pour obtenir un fichier `temp.pdf` contenant les pages `2 3 4 1`.

ensuite j'ai chipoté à coup de pdftk :

    pdftk A=./temp.pdf cat Aeven output 3-1.pdf
    pdftk A=./temp.pdf cat Aodd output 2-4.pdf
    pdftk A=3-1.pdf B=2-4.pdf shuffle Aeven Bodd Aodd Beven output final.pdf

et zoup !

<!-- J'ai même tenté de tout faire en un coup mais ça n'a pas work : -->

<!--     pdftk A=./temp.pdf shuffle Aeveneven Aoddodd Aevenodd Aoddeven output final.pdf -->
