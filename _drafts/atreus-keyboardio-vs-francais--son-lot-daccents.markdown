---
layout: post
title: "Atreus Keyboardio vs Français & son lot d'accents"
categories: informatique
# featured-image: 
# featured-source: 
summary: "Mes débuts avec le Keyboardio Atreus"
---

Je me suis laissé tenter par un clavier [Atreus](https://atreus.technomancy.us/) dans sa version [Keyboardio Atreus](https://shop.keyboard.io/products/keyboardio-atreus) 
(c'est-à-dire que je n'ai rien à souder, rien à monter).

## Description

- transportable : environ 25 x 9cm, 
- programmable : très simplement via un outil graphique, ou de façon plus fine en ajustant le firmware,
- 44 touches. 

Pour comparer, un clavier AZERTY classique a 105 touches. C'est pas la taille qui compte, mais bien le nombre de touches.

## Comment fonctionne un clavier

Pour simplifier (et parce que je n'en sais pas plus), un clavier envoie des événements à l'ordinateur du type

- "telle touche a été pressée", ou
- "telle touche a été relâchée"

La touche spécifique est transmise sous forme d'un (bête|simple) numéro.

Malheureusement, il y a de nombreux standards et usages pour ce numéro, et le numéro varie au fur et à mesure qu'il est interprété par les différents niveaux gérant le clavier.

### Usage ID "USB"

Le clavier Atreus se connecte en USB ;
il faut donc regarder du côté de la spécification USB pour comprendre le numéro défini dans la bête :
https://www.usb.org/document-library/hid-usage-tables-121

C'est ce numéro qu'on utilisera dans Chrysalis (sous le nom de "keycode)" puisque
cette table a été traduite dans le code source de Kaleidoscope (le firmware dans
le Atreus): 
https://github.com/keyboardio/Kaleidoscope/blob/master/src/kaleidoscope/HIDTables.h

Le nom correspond à l'utilisation du numéro dans le cadre d'une disposition Qwerty US :
```
#define HID_KEYBOARD_2_AND_AT					0x1F	// Sel
```
Cette touche produit un `2` ou un `@` (avec la touche Shift) en Qwerty US. 
Mais en Azerty, ça produit un `é` ou un `2` (avec la touche Shift).

### Scancode "Linux"

D'après https://stackoverflow.com/questions/45774113/how-to-translate-x11-keycode-back-to-scancode-or-hid-usage-id-reliably :

lorsque Linux reçoit l'info, il reçoit un scancode.
Le passage du Usage ID au Scancode reste un mystère pour moi.

### Keycode "Linux"

Linux traduit également les scancodes en keycodes (`man showkey`) a aussi une notion de "keycode", mais c'est pas la même.


### Keysym "X"


De façon intéressante

## Clavier « programmable »

Le Keybordio Atreus fait partie d'une famille de claviers complètement programmables.



https://bepo.fr/wiki/Atreus (principalement par laurentb: https://forum.bepo.fr/profile.php?id=551)
http://bepo.fr/wiki/Utilisateur:Sgdjs





Key selector redesign:
https://github.com/keyboardio/Chrysalis/pull/591

ktouch (hyper lent sur mon ordi)

https://www.reddit.com/r/vim/comments/77nnoz/want_to_learn_proper_typing_form_this_is_my/ proposoe:
- http://www.typingstudy.com/ -- 
- http://zty.pe/ -- un petit jeu, n'apprend rien en soi
- https://www.typingclub.com/ -- ça marche
- GNU typist -- console program (pas de disposition montrée) -- ne connait pas azerty ni bépo ootb -- peut utiliser des(les?) fichiers de ktouch.
- klavaro -- mon choix. Il connait les dispositions classiques azerty france, la variante belge mais aussi bepo (choisir: France - dvorak_bepo) !

Also seen in apt:
- tuxtype
- speedpad
