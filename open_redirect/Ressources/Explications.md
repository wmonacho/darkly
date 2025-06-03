## Phase 1 : Découverte de la faille

Il existe des redirections ouvertes sur le site, la redirection vers facebook, instagram ou X par exemple.

## Phase 2 : Exploitation de la faille

Telle qu'elle est montree sur le site, l'Open redirect n'est vraiment un probleme que dans certains cas tres specifiques
En effet la redirection se fait via un argument dans l'URL pour que le back nous renvoie vers facebook/instagram etc.

Cela aurait ete beaucoup plus problematique si le site nous redirigeait directement vers un url de la facon suivante :
10.14.200.61/index.php?page=redirect&url=https//site.com

Le site pourrait alors rediriger vers n'importe quel site potentiellement malveillant.

Cependant ce ne serait possible que dans des cas precis encore une fois.

Par exemple en utilisant burp et un logiciel malveillant en etant connecte sur le meme reseau qu'un autre utilisateur, il serait possible d'intercepter la requete Get de l'utilisateur qui souhaite aller sur Facebook, modifier sa requete pour changer l'url demandee pour que le backend renvoie a l'utilisateur une redirection vers un site malveillant.

Il serait aussi possible d'envoyer un lien vers notre site qui parrait honnete a un utilisateur par mail avec a la fin de l'URL une redirection via un argument de l'URL ce qui redirigerait l'Utilisateur vers un autre site malveillant. Ce qui est la methode la plus utilisee en terme d'Open Redirect.

En modifiant juste l'URL sur le site a la main nous obtenons le flag suivant :

b9e775a0291fed784a2d9680fcfad7edd6b8cdf87648da647aaf4bba288bcab3

## Phase 3 : Comment corriger la faille


La redirection est un outil tres utile, s'en priver n'est donc pas la solution a privilegier pour eviter ce genre de faiblesses. 

Il est par contre assez simple de faire de la verification des redirections dans notre application web. Par exemple verifier que le site vers lequel nous redirigeons notre utilisateur est dans une liste de site autorisee. Comme applique sur le site BornToSec finalement.

Ou encore eviter de concatener sans verifications directement les donnes utilisateurs vers une url de redirection.