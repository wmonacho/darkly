## Phase 1 : Découverte de la faille

Dans l'autre dossier cache whatever nous trouvons un fichier qui contient un mot de passe encrypte en md5 avec comme login root.

## Phase 2 : Exploitation de la faille

Mais la combinaison ne fonctionne pas sur la partie login classique. En cherchant une page de connexion pour les admin nous trouvons la page /admin. 

En entrant la combinaison root + mot de passe decrypte on obtient le flag suivant :

d19b4823e0d5600ceed56d5e896ef328d7a2b9e7ac7e80f4fcdb9b10bcb3e7ff

## Phase 3 : Comment corriger la faille

Meme explication que la faille robots.txt hidden files.

De plus les codes admin ne devraient jamais etre conserves en dur sur le serveur sans protection particuliere.

Ce mot de passe devrait etre encrypte de facon plus securisee et ne devrait pas etre laisse sur un fichier accessible par un service web.

Il est preferable d'utilise des variables d'environnements securisees ou utiliser un logiciel de gestion et de chiffrement de mot de passe comme hashiCorp Vault.








