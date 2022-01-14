---
layout: post
title: "QR Code EPC pour initier un virement bancaire"
categories: informatique
# featured-image: 
# featured-source: 
summary: ""
---

Mon application banquaire permet de scanner une code QR pour initier un virement, c'est un [EPC QR Code](https://en.wikipedia.org/wiki/EPC_QR_code).

Un code QR, pour ce qui nous intéresse ici :

1. ça encode du texte (avec correction d'erreurs, au cas où le code est abîmé), 
2. il y a plusieurs tailles de code QR, et
3. il y a [plusieurs niveaux](https://en.wikipedia.org/wiki/QR_code#Error_correction) (Low, Medium, Quartile, High) de corrections des erreurs. 

Je ne connais pas les détails.

## QR Code EPC
La [définition des QR Code EPC](https://www.europeanpaymentscouncil.eu/sites/default/files/KB/files/EPC069-12%20v2.1%20Quick%20Response%20Code%20-%20Guidelines%20to%20Enable%20the%20Data%20Capture%20for%20the%20Initiation%20of%20a%20SCT.pdf) est relativement simple:
1. Niveau de correction : Medium, c'est-à-dire lisible jusqu'à 15% d'erreur.
2. Taille 13 au maximum.
3. Le texte encodé est une séquence de maximum 12 éléments (des lignes, séparées par LF ou CRLF), chacune encodant un morceau de l'information.

Les lignes en question sont:
1. Le service tag "BCD" : il faut écrire littéralement ces trois lettres.
2. Le numéro de version: "001" ou "002".
3. L'encodage : un chiffre de 1 à 8 (1 = UTF-8, 2 = ISO 8859-1, et d'autres)
4. Le code d'identification: "SCT" : littéralement ces trois lettres. SCT veut dire : SEPA Credit Transfer.
5. Le code BIC du bénéficiaire (obligatoire en version 001) ou une ligne vide (à condition de spécifier la version 002).
6. Nom du bénéficiaire (max 70 caractères)
7. Le code IBAN du bénéficiaire 
8. (optionnel) Montant précédé des lettres EUR. Par exemple EUR42.2
9. (optionnel) Raison du transfert[^1] -- un code de max 4 caractères
10. (optionnel) Communication structuée (vide si 11 est utilisé) ; a priori au format [ISO 11649 RF](https://en.wikipedia.org/wiki/Creditor_Reference) mais en Belgique typiquement au format [OGM-CVS](https://nl.wikipedia.org/wiki/Gestructureerde_mededeling). Il y a du flou pour moi.[^2]
11. (optionnel) Communication libre (vide si 10 est utilisé)
12. (optionnel) "Beneficiary to originator information" (iiuc: une sorte de communication, utilisable par le débiteur ; alors que la communication classique est à destination du créancier.)


Voici un exemple (modifié d'un exemple donné sur Wikipedia : je l'ai passé en version 002, enlevé le BIC et modifié pour mettre une communication structurée fantaisiste)
```
BCD
002
1
SCT

Red Cross of Belgium
BE72000000001616
EUR1

+++000/0000/00097+++
```

On peut en faire un QR code avec [qrencode](https://fukuchi.org/works/qrencode/index.html.en). 
Pour le fun voilà pour copier-coller (la première ligne sert à évincer les commentaires, compiler dans qrencode et afficher le résultat) :
``` sh
sed -E 's/ +#.*//' <<EOF | qrencode -l M -o - | display -
BCD                     # 1. service tag (fixé)
002                     # 2. numéro de version
1                       # 3. encodage UTF8
SCT                     # 4. code d'identification (fixé)
                        # 5. BIC (optionnel car version 002)
Red Cross of Belgium    # 6. nom du bénéficiaire
BE72000000001616        # 7. IBAN
EUR1                    # 8. Montant
                        # 9. Purpose
+++000/0000/00097+++    # 10. Communication structurée
EOF
```

ce qui donne le QR code suivant :

![QR code for donating 1€ to Red Cross of Belgium](/pics/donate-to-red-cross.png)

à scanner depuis une application banquaire (testé avec Easy Banking de BNP Paribas/Fortis).



## Sources 
- <https://fr.community.bnpparibasfortis.be/easy-banking-47/epc-qr-code-sur-iphone-5736> -- où j'ai trouvé un début d'information concerné les communications structurées
- <https://en.wikipedia.org/wiki/Creditor_Reference>
- <https://en.wikipedia.org/wiki/EPC_QR_code>
- <https://www.npmjs.com/package/belgian-vcs-ogm> pour travailler avec les communications structurées à la Belge
- <https://www.febelfin.be/fr/dossiers/conditions-pour-proposer-des-virements>

[^1]: Le [SEPA Rulebook](https://www.europeanpaymentscouncil.eu/document-library/rulebooks/2021-sepa-credit-transfer-rulebook-version-11) mentionne des valeurs ISO, que je ne parviens pas à trouver. J'imagine que c'est lié à ISO 20022.

[^2]: Dans <https://www.febelfin.be/fr/dossiers/conditions-pour-proposer-des-virements> il est uniquement question du format ISO (RF suivi du nombre de contrôle suivi de caractères). Sauf qu'en pratique les communications structurées en Belgique n'ont pas ce format, mais ressemblent à +++000/0000/00000+++ ("le format OGM-CVS"). Dans le document <https://www.febelfin.be/sites/default/files/2019-04/message_xml_pour_lordre_de_virement_-_version_3.3.pdf> page 70 il est appelé type "BBA" (par opposition à "ISO").
