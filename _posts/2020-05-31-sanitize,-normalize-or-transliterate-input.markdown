---
layout: post
title: "sanitize, normalize or transliterate input"
categories: informatique
# featured-image: 
# featured-source: 
summary: "Parfois j'ai des accents, mais je n'en veux pas (nom de fichiers, etc.)"
---
L'idée de base : si je crée un fichier parlant de "Émile Brön", j'ai probablement envie de l'appeler "fichier-pour-emile-bron.pdf" plutôt que "fichier pour Émile Brön.pdf"

# Pour supprimer les accents d'une chaîne de caractères

* Avec GNU Emacs : le paquet [unidecode](https://github.com/sindikat/unidecode/) propose des fonctions `unidecode` et `unidecode-sanitize`. C'est une version Emacs du paquet Python ci-dessous.

```
emacs --batch -f package-initialize -l unidecode --eval '(princ (unidecode "Fichier pour Émile Brön.pdf"))' 2>/dev/null
```

(Notons que la variante avec `unidecode-sanitize` donnerait `fichier-pour-emile-bronpdf`.)

* Avec Python : un module <http://pypi.python.org/pypi/Unidecode/> à installer via `pip install unidecode`

```
unidecode <<<"Fichier pour Émile Brön.pdf"
```

* Avec konwert : c'est un programme CLI de conversion. Par exemple:

```
konwert UTF8-ascii<<<"fichier pour Émile Brön.pdf"
```

* Avec iconv : programme CLI bien connu, qui connait des filtres. Par exemple:

```
iconv -t ascii//TRANSLIT <<<"fichier pour Émile Brön.pdf"
```

Source pour certaines solutions: <https://unix.stackexchange.com/questions/171832/converting-a-utf-8-file-to-ascii-best-effort>

# Pour passer en bas de casse et placer des tirets

Après la première étape, on se retrouve avec la chaîne `Fichier pour Emile Bron.pdf`. Reste à normaliser tout ça.


```
<<<"Fichier pour Emile Bron.pdf" tr [:upper:] [:lower:] | tr -c "[:alnum:]\n." "-"
```

Le second `tr` transforme en tiret tout ce qui n'est pas une lettre, un nombre, un point ou un retour à la ligne. Le retour à la ligne tout simplement parce que `<<<"whatever" cat` affiche un retour à la ligne final.


# Pour assainir des noms de fichiers existants

Le programme `detox` permet de renommer automatiquement des fichiers. Il s'installe
via APT. Un appel tel que `detox *` renommera tous les fichiers du répertoire courant.
