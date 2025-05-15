La page http://10.14.200.61/?page=media&src=nsa permet une attaque XSS reflechi.

Il est possible de modifier la variable src afin d'y injecter du code html malveillant qui sera renvoyer par le serveur et s'executer sur le site.

Il faut cependant demander au site d'executer la variable src comme du code html sinon nous sommes juste redirige vers un 404 Not Found

Pour cela il suffit d'utiliser le schema data et de preciser l'option text/html

On a donc l'url suivante : 

http://10.14.200.61/index.php?page=media&src=data:text/html,<script>alert('XSS')</script>

Qui de base montre une faibless par attaque XSS car une fenetre pop up a ete executee mais ne donne pas le flag 

Il faut donc trouver un moyen d'atteindre le flag, surement en evitant un parsing de src qui a identifie du code malveillant.

Pour cela il est possible d'encoder la partie script pour verifier si le parsing est vraiment efficace.
Impossible d'encoder en hexadecimal et d efaire fonctionner le lien.

On choisit donc d'encoder en base 64 et donc d'utiliser l'argument base64 dans l'URL et on obtient :

http://10.14.200.61/index.php?page=media&src=data:text/html;base64,PHNjcmlwdD5hbGVydCg0Mik8L3NjcmlwdD4=







