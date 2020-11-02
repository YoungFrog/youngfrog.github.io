---
layout: post
title: "Export wordpress"
categories: informatique
last_modified_at: "2019-07-26 Fri 08:19"
---

Exporter mon blog *wordpress.com* était assez facile une fois trouvée l'URL adéquate
via une recherche Google : <https://wordpress.com/export/>

J'ai exporté/enregistré le résultat. En gros c'est un fichier XML contenant mes
posts (pas les images, mais je n'en avais jamais postées).

Je pourrais sans doute intégrer tout cela au présent blog, mais pour l'instant
le contenu est toujours disponible sur <https://youngfrog.wordpress.com/> et
j'ai la flemme.

À tout hasard je suis tombé sur un article qui parle d'une migration spécifique vers Jekyll, mais requiert un plugin wordpress (je ne sais pas s'il est installable sur wordpress.com) :
<https://blog.webjeda.com/wordpress-to-jekyll-migration/#how-to-migrate-from-wordpress-to-jekyll>

UPDATE {{ "2019-07-26 Fri 08:19" | date: "%Y/%m/%d" }} il y a un module d'importation du fichier XML qui
devrait rendre le processus assez simple :
<https://import.jekyllrb.com/docs/wordpressdotcom/>
