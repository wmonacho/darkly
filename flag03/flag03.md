La page survey fonctionne avec des methodes post. 
Elle permet aux utilisateurs de voter et de donner une note sur differents sujets.

Il y a donc une methode post associee a cette page que l'on peut utiliser. La question est donc de savoir sur quoi l'utilisateur peut agir via cette methode post et si elle est protege.

En regardant le code source de la page, la methode post associee au survey prend deux arguments, le sujet et la valeur. Il est donc possible d'émettre une methode post avec ces arguments.

En utilisant curl on peut envoyer un POST a láide de la commande suivante :

curl 'http://10.14.200.61/index.php?page=survey' --data 'sujet=1&valeur=12'

Le site ne nous envoie pas d'erreur lie aux droits d'acces etc, il ets donc possible de modifier des informations du backend lie a d'autre sutilisateurs sans etre nous meme ces utilisateurs et sans etre meme connectes.

Ensuite en regardant la reponse en detail du curl on peut voir une modification du code source avec le flag qui apparait :

03a944b434d5baff05f46c4bede5792551a2595574bcafc9a6e25f67c382ccaa

Pour eviter ce genre de faiblesses :

Se servir d'un service d'authentification comme des tokens JWT, et utiliser / verifier l'identite de l'utilisateur.
Par exemple sur une demande de changement d'email, le chnagement devrait s'appliquer sur le current user et non sur un user specifie
par lútilisateur dans un json et le token de connexion de lútilisateur devrait être verifie.

