Projet de Théorie des Langages et Compilation
Loreau Maxime - Boeuf Léonard

Pour compiler, créer un dossier Build dans le dossier mère pour y exécuter "Cmake .." puis "make" qui devraient créer les fichiers necéssaires.
Pour exécuter le programme, exécuter la commande "./projet < <fichier.txt>" dans Build avec <fichier.txt> le fichier contenant le "code" reconnu par le programme.
Enfin, l'exécution du programme a créé dans le Build un fichier "page.html" contenant le code html résultant de la compilation du "code".

Différentes remarques :


Dans le sujet :
Les indices des sélécteurs (pour !T[i] par exemple) commencent à 0 dans la partie 1 du sujet et dans l'exemple 6-7, mais le visuel de l'exemple 5 les fait commencer à 1.

Dans l'exemple 2, on a la ligne "@DEFINE (icone) {'rick.ico'}" qui renvoie "<link rel="icon" type="image/jpg" href="./rickICO.jpg" />", bien que l'on n'ait aucune raison de modifier le nom du fichier.

Le code html de l'exemple 6 est eronné, c'est l'attribut "color" qui est censé être "#ff0000" et non pas "background-color".

Pour notre programme :
Le parser ainsi que certains des fichiers hh ont été commentés pour expliciter le raisonemment derrière nos décisions.

Nos indices de sélécteurs commencent effectivement à 0 pour conformer à la partie 1.

Nos Boucles IF et For ne marchent pas complètement et ne permettent pas d'atteindre le résultat attendu dans les exemples 6  et 7 respectivement.
Les boucles IF permettent de reconnaître si la condition est vérifiée (un messsage dans la console le confirme) mais l'affectation des variables a lieu indépendamment de la vérification de la condition.

Les boucles FOR ne marchent que lors de la création de blocs ("!T 'titre' i/25" par exemple) et ne peuvent avoir qu'une seule ligne, sans quoi le parser ne la reconnaît pas.
Pour tester nos FOR, vous pouvez par exemple exécuter "./projet" puis écrire dans la console:
"
POUR i [0,255] +25 :
!T 'Titre ' i/25
FINI
"
qui donne le résultat attendu (on peut aussi créer des paragraphes et images tant que ceux ci ne dépendent pas de i).
