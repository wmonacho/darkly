
En faisant quelques tests sur la page de recherche des membres nous avons pu identifier quíl y avait possiblement une faille liee a de l'injection sql. En effet en utilisant des caracteres speciaux ou meme en essayant de rentrer des commandes sql directement le site nous renvoit des erreurs de la base de donnees.

C'est un premier signe que le site est vulnerable aux injections sql.

Une comande classique a essayer dans ce cas est : ' OR '1'='1 qui permet d'ajouter des elements de recherche dans la partie where de la commande sql et donc d'afficher tous les utilisateurs.

Ici l'injection est un peu modifiee car la database est geree par MariaDb, 1 OR 1=1

On peut ensuite identifier la version du logiciel qui gere la database, ici Mariadb version 5.5.64. Ce qui nous permet d'identifier quelles sont les differentes fonctions que nous allons pouvoir utiliser dans nos requetes pour recuperer des informations importantes. Etant donne que nous sommes sur une version 5.x nous pouvons utiliser la vue information_schema.tables pour recuperer des informations importantes sur la database utilisee ici.

Nous pouvons recuperer le nom de la database grace a la fonction database().

Ensuite recuperer le nom de la table utilisee grace a : 1 union all select 1,group_concat(table_name) from Information_schema.tables where table_schema=database(). Ici le nom de la table est users


Et ensuite recuperer le nom des colonnes de cette table grace a :
1 union all select 1,group_concat(column_name) from Information_schema.columns where table_name=0x7573657273 (traduction de users en hexa)

Et ensuite recuperer le contenu des colonnes grace a :
1 union all select 1,group_concat(#Nom de la colonne) from users

Une des colonnes contient le mot de passe crypte de l'utilisateur, la colonne countersign. 

La colonne Commentaire contient des informations pour nous permettre de decoder ce mot de passe et trouver le flag.

Le mot de passe de l'utilisateur get the flag est crypte via la norme md5 qui est particulierement vulnerable si utilisee sans elements complementaires pour hasher des mots de passe. 

Nous allons donc sur un site de decryptage et nous rentrons le mdp suivant : 
5ff9d0165b4f92b14994e5c685cdce28

Une fois celui ci traduit et passe en lowercase nous obtenons fortytwo

et en le codant en SH256 nous obtenons le flag :

10a16d834f9b1e4068b25c4c46fe0284e99e44dceaf08098fc83925ba6310ff5


Solution pour eviter ce genre de faiblesses :

Ne jamais utiliser d'entree utilisateurs directement dans nos requetes sql.

Utiliser des requettes sql preparees. Par exemple sous python avec sqlite3 :
cursor.execute("SELECT * FROM users WHERE username = ?", (username,))

Faire de la validation de donnees dans le back :
Verifie que les donnes sont bien des int et uniquement des int pour un id par exemple. Ou des alphanumeriques pour des identifiants etc.

Fixer des regles strictes sur les noms d'utilisateurs etc afin de faciliter les la validation dans le back.

Choisir un meilleur mode de hachage pour les mots de passe. Il est preferable d'utiliser une librairie specialisee comme bcrypt. 





http://10.14.200.61/index.php?page=upload#
http://10.14.200.61/index.php?page=upload#