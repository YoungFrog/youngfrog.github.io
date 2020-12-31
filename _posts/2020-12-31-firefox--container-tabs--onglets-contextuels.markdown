---
layout: post
title: "Firefox : container tabs / onglets contextuels"
categories: informatique
summary: "Les onglets contextuels (container tabs) sont cool."
---

## Contexte

J'avais installé il y a longtemps [Facebook Container](https://addons.mozilla.org/fr/firefox/addon/facebook-container), qui permet de cloisonner Facebook par rapport au reste.

Ceci implique d'avoir activé une fonctionnalité : les **onglets contextuels**. Facebook vit alors dans son propre "contexte", et il a donc moins l'occasion de m'espionner quand je surfe sur d'autres sites. (En particulier les boutons "Like" ou "Share on Facebook" ne fonctionnent plus mais c'est une fonctionnalité, pas un bug.)

Il existe également d'autres contextes par défaut, mais rien n'oblige à les utiliser (les onglets sans contexte partagent un contexte commun), et on peut en créer d'autres.
J'en utilise actuellement trois :
- perso,
- pro, et
- facebook.

J'aime bien ; c'est un peu entre la *navigation privée* (transiente) et les *profils multiples* (cloisonnement très strict, notamment pas de partage au niveau des mots de passe).

Cela permet notamment que quand je me connecte à gmail dans le contexte Pro, ça ouvre mon compte gmail "pro".
Gmail, sinon, gère les identités multiples (notamment via le paramètre d'URL `authuser`), mais c'est facile de se mélanger les pinceaux. 
Par exemple, si on ouvre un lien vers "Google Drive", il est possible que le authuser soit incorrect, et alors il faut intervenir manuellement et/ou changer explicitement de compte[^2]. Moins de souci avec les contextes : il suffit d'ouvrir l'URL dans le bon contexte, et dans ce contexte n'être connnecté qu'à un seul compte Gmail.

## Mes soucis et mes solutions

Je n'ai pas vu de raccourci clavier pour ouvrir facilement une url dans un contexte spécifique. (J'ai bien un menu "Fichier -> Nouvel onglet contextuel".)

⇒ J'ai installé [Multi-Account Containers](https://addons.mozilla.org/firefox/addon/multi-account-containers/) qui offre des raccourcis (par défaut `C-M-1`, `C-M-2`, etc.) pour ouvrir un onglet dans un contexte spécifique.

J'espérais également que tout soit contextualisé : je n'ai plus envie d'ouvrir
un lien sans avoir choisi un contexte au préalable. Il y a bien une option
"Sélectionner un contexte pour chaque nouvel onglet" (en anglais : "Select a
container for each new tab") mais

1. ce n'est pas une obligation (on peut toujours choisir "sans contexte"),
2. l'effet est visible en cliquant sur '+' pour créer un nouvel onglet, mais le raccourci `C-t` n'est pas affecté par ce paramètre (c'est un bug, [d'après moi et d'autres](https://github.com/mozilla/multi-account-containers/issues/462))

⇒ On peut utiliser un addon comme <https://addons.mozilla.org/fr/firefox/addon/always-in-container/>

⇒ Plus complexe, l'addon [conex](https://addons.mozilla.org/en-US/firefox/addon/conex/) s'arrange notamment pour que `C-t` ouvre dans le contexte courant.

## Documentation

J'ai trouvé de la documentation[^1]
([fr](https://support.mozilla.org/fr/kb/onglets-contextuels-avec-les-containers),
[en](https://support.mozilla.org/en-US/kb/containers)) et elle fait référence à l'addon [Multi-Account
Containers](https://addons.mozilla.org/firefox/addon/multi-account-containers/).

[^1]: Le fait que "Container tabs" soit traduit en "Onglets contextuels" n'aide
    pas à trouver de la doc en anglais quand on a Firefox en français. (Chercher
    "Contextual tabs" n'aide absolument pas.) D'habitude je m'en sors en allant
    sur la page en français puis en changeant la langue vers l'anglais, mais ici
    ça donne une 404.

La raison pour cela est que le contexte est dans le cœur de Firefox, mais les
fonctionnalités user-firendly sont disponibles via diverses extensions, dont
celle-là (voir
<https://blog.mozilla.org/tanvi/2017/10/03/update-firefox-containers/>)

On trouvera aussi des infos sur [le wiki
Mozilla](https://wiki.mozilla.org/Security/Contextual_Identity_Project/Containers).

## Les raccourcis dans Firefox

(Cette section n'est pas vraiment spécifique aux contextes, et mériterait probablement un post à part entière.)

Les raccourcis dans FF, quelle misère ! 

- Il y a souvent des raccourcis d'extensions qui ne marchent pas parce qu'ils
  sont déjà utilisés par Firefox (que j'ai en français, donc les menus sont
  accessibles via des raccourcis différents de la version anglaise).
  Heureusement les raccourcis d'extensions sont modifiables via `C-S-a` puis,
  dans l'engrenage en haut à droite, « Gérer les raccourcis d'extension ».
- Multi-Account Containers utilise `C-.` par défaut pour ouvrir son menu, sauf
  que ça ne marche pas pour moi. Je ne sais pas si c'est parce que j'utilise une
  disposition Azerty (le point s'obtient en pressant `S-;`) ou si c'est lié au
  fait que mon FF est en français, ou peut-être que c'est un raccourci réservé ?
- Si je modifie ce raccourci pour mettre `C-.` (= `C-S-;`), Firefox pense que
  j'appuie sur `Ctrl+Maj+Comma`... sauf que du coup, je dois vraiment appuyer
  sur `C-S-,` pour que ça marche ! 
  
  Je répète : j'appuie une combinaison de
  touche pour définir le raccourci, mais cette même combinaison n'est pas
  reconnue pour déclencher le raccourci !

[GNU Emacs](https://www.gnu.org/software/emacs/) possède notamment une fonctionnalité qui me manque terriblement dans la plupart des logiciels que j'utilise, y compris Firefox et Gnome : c'est la possibilité de [décrire n'importe quel raccourci](https://www.gnu.org/software/emacs/manual/html_node/emacs/Key-Help.html#Key-Help). Cela fonctionne très simplement : j'appuie sur `C-h k` (press ctrl, press h, release both, press k, release k), puis je tape un raccourci clavier, ou je clique sur un menu ou sur un bouton et BIM! je sais quelle fonction est appelée et ce que ça fait !

[^2]: Certaines applications Google ne permettent pas de changer explicitement
    de compte, comme par exemple le partage de calendrier.
