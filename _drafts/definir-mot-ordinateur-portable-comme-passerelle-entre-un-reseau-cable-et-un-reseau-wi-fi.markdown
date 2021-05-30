---
layout: post
title: "Définir mot ordinateur portable comme passerelle entre un réseau câblé et un réseau Wi-Fi"
categories: jepensetouthaut informatique
# featured-image: 
# featured-source: 
summary: ""
---

# Problème
- J'ai un ordi fixe sans carte Wi-Fi.
- Je n'ai pas de câble assez long pour le connecter en filaire.
- J'ai un portable qui a Wi-Fi *et* RJ45
- J'ai une grosse envie de mieux comprendre le routage IP.

Bingo !

Pour situer : mon réseau Wi-Fi en 192.168.2.0/24 (.1 pour le routeur "BBox", .2 pour mon laptop)

# Solutions
En gros je mets un câble entre mon laptop et mon fixe, et je me dis "ça va être facile".

J'ai envisagé/testé plusieurs solutions.

## Le pilier commun
### Créer un réseau côté ethernet.

Ceci était ma première idée : mettre le laptop et le fixe en 192.168.3.0/24 (.1 pour mon laptop, .5 pour mon fixe)

Pour définir une ip fixe avec Ubuntu récent (post 17.04 me semble-t-il) il faut utiliser `netplan`. On peut aussi, pour faire des tests, utiliser `ip a add 192.168.3.x/24 dev eth0` (remplacer `x`, `24` et `eth0` pr les valeurs adéquates. `eth0` pourrait être `enp3s0` par exemple.)

Pris par la curiosité, je me suis demandé si mon laptop pouvait aussi jouer au serveur DHCP.
J'ai déjà dnsmasq installé, ça aurait dû être simple.
Sauf que j'ai aussi un `ufw` configuré avec les pieds, et que comme un imbécile je pensais que ça ne changerait rien... sauf que si.
Bref j'ai donc passé un peu de temps à comprendre ce qui se passait, et j'ai fini par désactiver `ufw` pour me simplifier la vie.

Cette première étape fonctionne : je peux faire un ping de l'un à l'autre et je peux établir une connexion TCP.

### ...et forwarder vers Wi-Fi

L'étape suivante est d'activer le forwarding du trafic : `net.ipv4.ip_forward=1` dans `/etc/sysctl.conf`, puis `sudo sysctl -p`.

Et là j'ai encore eu un moment WTF : ça ne marche pas.
Bien sûr `ufw` a un peu joué (je ne l'avais pas encore complètement désactivé, je l'ai fait à ce moment).
Mais surtout : quand je ping depuis le fixe, ça passe par le portable (`tracepath` confirmait) mais je n'avais pas de réponse ensuite !
En d'autres termes : les machines extérieures à mon laptop refusaient de revenir vers le laptop et donc vers le fixe.

La raison est vraisemblablement que mon routeur (la bbox) ne sait pas où se trouve le réseau 192.168.3.0/24. 
Il aurait fallu que je lui ajoute une route mais la bbox ne permet pas ce genre de chose.

## Variante 1 : le NAT
Dans cette variante, on va NATter un réseau privé (filaire : laptop + PC fixe) vers le reste du réseau WiFi.

Il faut donc faire intervenir iptables et un peu de NAT.
Et honnêtement je comprends pas complètement ce que je fais mais ceci semble marcher:

```
sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
sudo iptables -A FORWARD -i wlan0 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT 
sudo iptables -A FORWARD -i eth0 -o wlan0 -j ACCEPT
```

Source: https://www.revsys.com/writings/quicktips/nat.html
Autre source trouvée (mais pas testé) : https://www.cryptologie.net/article/99/nat-with-iptables-super-fast-tutorial/



## Variante 2 : Bridging + le relais DHCP
Dans cette variante, le laptop va relayer les requêtes DHCP depuis le réseau filaire vers le réseau WiFi. 
Le PC fixe va donc se retrouver avec une IP du réseau 192.168.2.0/24.

L'idée est d'utiliser un relai DHCP (dhcrelay du package `sudo apt install isc-dhcp-relay`) et `parprouted` pour bridger wlan0 avec eth0 sur le portable.

Source : https://serverfault.com/questions/273026/bridging-two-ethernet-networks-w-dhcp-over-wifi

Sauf que ça ne marche pas et j'ai un peu la flemme de trouver pourquoi. Je lâche l'affaire.





# Sources
Je me suis inspiré de :
- https://unix.stackexchange.com/questions/265389/routing-all-traffic-from-eth0-to-wlan0
- https://www.osradar.com/set-a-static-ip-address-ubuntu-20-04/
