---
layout: post
title: "Quelques pensées conc. OpenStreetMaps"
categories: informatique
# featured-image: 
# featured-source: 
summary: ""
---

J'ai récemment modifié OSM pour ajouter le [vélociste](https://www.facebook.com/profile.php?id=100063521711970)
chez qui j'ai été récemment, et qui ne semblait pas indiqué sur OSM. C'était probablement une de mes premières modifs. 
Une petite.
Minuscule, même.
Mais c'est pas la taille qui compte !

## Comment ça marche, OSM ?

Je voudrais retenir que OpenStreetMaps c'est une carte (au sens commun du terme : une image avec des routes, le nom des villes, etc.) appelée "fond de carte" ("tile layer") avec potentiellement des couches (layers) d'informations par dessus.

Il y a [plusieurs fonds de carte](https://wiki.openstreetmap.org/wiki/Featured_tile_layers) (comme la [couche Standard](https://wiki.openstreetmap.org/wiki/Standard_tile_layer), la couche CyclOSM, et d'autres), chacune composée de tuiles (petite images individuelles, couvrant une zone plus ou moins grande selon le niveau de zoom), générée à partir de deux sources de données :
- de données cartographiques : c'est la base de donnée OpenStreetMap proprement dite, 
- et d'un style (p.ex. [OSM-carto](https://github.com/gravitystorm/openstreetmap-carto), le style de la couche Standard).

La génération de ces tuiles fait intervenir d'autres logiciels, tels que Mapnik.

Il y a aussi du Javascript pour l'interface utilisateur, permettant de manipuler la vue de le fond de carte (déplacement, zoom). Une telle librairie JS est [Leaflet](https://leafletjs.com/reference.html) (qui d'ailleurs semble utilisé sur <https://osm.org>, si je comprends bien).

## Créer une carte sur son propre site

Documenté sur <https://wiki.openstreetmap.org/wiki/Deploying_your_own_Slippy_Map>

## Contribuer à OSM

Voir <https://wiki.openstreetmap.org/wiki/FR:Guide_du_d%C3%A9butant>
