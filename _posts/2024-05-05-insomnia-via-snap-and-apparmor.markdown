---
layout: post
title: "Insomnia via snap and apparmor"
categories: informatique
# featured-image: 
# featured-source: 
summary: ""
---
Problème : je tente de lancer insomnia installé via snap, et rien ne se passe

Les logs mentionnent:
```
kernel: audit: type=1400 audit(1714901085.726:356): apparmor="DENIED" operation="open" class="file" profile="snap.insomnia.insomnia" name="/some/path/where/I/store/music/" pid=67048 comm="head" requested_mask="r" denied_mask="r" fsuid=1000 ouid=1000
kernel: audit: type=1400 audit(1714901085.734:357): apparmor="DENIED" operation="rmdir" class="file" profile="snap.insomnia.insomnia" name="/some/path/where/I/store/music/" pid=67054 comm="rmdir" requested_mask="d" denied_mask="d" fsuid=1000 ouid=1000
```

Sur <https://github.com/bitwarden/clients/issues/2629> un commentaire pertinent:

   Snap fails to open when Documents/Pictures/Downloads/... are symlinks.

Le commentaire suivant suggère

```bash
rm ~/snap/.../current/.config/user-dirs.*
```
(où `"..."` serait `"insomnia"` dans mon cas) et de fait, ça fonctionne ! Ce fichier contenait une série de lignes comme:

```bash
XDG_DESKTOP_DIR="/home/user/Bureau"
XDG_DOWNLOAD_DIR="/home/user/Téléchargements"
XDG_TEMPLATES_DIR="/home/user/Modèles"
XDG_PUBLICSHARE_DIR="/home/user/Public"
XDG_DOCUMENTS_DIR="/home/user/Documents"
XDG_MUSIC_DIR="/home/user/Musique"
XDG_PICTURES_DIR="/home/user/Images"
XDG_VIDEOS_DIR="/home/user/Vidéos"
```
Chez moi certains de ces répertoires sont des liens symboliques, ce qui semble perturber certains logiciels via snap

Le problème semble apparaître avec d'autres snaps :
- <https://github.com/snapcrafters/discord/issues/67> (2019, discord)
- <https://answers.launchpad.net/ubuntu/+source/gnome-calculator/+question/703933> (2022, gnome-calculator)
