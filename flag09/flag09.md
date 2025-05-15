La page : http://10.14.200.61/?page=b7e44c7a40c5f80139f0a50f3650fb2bd8d00b0d24667c4c2ca32c88e13b758f 
est vulnerable car elle permet un acces specifique a des informations si nous venons du site de la nsa et que nous utilisons un browser specifique

Toutes ces informations se retrouvent dans le header de nos requetes http mais sont tres facilement modifiables par exemple grace a burp suite.

Une fois le Referer et le User agent modifie, on recupere le flag :

f2a29020ef3132e01dd61df97fd33ec8d7fcd1388cc9601e7db691d17d4d6188

Solutions :

Il n'est pas envisageable de faire confiance a des donnes utilisateurs modifiables pour donner acces a des informations sensibles sur une appli web. 

Il est aussi conseille de proteger des informations tel que le referer et le user agent pour eviter des fuites d' informations de notre site.

Pour le referer :

Utiliser l'en tete Referrer-Policy: no-referrer ou Referrer-Policy: strict-origin-when-cross-origin dans les reponses http cote serveur afin de ne pas fuiter d'informations

Pour le user agent :

Ne pas se fier au User agent quoiqu'il arrive et ne pas l'enregistrer car il peut contenir du code malveillant.