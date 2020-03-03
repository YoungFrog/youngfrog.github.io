---
layout: post
title: "Coronavirus - Estimation de 850 000 cas en Belgique \"si on en fait rien\""
categories: blog personnal
---

Il y a une estimation [de 850 000 cas en Belgique si on ne fait rien.](https://www.lalibre.be/debats/opinions/coronavirus-sans-mesures-de-precaution-drastiques-on-risque-d-avoir-850-000-personnes-infectees-et-50-000-morts-en-belgique-5e5cf60f9978e23106a0bfd9)

Cette estimation, parue dans La Libre du 2 mars 2020, me semble farfelue au niveau de la méthode.

Elle repose sur une estimation du /nombre de personnes infectées par une personne donnée/. 
Ce nombre, R_0, s'appelle le "taux de reproduction de base" ou "basic reproductive number" (d'après Wikipedia [^1]).
Il serait 2.2 pour le nouveau coronavirus, et 1.3 pour la grippe saisonnière.

Les 850000 sont alors obtenus à partir d'une simple règle de proportionnalité : 500000 * 2.2/1.3 = 850000.

Cela me semble farfelu

1. Vu la définition du taux, il sert sans doute de base à une exponentielle, et dans ce cas ça n'aurait aucun sens de multiplier 500000 par le rapport des taux.
2. Cela dit, un simple modèle exponentiel serait ridicule (une épidémie ne s'arrêterait jamais), donc d'autres modèles doivent exister. 
   Par contre je n'ai pas trouvé, après une recherche google naive, de formule explicite liant R_0 au nombre total de cas.
3. Il serait étonnant que le seul nombre R_0 soit pertinent pour calculer le nombre total de cas. D'après [^4] la grippe espagnole avait un R0 de 1.4 (ils font référence à [^5] qui le place plutôt entre 1.4 et 2.8 voire 3 selon les études!).
4. Comme signalé sur [^2], le "generation time" est un autre paramètre important, c'est-à-dire donne une indice de la durée de "contaminabilité".


[^1]: [https://fr.wikipedia.org/wiki/Mod%C3%A8les_compartimentaux_en_%C3%A9pid%C3%A9miologie#Taux_de_reproduction_de_base](https://fr.wikipedia.org/wiki/Mod%C3%A8les_compartimentaux_en_%C3%A9pid%C3%A9miologie#Taux_de_reproduction_de_base)
[^2]: [https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2717691/](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2717691/)
[^3]: [https://www.healthknowledge.org.uk/public-health-textbook/research-methods/1a-epidemiology/epidemic-theory](https://www.healthknowledge.org.uk/public-health-textbook/research-methods/1a-epidemiology/epidemic-theory)
[^4]: [https://www.healthline.com/health/r-nought-reproduction-number#rsubsubvalues](https://www.healthline.com/health/r-nought-reproduction-number#rsubsubvalues)
[^5]: [http://bmcmedicine.biomedcentral.com/article/10.1186/1741-7015-7-30](http://bmcmedicine.biomedcentral.com/article/10.1186/1741-7015-7-30)
