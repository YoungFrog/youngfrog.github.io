---
layout: post
title: "espeak ferait-il buzzer mon audio ?"
categories: informatique
summary: "Parfois j'ai le son qui crachote et/ou qui retarde. J'accuse la librairie espeak."
---

Depuis que j'ai [acheté mon ordinateur](/informatique/2021/05/30/motherboard-z490-a-pro-and-linux.html), 
j'ai noté que quand je mets l'audio par défaut vers la sortie HDMI (mon écran)
j'obtiens parfois un ou les deux effets suivants:
- son retardé par rapport à l'image
- son qui fait "scritch scritch" (je sais pas comment décrire ça autrement) ; autrefois on aurait parlé de friture sur la ligne 
  (et on aurait dit qu'on était sur écoute!)

Aujourd'hui je pense avoir trouvé un coupable : espeak.

> eSpeak, écrit en C++, est un logiciel de synthèse vocale pour l'anglais et certaines autres langues, dont le français.
> Il utilise une méthode de synthèse différente des autres moteurs libres de synthèse vocale, et a un son assez différent. Il n'est peut-être pas aussi naturel ou "fluide", mais certains trouvent l'articulation plus claire et plus facile à écouter sur de longues périodes. 
(Source: <https://doc.ubuntu-fr.org/espeak>)

Je l'accuse parce que quand je désactive le module *espeak-dispatcher-espeak-ng* via *pavucontrol*, le problème disparait !

Je n'en sais pas beaucoup plus... à creuser.
