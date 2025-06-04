## Phase 1 : Découverte de la faille

Il existe une page de recuperation de password par mail. 

le bouton submit envoie une requete post avec un element cache (le mail de recuperation).

## Phase 2 : Exploitation de la faille

Il est possible de changer ce mail de recuperation soit en modifiant la page html directement et en ayant acces au champ pour modifier le mail. Soit en envoyant une requete avec en argument un autre mail que le mail cache avec curl par exemple :

curl 'http://10.14.200.61/?page=recover#' --data 'mail=truc&Submit=Submit'

Dans tous les cas le site nous donne le flag suivant :

1d4855f7337c0c14b6f44946872c4eb33853f40b2d54393fbe94f49f1e19bbb0


## Phase 3 : Comment corriger la faille

Il est idiot de cacher des valeurs sensibles dans le code html en front avec juste un type hidden. 
L'email utilise ici devrait etre stocke et securise dans la databse et ne devrait etre accessible que par une personne identifie comme administrateur par exemple. 

Le fonctionnement de cette page est de tt maniere assez obscur, un systeme de recuperation de password devrait recuperer en entree une adresse mail, verifier le type de donne recuperer, chercher dans la database un utilisateur avec ce mail et lui envoyer sur son mail un lien pour reset son password si l'utilisateur current a ete verifie.




