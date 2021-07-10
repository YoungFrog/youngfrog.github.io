---
layout: post
title: "Vers Chromecast depuis Linux"
categories: informatique
# featured-image: 
# featured-source: 
summary: ""
---

Nous avons accueilli à la maison une jolie enceinte : la [Beosound Level](https://www.bang-olufsen.com/fr/be/enceintes/beosound-level). 

Cette enceinte s'active/se configure via une application dédiée (reconnaissance via Bluetooth). 
Une fois configurée elle se connecte au réseau local en Wi-Fi (elle en demande poliment le mot de passe).
Elle intègre Google Assistant et s'accorde donc aussi avec l'application Google Home.

Le manuel mentionne une entrée RJ45 et une Line-In[^1] : il faut enlever un petit cache en plastique pour les trouver.

Les sources sonores seraient donc :
- Via Bluetooth (facile via un Smartphone ou un portable).
- Via une entrée câblée Line-in (qu'est-ce qui produit du Line-Out ? Une TV ou une carte son peut-être bien ?)
- Via l'application b&o : des radios sont proposées (streamées via Wi-Fi j'imagine, je n'ai pas vérifié)
- Via le Google Assistant, qui fera le lien avec Youtube Music ou Spotify (ou d'autres applis sur le téléphone, d'après l'application Google Home)
- Via le "Chromecast" intégré [j'imagine que c'est en réalité ceci que Google Assistant utilise]. Le terme _Chromecast_ se réfère d'habitude à un appareil qui se branche sur un écran TV. 
  Ici, il s'agit uniquement d'_audio_, directement intégré à l'enceinte.

[^1]: J'ai appris (https://myaudiolover.com/line-in-vs-mic-in) qu'une Line-In était une entrée au format Jack pour un son déjà amplifié.

## Chromecast

Mon ordinateur fixe ne possède pas de carte réseau sans-fil, donc ni Wi-Fi, ni Bluetooth. J'ai donc forcément été curieux : comment envoyer du son vers l'appareil via Wi-Fi ?
La réponse est : Chromecast le permet !
Je savais déjà que Google Chrome (le navigateur) pouvait "caster" un onglet. Je pense que Chromium le peut aussi. 
À partir de là, on peut imaginer sans peine que quelques hackers ont déjà résolu le problème de caster n'importe quoi depuis n'importe où... et en effet. 

Ce que j'ai cru comprendre de ce [Chromecast](https://fr.wikipedia.org/wiki/Chromecast) du point de vue technique:

1. Il faut configurer Chromecast pour utiliser un réseau local (ça c'est fait en configurant l'enceinte)
1. Niveau détection, Chromecast s'annonce via [mDNS](https://en.wikipedia.org/wiki/Zero-configuration_networking) (anciennement via un protocole nommé DIAL)
1. Lorsqu'une source audio (par exemple mon ordi) veut diffuser via Chromecast/l'enceinte, elle met en place un serveur de streaming HTTP, et enfin
1. elle envoie un signal à Chromecast pour commencer à récupérer ce signal en streaming

Les deux derniers points sont issus de mon interprétation de ce que j'ai lu/vu/fait avec [mkchromecast](#mkchromecast)
et aussi de ce qui est décrit dans cet [article parlant du support Chromecast par libvlc](https://mfkl.github.io/chromecast/2018/10/21/High-performance-cross-platform-streaming-with-libvlc-and-Chromecast-on-.NET.html)

### mkchromecast
Le but de https://github.com/muammar/mkchromecast/ est de pouvoir diffuser vers un appareil Chromecast depuis la ligne de commande.

On peut simplement lancer `mkchromecast`, puis ouvrir `pavucontrol` et modifier le périphérique de sortie d'une application audio vers mkchromecast. 
L'audio sera alors diffusé sur l'appareil Chromecast. 
Plus précisément mkchromecast va ouvrir un serveur web sur le port 5000 grâce à Node.js, duquel l'appareil Chromecast pourra récupérer le stream à diffuser.

J'ai eu les deux soucis suivants:

- https://github.com/muammar/mkchromecast/issues/334 -- workaround: `pip3 install zeroconf==0.24.3`
- https://github.com/home-assistant-libs/pychromecast/issues/356 -- un assez gros délai avant qu'un son joue.

Par ailleurs je n'ai pas réussi à utiliser l'option `-i fichier` pour diffuser un fichier spécifique : la connexion se fait, mais aucun son ne sort de l'appareil.

### vlc

Depuis sa [version 3](https://www.videolan.org/vlc/releases/3.0.0.html), [VLC](https://www.videolan.org/vlc/) peut streamer vers Chromecast et d'autres produits uPNP

Le plus dur pour moi fut de trouver le menu (dans la barre de menu : Lecture, puis Rendu), pour sélectionner l'appareil Chromecast. Sinon ça marche vraiment au poil. Par contre 

### pulseaudio-dlna

J'ai également brièvement regardé à https://github.com/Cygn/pulseaudio-dlna/ (un fork de [l'original](https://github.com/masmu/pulseaudio-dlna), pour fonctionner avec Python3) mais je ne l'ai pas testé. Le principe est similaire à mkchromecast. On trouvera quelques infos de mise en place ici: https://www.linuxuprising.com/2020/10/how-to-use-pulseaudio-dlna-to-stream.html?m=1

