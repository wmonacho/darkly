## Phase 1 : Découverte de la faille

Il existe un cookie accessible I_am_admin qui semble indiquer au site si nous sommes bien un administrateur ou non. 

## Phase 2 : Exploitation de la faille

La valeur de ce cookie est fixee a false encrypte en md5 sans sel ce qui est une facon particulierement non securisee de stocker une information aussi importante.

En encryptant le mot true en md5 et en remplacant la valeur du cookie nous pouvons acceder au site en tant qu'admin et obtenir le flag :

df2eb4ba34ed059a1e3e89ff4dfc13445f104a1a52295214def1c4fb1693a5c3


## Phase 3 : Comment corriger la faille


Il ne faut jamais stocker de donnes sensibles dans les cookies sauf si ces dernieres sont protegees convenablement. 

Par exemple il est possible de stocker un token d'identification dans les cookies si ce dernier a des reglages strictes comme 
httpOnly->True (impossible d'y acceder grace a document.cookie) SameSite->strict (le cookie n'est jamais envoye a d'autre site ) et qu'il y a une verification forte sur le token (HS256, signature aleatoire forte) plutot qu'un algorithme de hashage faible comme md5.

