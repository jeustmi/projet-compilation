Projet de Théorie des Langages et Compilation
Loreau Maxime - Boeuf Léonard

Pour compiler, créer un dossier Build dans le dossier mère pour y exécuter "Cmake .." puis "make" qui devraient créer les fichiers necéssaires.
Pour exécuter le programme, exécuter la commande "./projet < <fichier.txt>" dans Build avec <fichier.txt> le fichier contenant le "code" reconnu par le programme.
Enfin, l'exécution du programme a créé dans le Build un fichier "page.html" contenant le code html résultant de la compilation du "code".

Différentes remarques :


Dans le sujet :
Les indices des sélécteurs (pour !T[i] par exemple) commencent à 0 dans la partie 1 du sujet et dans l'exemple 6-7, mais le visuel de l'exemple 5 les fait commencer à 1

Le code html de l'exemple 6 est eronné, c'est l'attribut "color" qui est censé être "#ff0000" et non pas "background-color"

Pour notre programme :
Nos indices de sélécteurs commencent effectivement à 0 pour conformer à la partie 1.

Nos Boucles IF et For ne marchent pas complètement et ne permettent pas d'atteindre le résultat attendu dans les exemples 6  et 7 respectivement.
Les boucles IF permenntent de reconnaître si la condition est vérifiée (un messsage dans la console le confirme) mais pas d'affecter des valeurs à des variables seulement dans certains cas.

Les boucles FOR ne marchent que lors de la création de blocs ("!T 'titre' i/25" par exemple) et ne peuvent avoir qu'une seule ligne, sans quoi le parser ne la reconnaît pas.
Pour tester nos FOR, vous pouvez exécuter "./projet" puis écrire dans la console
"
POUR i [0,255] +25 :
!T 'Titre ' i/25
FINI
"
qui donne le résultat attendu (on peut aussi créer des paragraphes et images)

