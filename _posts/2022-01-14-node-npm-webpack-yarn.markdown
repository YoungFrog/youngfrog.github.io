---
layout: post
title: "Node, NPM, webpack, Yarn"
categories: informatique
# featured-image: 
# featured-source: 
summary: ""
---
Je suis haine

Je suis douleur

Je suis rancune

Je suis fureur

Je suis exécration

Bref.

Dans le monde du développement JavaScript, on ne peut plus passer à côté d'outils tels que Node ou npm :
- On va par exemple installer une dépendance avec npm.
- On va exécuter du code en ligne de commande avec node.
- On va préparer du code pour être utilisé sur le Web via webpack.

Et tout cela se configure par un même fichier, `package.json` qui définit à la fois le nom du projet, sa version, ses dépendances, la manière de le compiler ("tranpsiler"), mais aussi la structure générale du code (module ESM ou module CommonJS), les outils de linting, etc.
Et de nombreuses choses sont faites dans cet unique fichier `package.json`, qui sera donc lu par de nombreux outils différents

Et c'est là que je suis colère !

Parce que du coup quand on veut écrire un package.json et qu'on n'y connait rien, on donc consulter :
- <https://nodejs.org/api/packages.html#nodejs-packagejson-field-definitions> pour tout ce qui est lié à la façon d'interpréter le code en ligne de commande via Node, et notamment les inclusions des différents modules.
- <https://docs.npmjs.com/cli/v8/configuring-npm/package-json> pour tout ce qui est lié à la configuration du projet (soit ses dépendances propres, soit la manière dont il sera vu comme dépendance par d'autres projets -- c'est clair cette phrase?)
- <https://webpack.js.org/guides/package-exports/> pour la configuration de webpack, notamment la façon dont les modules s'incluent les uns les autres en vue d'être utilisé dans un navigateur

C'est un bocson dans ma tête et à chaque fois je me fais avoir ! En bref, quand je fais un "import" je dois me poser deux questions :
- d'où vient ce que j'importe (une dépendance explicite npm, ou un paquet offert par node ou par webpack ?), et
- comment j'y accède : accès direct via un chemin relatif (avec ou sans extension ? typescript ou javascript ?) ou via un identificateur de module npm

Sans compter que certaines dépendances sont proposées au format CommonJs

Les erreurs peuvent donc venir de : node, webpack, mais aussi typescript, eslint, ou même simplement mon éditeur de code qui décide qu'il a rien compris.

Rien de toute ceci n'a beaucoup de sens, mais peut être je clarifierai plus tard. Un jour. Quand j'aurais compris quelque chose.
