---
layout: post
title: "Custom domain / Domaine personnalisé vers Github pages"
categories: informatique
summary: "Comment ai-je défini un domaine personnalisé qui pointe vers mon site (publié au travers de Github pages)."
---
Mes écrits sont désormais disponibles depuis [youngfrog.lavnir.be](https://youngfrog.lavnir.be) au lieu de [youngfrog.github.io](https://youngfrog.github.io). J'explique comment j'ai fait : c'est très simple, et ça coûte précisément le prix du nom de domaine.

Dans mon cas le nom de domaine est `lavnir.be`  (mélange un peu subtile des initiales de ma moitié et de la sienne), il coûte quelques euros par an (le prix dépend essentiellement du TLD ; dans mon cas c'est `be` et ça revient à 8.46€ par an.)

Alors, la recette ?! Voilà :

1. Ajouter une entrée CNAME pointant le sous-domaine `youngfrog.lavnir.be` vers `youngfrog.github.io.` (avec point final) ; ceci s'est fait via l'[interface OVH](https://docs.ovh.com/fr/domains/editer-ma-zone-dns/) -- parce que j'ai acheté mon nom de domaine chez eux et que j'en laisse la gestion sur leurs serveurs.
2. Ajouter un fichier CNAME à la racine de mon dépôt, dont le contenu est précisément `youngfrog.github.io` (sans point final) ; ceci s'est fait via l'[interface de Github](https://help.github.com/en/github/working-with-github-pages/managing-a-custom-domain-for-your-github-pages-site#configuring-a-subdomain). Cela crée un commit qu'il faut intégrer à mon dépôt local.
3. Comme j'utilise Jekyll : modifier la configuration de [Jekyll](http://jekyllrb.com/), à savoir modifier l'élément `url` dans `_config.yml` pour refléter le nouveau domaine.
