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

- pour le recto: 4 1
- pour le verso: 2 3

Je voudrais couper ces pages et les mettre dans l'ordre. Pour le découpage, je suis parti sur pdfposter :

<https://askubuntu.com/questions/206468/split-tile-a3-landscape-pdf-to-a4-portrait>

    pdftk A=./alg3-2022-08-copies-etudiantes-a4.pdf cat Aeven output 2-1.pdf
    pdftk A=./alg3-2022-08-copies-etudiantes-a4.pdf cat Aodd output 3-4.pdf

ensuite j'ai chipoté à coup de pdftk :

    pdftk A=2-1.pdf B=3-4.pdf shuffle Aeven Aodd Bodd Beven output copies.pdf


