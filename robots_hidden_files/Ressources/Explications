## Phase 1 : Découverte de la faille

Il existe une faille assez courante sur les applis peu securisees.

Il s'agit de profiter des informations contenu dans le fichier robots.txt. C'est un fichier contenu a la racine d'un site web qui contient des informations pour 
designer quels pages / fichiers dveraients etre ignores par les navigateur comme Google etc.

Ce fichier ets publique et donc accessible a tous.

En y jetant un coup d'oeil nous trouvons deux dossiers caches : whatever et .hidden

En fouillant .hidden nous trouvons un ensemble de dossiers imbriques contenant tous des readme. Et nous allons donc essayer de trouver le flag la dedans.

## Phase 2 : Exploitation de la faille

Afind e trouver le readme qui contient le flag on regarde le formnat des readme existants. Ils comportent tous uniquement des lettre set des espaces.
Si on peut trouver un readme avec des chiffres c'est probablement le flag.

Il suffit donc d'ecrire un scrip qui va fouiller tous les dossiers pour retrouver celui qui nous interesse.

## Phase 3 : Comment corriger la faille

Le fichier robots.txt ne doit pas etre considere comme une securite. 

Les pages sensibles d'un site doivent etre proteges par une authentification forte avec un login + mdp par exemple.

Plutot que d'utiliser robots.txt il est possible de cacher l'indexation des pages avec la balise meta

<meta name="robots" content="noindex">