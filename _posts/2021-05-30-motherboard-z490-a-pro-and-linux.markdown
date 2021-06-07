---
layout: post
title: "Motherboard Z490-A PRO and Linux"
categories: informatique
# featured-image: 
# featured-source: 
summary: ""
---
"T'inquiète ça va aller, je gère, j'utilise Linux depuis 20 ans"

Voilà en substance ce que j'ai dit au vendeur en achetant une machine équipe de [la carte mère MSI Z490-A Pro](https://www.msi.com/Motherboard/support/Z490-A-PRO#down-bios).

Eh bien j'ai quand même un peu souffert.

# Le boot

D'abord quelques raccourcis: au démarrage F11 affiche le menu de boot.
Dans le BIOS : F1 pour afficher les raccourcis supportés

Et au début rien ne bootait :
- L'écran de configuration du BIOS UEFI se lançait automatiquement. 
- Mes clefs USB étaient détectées mais je revenais au menu BIOS immédiatement.

Le souci était vraisemblablement que mes clefs ne sont pas adaptées au boot UEFI.

J'ai donc :
- Désactivé le UEFI Secure Boot (probablement utile)
- Désactivé toute forme de Fast Boot (probablement inutile)
- Switché en mode CSM (https://superuser.com/a/692040/)

À partir de là, mes clefs bootaient et GRUB se lançait. Yay !

Yay ?

Oh... no...

# L'installation
Les clefs bootaient mais les écrans noirs se succédaient, quelle que soit la clef que j'utilisais (une vieille Ubuntu, un GParted disk, une trisquel)...

En enlevant les options "quiet splash", je notais un souci avec le driver graphique drm nouveau: "out of mapped bounds".
En tentant une install en mode texte ("text" à la place de "quiet splash"), j'avais une Kernel Panic parce que le pépin ne trouvait pas son root filesystem... 
J'en ai conclu qu'il trouvait pas la clef USB.

J'ai donc téléchargé les 2.6Go de la dernière Ubuntu 20.04 (LTS), et tenté le coup pour le tout. 
J'ai utilisé usb-creator-gtk pour produire une clef USB bootable (j'avais envisagé un network boot mais finalement j'ai préféré la voie de la clef USB).

# La carte réseau
La magie de Ubuntu opère : ça maaaarche. 
L'installation se passe sans encombre mais sans réseau : mon routeur est trop loin, je n'ai pas de câble jusque là, et bien sûr pas d'adaptateur Wi-Fi sur une machine fixe. 
Qu'à cela ne tienne, je compte bien utiliseR mon laptop comme passerelle... sauf que... en fait "pas de réseau" c'est vraiment "pas de réseau" :

- `lshw -C network` me dit "NON-RÉCLAMÉ" 
- `lspci -K` me dit que le module est r8169
- `dmesg | grep r8169` me dit "can't disable ASPM; OS doesn't have ASPM control" (<https://askubuntu.com/questions/372363/what-does-r8169-cant-disable-aspm-os-doesnt-have-aspm-control-really-mean>) et surtout "unknown chip XID 641" (<https://askubuntu.com/questions/1269783>)

Heureusement Realtek a un driver <https://www.realtek.com/en/component/zoo/category/rtl8169sc-l-software>
malheureusement/évidemment c'est un module du kernel, donc il faut les outils de compilation du kernel : gcc, make, binutils

# Installre des paquets pour compiler, sans le réseau

J'aurais sans doute dû utiliser https://doc.ubuntu-fr.org/apt-offline mais j'ai été beaucoup plus stupide que ça.

On peut ré-utiliser la clef usb utilisée pour l'installation de Ubuntu. Certains logiciels y sont (mais pas tous) :
- On insère la clef (ça se monte tout seul)
- On *va* dans le répertoire Ubuntu ainsi monté, et on crée un lien symbolique : `ln -svr . /media/cdrom` 
- Dans `/etc/apt/source.list` on dé-commente la ligne correspondant au cdrom (perso j'ai juste bougé le fichier et créé un fichier vide avec juste cette ligne-là) :

  ```
  deb cdrom:[Ubuntu 20.04.1 LTS _Focal Fossa_ - Release amd64 (20200741)]/ focal main restricted
  ```
  
Et zou, `apt install gcc make binutils bzip2 coreutils libc-dev` tourne tout seul.

## Récupérer linux-source
Je me suis bêtement dit que j'aurais besoin des sources du noyau pour compiler le module de realtek... ce n'est pas complètement vrai.

Malgré tout, je l'ai fait, voici mes traces:

Je vais sur https://packages.ubuntu.com/focal/linux-source-5.4.0
et je télécharge les 129 Mo sur ma clef USB, que je passe sur l'autre machine, et:

```
dpkg -i linux-source*deb
```

Et maintenant les sources sont dans `/usr/src`. Yay ! J'y vais en root (`sudo -i`) et il faut les décompresser avec `tar xf linux-source*bz2`

## RHA FUCK il faut aussi flex, m4, et d'autres brols

Bref je vais tenter autre chose : le drive de realtek est intégré au noyau depuis la version 5.9 si j'ai bien suivi

Après coup j'ai noté qu'avec ceci ça devrait marcher

```
libncurses-dev
libfl-dev
libfl2
libsigsegv2
m4
bison
build-essential
dpkg-dev
fakeroot
g++
g++-9
libalgorithm-diff-perl
libalgorithm-diff-xs-perl
libalgorithm-merge-perl
libfakeroot
libstc++-9-dev
autoconf
automake
autotools-dev
libltdl-dev
libtool
libssl-dev
libelf-dev
zlib1g-dev
```

autoconf
automake
autopoint
autotools-dev
debhelper
dh-autoreconf
dh-stripnondeterminism
dwz
gettext
intltool-debian
libarchive-zip-perl
libcroco3
libdebhelper-perl
libfile-stripnondeterminism-perl
libsub-override-perl
libtool
linux-headers-5.4.0-26 
linux-headers-5.4.0-26-generic
po-debconf


## make oldconfig
Pour récupérer la config existante, je lance `sudo make oldconfig`
Quelques questions me sont alors posées. Puis je lance `make clean modules`


# installer Linux Kernel 5.9
Je vais donc choper un kernel 5.9
https://ubuntuhandbook.org/index.php/2020/10/linux-kernel-5-9-released/

et zou, ça maaaarche

# Carte Graphique  GT 1030 (rien à voir avec la mobo)
J'ai une GT 1030. Pas tout récent, pas super, mais suffisante. Par contre, en terme de driver, c'est du nvidia, donc j'ai le choix entre le driver libre *nouveau* ou les *drivers proprios* de nvidia.

Les drivers "nouveau" sont ok (des trucs s'affichent), mais pas top (pas d'accélération).

- nvidia a publié une partie de ce qu'il faut pour que la carte fonctionne plus ou moins https://www.phoronix.com/scan.php?page=news_item&px=NVIDIA-GP108-Firmware
- toutefois `vdpauinfo` mentionne que plein de trucs non supportés :

    ```
    name                        level macbs width height
    ----------------------------------------------------
    MPEG1                          --- not supported ---
    MPEG2_SIMPLE                   --- not supported ---
    MPEG2_MAIN                     --- not supported ---
    H264_BASELINE                  --- not supported ---
    H264_MAIN                      --- not supported ---
    H264_HIGH                      --- not supported ---
    VC1_SIMPLE                     --- not supported ---
    VC1_MAIN                       --- not supported ---
    VC1_ADVANCED                   --- not supported ---
    MPEG4_PART2_SP                 --- not supported ---
    MPEG4_PART2_ASP                --- not supported ---
    DIVX4_QMOBILE                  --- not supported ---
    DIVX4_MOBILE                   --- not supported ---
    DIVX4_HOME_THEATER             --- not supported ---
    DIVX4_HD_1080P                 --- not supported ---
    DIVX5_QMOBILE                  --- not supported ---
    DIVX5_MOBILE                   --- not supported ---
    DIVX5_HOME_THEATER             --- not supported ---
    DIVX5_HD_1080P                 --- not supported ---
    H264_CONSTRAINED_BASELINE      --- not supported ---
    H264_EXTENDED                  --- not supported ---
    H264_PROGRESSIVE_HIGH          --- not supported ---
    H264_CONSTRAINED_HIGH          --- not supported ---
    H264_HIGH_444_PREDICTIVE       --- not supported ---
    HEVC_MAIN                      --- not supported ---
    HEVC_MAIN_10                   --- not supported ---
    HEVC_MAIN_STILL                --- not supported ---
    HEVC_MAIN_12                   --- not supported ---
    HEVC_MAIN_444                  --- not supported ---
    ```

- du coup je vais pour installer les drivers propriétaires. 
  ça me saoule, et la prochaine fois je dois absolument être plus attentif à ça, mais tant pis.

  - J'ai le choix entre un fichier venant de nvidia directement :
     https://www.nvidia.com/content/DriverDownload-March2009/confirmation.php?url=/XFree86/Linux-x86_64/381.22/NVIDIA-Linux-x86_64-381.22.run&lang=us&type=TITAN
  - ou un ppa :
    https://launchpad.net/~graphics-drivers/+archive/ubuntu/ppa
  - ou via l'interface Ubuntu comme expliqué ici: https://linoxide.com/linux-how-to/how-to-install-nvidia-driver-on-ubuntu/

  j'ai failli prendre la voie du ppa (d'ailleurs j'ai ajouté le ppa) et j'ai aussi installé [phoronix-test-suite](http://phoronix-test-suite.com/releases/repo/pts.debian/files/phoronix-test-suite_10.2.0_all.deb)
  puis finalement j'ai choisi la voie "ubuntu" (via l'interface). Je suppose que l'interface aurait ajouté le ppa si je ne l'avais pas fait. Je n'en sais trop rien. 
  Parmis les choix j'ai pris le premier : `nvidia-driver-460 (propriétaire, testé)`

  En arrière plan, cela a donc installé ceci (cf /var/log/apt/history.log) :

  ```
  Start-Date: 2021-01-23  20:47:28
  Commandline: packagekit role='install-packages'
  Requested-By: youngfrog (1000)
  Install: libxdmcp6:i386 (1:1.1.3-0ubuntu1, automatic), libvulkan1:i386 (1.2.131.2-1, automatic), libdrm-nouveau2:i386 (2.4.102-1ubuntu1~20.04.1, automatic), libxcb-xfixes0:i386 (1.14-2, automatic), libnvidia-compute-460:amd64 (460.32.03-0ubuntu0.20.04.1, automatic), libnvidia-compute-460:i386 (460.32.03-0ubuntu0.20.04.1, automatic), libnvidia-encode-460:amd64 (460.32.03-0ubuntu0.20.04.1, automatic), libnvidia-encode-460:i386 (460.32.03-0ubuntu0.20.04.1, automatic), nvidia-kernel-common-460:amd64 (460.32.03-0ubuntu0.20.04.1, automatic), gcc-10-base:i386 (10.2.0-5ubuntu1~20.04, automatic), xserver-xorg-video-nvidia-460:amd64 (460.32.03-0ubuntu0.20.04.1, automatic), libpciaccess0:i386 (0.16-0ubuntu1, automatic), libnvidia-gl-460:amd64 (460.32.03-0ubuntu0.20.04.1, automatic), libnvidia-gl-460:i386 (460.32.03-0ubuntu0.20.04.1, automatic), libxcb-present0:i386 (1.14-2, automatic), libgl1:i386 (1.3.2-1~ubuntu0.20.04.1, automatic), libglapi-mesa:i386 (20.2.6-0ubuntu0.20.04.1, automatic), libnvidia-fbc1-460:amd64 (460.32.03-0ubuntu0.20.04.1, automatic), libnvidia-fbc1-460:i386 (460.32.03-0ubuntu0.20.04.1, automatic), libelf1:i386 (0.176-1.1build1, automatic), libnvidia-decode-460:amd64 (460.32.03-0ubuntu0.20.04.1, automatic), libnvidia-decode-460:i386 (460.32.03-0ubuntu0.20.04.1, automatic), libbsd0:i386 (0.10.0-1, automatic), zlib1g:i386 (1:1.2.11.dfsg-2ubuntu1.2, automatic), libc6:i386 (2.31-0ubuntu9.1, automatic), libnvidia-cfg1-460:amd64 (460.32.03-0ubuntu0.20.04.1, automatic), libxcb-randr0:i386 (1.14-2, automatic), nvidia-utils-460:amd64 (460.32.03-0ubuntu0.20.04.1, automatic), dkms:amd64 (2.8.1-5ubuntu1, automatic), libx11-6:i386 (2:1.6.9-2ubuntu1.1, automatic), nvidia-prime:amd64 (0.8.14, automatic), libexpat1:i386 (2.2.9-1build1, automatic), libcrypt1:i386 (1:4.4.10-10ubuntu4, automatic), libxshmfence1:i386 (1.3-1, automatic), nvidia-dkms-460:amd64 (460.32.03-0ubuntu0.20.04.1, automatic), libwayland-client0:i386 (1.18.0-1, automatic), libxnvctrl0:amd64 (440.82-0ubuntu0.20.04.1, automatic), libdrm-amdgpu1:i386 (2.4.102-1ubuntu1~20.04.1, automatic), libllvm11:i386 (1:11.0.0-2~ubuntu20.04.1, automatic), libxau6:i386 (1:1.0.9-0ubuntu1, automatic), libtinfo6:i386 (6.2-0ubuntu2, automatic), libxcb1:i386 (1.14-2, automatic), nvidia-compute-utils-460:amd64 (460.32.03-0ubuntu0.20.04.1, automatic), libdrm2:i386 (2.4.102-1ubuntu1~20.04.1, automatic), libnvidia-ifr1-460:amd64 (460.32.03-0ubuntu0.20.04.1, automatic), libnvidia-ifr1-460:i386 (460.32.03-0ubuntu0.20.04.1, automatic), nvidia-driver-460:amd64 (460.32.03-0ubuntu0.20.04.1), libglx0:i386 (1.3.2-1~ubuntu0.20.04.1, automatic), libxfixes3:i386 (1:5.0.3-2, automatic), libgl1-mesa-dri:i386 (20.2.6-0ubuntu0.20.04.1, automatic), libxxf86vm1:i386 (1:1.1.4-1build1, automatic), libgcc-s1:i386 (10.2.0-5ubuntu1~20.04, automatic), screen-resolution-extra:amd64 (0.18build1, automatic), libxdamage1:i386 (1:1.1.5-2, automatic), libedit2:i386 (3.1-20191231-1, automatic), libdrm-intel1:i386 (2.4.102-1ubuntu1~20.04.1, automatic), libffi7:i386 (3.3-4, automatic), libunistring2:i386 (0.9.10-2, automatic), libzstd1:i386 (1.4.4+dfsg-3, automatic), libdrm-radeon1:i386 (2.4.102-1ubuntu1~20.04.1, automatic), libnvidia-common-460:amd64 (460.32.03-0ubuntu0.20.04.1, automatic), mesa-vulkan-drivers:i386 (20.2.6-0ubuntu0.20.04.1, automatic), libatomic1:i386 (10.2.0-5ubuntu1~20.04, automatic), libstdc++6:i386 (10.2.0-5ubuntu1~20.04, automatic), libnvidia-extra-460:amd64 (460.32.03-0ubuntu0.20.04.1, automatic), libxcb-glx0:i386 (1.14-2, automatic), libxcb-dri2-0:i386 (1.14-2, automatic), libsensors5:i386 (1:3.6.0-2ubuntu1, automatic), libxcb-dri3-0:i386 (1.14-2, automatic), libidn2-0:i386 (2.2.0-2, automatic), libx11-xcb1:i386 (2:1.6.9-2ubuntu1.1, automatic), libxcb-sync1:i386 (1.14-2, automatic), nvidia-kernel-source-460:amd64 (460.32.03-0ubuntu0.20.04.1, automatic), nvidia-settings:amd64 (440.82-0ubuntu0.20.04.1, automatic), libxext6:i386 (2:1.3.4-0ubuntu1, automatic), libglx-mesa0:i386 (20.2.6-0ubuntu0.20.04.1, automatic), libglvnd0:i386 (1.3.2-1~ubuntu0.20.04.1, automatic)
  End-Date: 2021-01-23  20:48:20
  ```

    Je redémarre et je vois ce que ça donne.

  Update : quelques semaines/mois plus tard, je réalise que de temps en temps quand je fais la màj, j'ai des plantages.
  Souvent un reboot suffit (pour charger le kernel qui fonctionne avec les nouveaux drivers installés),
  une fois je crois que j'ai dû ré-installer le driver propriétaire et je sais plus trop comment j'ai fait.
