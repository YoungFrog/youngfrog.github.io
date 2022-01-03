---
layout: post
title: "Javascript modules as node package"
categories: informatique
# featured-image: 
# featured-source: 
summary: ""
---

Mon but: créer un package npm ré-utilisable en interne, avec des définitions typescript. Les packages npm sont généralement des modules (qu'on peut `require` ou `import` depuis javascript). C'est ce que je veux faire ici et je documente l'état de ma réflexion.

## Modules: ESM versus CommonJS

Il y a deux types de modules :

- [CommonJS](https://nodejs.org/api/modules.html#modules-commonjs-modules) (avec `require` et des `module.exports`) et
- [ECMAScript modules -- ESM](https://nodejs.org/api/esm.html#modules-ecmascript-modules) (avec `import` et des `export`).

Pour la rétro compatibilité, par défaut, NodeJS considère que les fichiers sont des modules CommonJS.

N'y connaissant rien, j'ai pris le [premier site
venu](https://60devs.com/guides/publishing-a-typescript-module-to-npm.html) qui
explique comment publier un module typescript vers npm. Par contre ça publie en
CommonJS et moi je voulais du ESM que je trouve plus propre, et qui est l'avenir
des modules en javascript (c'est dans le standard !). Pour y parvenir il faut :

- préciser cela au compilateur typescript
- annoncer cela à NodeJS

Pour typescript : il va transpiler différemment en fonction des options de compilation, notamment [module](https://www.typescriptlang.org/tsconfig#module) et [target](https://www.typescriptlang.org/tsconfig#target). J'ai positionné les deux à `"ES6"`.

Pour NodeJS, il suffit de le préciser dans `package.json` : `"type": "module",` (c'est-à-dire ESM). Il faut aussi que le fichier javascript "appelant" soit un ESM, soit via une déclaration de type, soit via une extension `.mjs` (voir [ECMAScript modules -- ESM](https://nodejs.org/api/esm.html#modules-ecmascript-modules) déjà mentionné plus haut.)

## Publier

Un package NPM c'est souvent quelque chose publié sur la NPM registry, mais ça peut être d'autres choses ([documentation](https://docs.npmjs.com/about-packages-and-modules)).

Par exemple on peut simplement faire un dépôt git contenant le package. On peut aussi créer un package sous forme de tarball, par exemple via [`npm pack`](https://docs.npmjs.com/cli/v8/commands/npm-pack).

On peut définir des scripts qui vont être [lancés automatiquement quand on "pack" ou "publish"](https://docs.npmjs.com/cli/v8/using-npm/scripts) -- j'imagine que l'option "faire un dépôt git" est donc bof si on veut utiliser ces scripts.


## Sources
- <https://60devs.com/guides/publishing-a-typescript-module-to-npm.html> -- le guide que j'ai utilisé mais qui utilise commonjs
- <https://www.typescriptlang.org/docs/handbook/declaration-files/publishing.html> -- documentation typescript pour publier un module npm
- <https://devblogs.microsoft.com/typescript/announcing-typescript-4-5-beta/#esm-nodejs> -- annonce du support des ESM à partir de typescript 4.5
