faille robots.txt root password


Dans l'autre dossier cache whatever nous trouvons un fichier qui contient un mot de passe encrypte en md5 avec comme login root.

Mais la combinaison ne fonctionne pas sur la partie login classique. En cherchant une page de connexion pour les admin nous trouvons la page /admin. 

En entrant la combinaison root + mot de passe decrypte on obtient le flag suivant :

d19b4823e0d5600ceed56d5e896ef328d7a2b9e7ac7e80f4fcdb9b10bcb3e7ff