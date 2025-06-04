## Phase 1 : Découverte de la faille

La page http://10.14.200.61/?page=media&src=nsa permet une attaque XSS reflechi.

Il est possible de modifier la variable src afin d'y injecter du code html malveillant qui sera renvoyer par le serveur et s'executer sur le site.

## Phase 2 : Exploitation de la faille

Il faut cependant demander au site d'executer la variable src comme du code html sinon nous sommes juste redirige vers un 404 Not Found

Pour cela il suffit d'utiliser le schema data et de preciser l'option text/html

On a donc l'url suivante : 

http://10.14.200.61/index.php?page=media&src=data:text/html,<script>alert('XSS')</script>

Qui de base montre une faibless par attaque XSS car une fenetre pop up a ete executee mais ne donne pas le flag 

Il faut donc trouver un moyen d'atteindre le flag, surement en evitant un parsing de src qui a identifie du code malveillant.

Pour cela il est possible d'encoder la partie script pour verifier si le parsing est vraiment efficace.
Impossible d'encoder en hexadecimal et d efaire fonctionner le lien.

On choisit donc d'encoder en base 64 et donc d'utiliser l'argument base64 dans l'URL et on obtient :

http://10.14.200.61/index.php?page=media&src=data:text/html;base64,PHNjcmlwdD5hbGVydCg0Mik8L3NjcmlwdD4=

En accedant a cette page on obtient le flag suivant :

928d819fc19405ae09921a2b71227bd9aba106f9d2d37ac412e9e5a750f1506d

## Phase 3 : Comment corriger la faille

Il y a peu de librairies pour se proteger d'une attaque xss camouflee en base 64. Une librairie comme jinja2 n'est pas suffisante en python par exemple car elle permet uniquement d'echappe les entree utilisateurs qui ne sont pas encode.

Il faut donc plutot prviliegier une Content security Policy stricte comme :

Content-Security-Policy: default-src 'self'; script-src 'self'; object-src 'none'; media-src 'self';

Il peut cependant aussi etre interessant d'utiliser bleach comme librairie pour nettoyer les input utilisateurs.










