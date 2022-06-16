---
layout: post
title: "Netbeans, maven, jansi et des bugs"
categories: informatique
# featured-image: 
# featured-source: 
summary: "Au fil du temps j'ai noté des bugs avec Netbeans... je les consigne ici"
---

# Acte 1 : les couleurs disparaissent

Premier bug remarqué il y a bien longtemps, les couleurs dans Netbeans (en affichant les code ANSI dans la console) ont disparu.


C'est `jansi` qui enlève les codes couleur, et c'est probablement lié au fait qu'il (jansi) ne détecte pas (pas bien?) la console Netbeans comme étant capable d'afficher les couleurs. 
(J'ai bien envie de rejeter la faute sur Netbeans.)

## Test case:
``` java
final String ANSI_RED = "\u001B[31m";
final String ANSI_RESET = "\u001B[0m";
System.out.print("Are we " + ANSI_RED + "colouring" + ANSI_RESET + " ?");
```


## Fix

Le fix est relativement simple et pourtant méconnu : virer `jansi`. Pour ce faire je fais simplement `chmod -r /path/to/netbeans/java/maven/lib/jansi*` et hop!

Sinon bien sûr, lancer hors de Netbeans:

``` bash
mvn "-Dexec.args=-classpath %classpath pack.age.MyClass" -Dexec.executable=java exec:exec
# ou alors
mvn -Dexec.mainClass=pack.age.MyClass exec:java
```


## Non-fix

Un idée qui revient est de définir `MAVEN_OPTS=-Djansi.passthrough=true` mais cela casse d'autres choses, telles que les liens dans les backtraces ou (de mémoire) les tests unitaires.

## Versions concernées

jansi a été intégré à Maven avec Maven 3.5.0 ; et ce Maven a été intégré à Netbeans avec Netbeans 12.2.
À ma connaissance le bug n'est pas résolu depuis.

## Ressources
- <https://issues.apache.org/jira/browse/MNG-6205?focusedCommentId=15956355&page=com.atlassian.jira.plugin.system.issuetabpanels:comment-tabpanel#comment-15956355> (j'ai réalisé le fix en lisant ceci)
- <https://stackoverflow.com/questions/26425981/colored-output-in-netbeans-console-with-ansicodes/51508523#51508523>
- <https://issues.apache.org/jira/browse/NETBEANS-3047> -- il faudrait transférer ce bug vers [github](https://github.com/apache/netbeans/issues/new)
- <https://issues.apache.org/jira/browse/MNG-6417>


<!-- Ressources internes:
https://groups.google.com/u/0/a/he2b.be/g/esi-dev2-list/c/Pzjiioj0_T8/m/4GlJ0AQFAwAJ
-->

# Acte 2 : Le "prompt" s'affiche après la réponse

## Test case:

``` java
System.out.println("The prompt should come... but it won't.");
System.out.print("Say something: ");
(new Scanner(System.in)).next();
```

## Fix 

Résolu dans Netbeans 14 !

Le fix est d'utiliser une version pas trop vieille de jansi (after 1.3.2 si j'ai bien compris).
Copier le fichier .jar devrait marcher.
Une autre option est de ne pas utiliser jansi du tout, comme dans le point précédent



## Ressources

- <https://mvnrepository.com/artifact/org.fusesource.jansi/jansi> -- le jar est dispo
- <https://github.com/fusesource/jansi/>
- <https://fusesource.github.io/jansi/download.html> -- je pense que ce sont les anciennes releases
- <https://github.com/mojohaus/exec-maven-plugin/issues/159>
- <https://github.com/mojohaus/exec-maven-plugin/issues/155>
- <https://github.com/mojohaus/exec-maven-plugin/issues/154>
- <https://issues.apache.org/jira/browse/NETBEANS-4453>
- <https://issues.apache.org/jira/browse/MNG-6239>

<!-- https://groups.google.com/u/0/a/he2b.be/g/esi-dev2-list/c/yOZlTi4qtyQ/m/zrbW_8T_AwAJ -->

# Acte 3 : Les caractères ne s'affichent pas tous (point d'interrogation)

Ici tout se passe comme si l'encodage était mauvais.

Exemple 𐐷 (DESERET SMALL LETTER YEE) ne s'affiche pas bien chez moi. Mais en fait même "é" ou "€" ne s'affichent pas bien.

Le problème n'apparait chez moi que avec Maven lancé sous Netbeans. Si je lance dans un terminal ou si j'utilise ant ou gradle, ça fonctionne.

## Test case:

``` java
do {
    int read = in.read();
    System.out.println("Byte: " + read);
} while (in.available() > 0);
```

Avec Maven sous Netbeans, un é (e accent aigu) va afficher:

```
Byte: 233
Byte: 10
```

Alors que hors Netbeans ça donnera :

```
Byte: 195
Byte: 169
Byte: 10
```

Si je teste avec 𐐷 (DESERET SMALL LETTER YEE), ça donne:

Avec Netbeans:

```
Byte: 1
Byte: 55
Byte: 10
```

Hors Netbeans:

```
Byte: 240
Byte: 144
Byte: 144
Byte: 183
Byte: 10
```

Hors Netbeans c'est l'encodage UTF8 utilisé.Sous Netbeans on dirait de l'UTF16, mais il manque un octet sur deux puisque DESERET SMALL LETTER YEE [s'encode avec 216 1 220 55 -- c'est-à-dire d8 01 dc 37](https://www.fileformat.info/info/unicode/char/10437/charset_support.htm) normalement.


## Fix

Ceci est corrigé avec Netbeans 14 !
