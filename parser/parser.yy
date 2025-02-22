%skeleton "lalr1.cc"
%require "3.0"

%defines
%define api.parser.class { Parser }
%define api.value.type variant
%define parse.assert

%locations

%code requires{
    #include "contexte.hh"
    #include "text.hh"
    #include "commentaire.hh"
    #include "programme.hh"

    #include "variables/constante.hh"
    #include "variables/variable.hh"

    class Scanner;
    class Driver;
    class Programme;
}

%parse-param { Scanner &scanner }
%parse-param { Driver &driver }
%parse-param { Programme &prog }

%code{
    #include <iostream>
    #include <string>
    
    #include "scanner.hh"
    #include "driver.hh"

    #undef  yylex
    #define yylex scanner.yylex
}

%token                  NL
%token <int>            NUMBER
%token <int>            TITRE
%token                  PARAGRAPH
%token                  IMAGE
%token                  DEFINITION
%token                  TITREPAGE
%token                  STYLE
%token <std::string>    COMMENTAIRE
%token                  ENCODAGE
%token                  ICON
%token                  CSS
%token                  LANG
%token                  PAGE
%token                  PARA
%token                  IF
%token                  ENDIF
%token                  ELSE
%token                  TRUE
%token                  FALSE
%token                  FOR
%token                  END
%token <std::string>    ID
%token <int>            TITR
%token <std::string>    TEXT
%token <std::string>    HEXANUMBER
%token                  RGB
%token                  VAR_STYLE
%token                  WIDTH
%token                  HEIGHT
%token                  TEXTCOLOR
%token                  BACKGROUNDCOLOR
%token                  OPACITY



%type <std::shared_ptr<Attribut>> identifiant_int
%type <std::shared_ptr<Attribut>> identifiant_couleur
%type <std::shared_ptr<Bloc>> identifiant_style

%type <std::shared_ptr<Expression<int>>> valeur_int
%type <std::shared_ptr<Expression<std::string>>> valeur_couleur
%type <std::shared_ptr<Expression<std::vector<std::shared_ptr<Attribut>>>>> valeur_style
%type <std::shared_ptr<Bloc>> valeur_bloc

%type <int> taille
%type <int> ratio
%type <std::string> couleur
%type <int> selecteur

%type <std::vector<std::shared_ptr<Attribut>>>  attributs_nl
%type <std::vector<std::shared_ptr<Attribut>>>  attributs_virgules
%type <std::shared_ptr<Attribut>> attribut

%type <std::shared_ptr<Bloc>> bloc
%type <int> operation_for

%type <objet> objet

%type <bool> condition
%type <int> int_comp
%type <std::string> couleur_comp
%type <std::vector<std::shared_ptr<Attribut>>> style_comp
%type <bool> booleen
%type <std::string> code_else


%type <std::string> commentaire
%type <std::string> texte

%left '-' '+'
%left '*' '/'

%%

//----------------------------------------------------------------------------------------------------------------
//Reconnaissance du langage :

programme:
    code{
        YYACCEPT;
    }

code:
    instruction NL code
    | NL code
    | instruction
    | instruction NL

instruction:
    affectation
    |bloc{
        prog.addBloc($1);
    }
    |conditionelle
    |boucle
    |meta_donnees
    |commentaire{
        prog.addComm($1);
    }


//----------------------------------------------------------------------------------------------------------------
// Affectation

affectation:
    ID  '=' valeur_int{ // Pour stocker des entiers, on a les classes Constante<int> et Variable<int> qui contiennent un entier et une chaîne de caractères qui représente le type ("px" ou "%")
        try { 
            int val = $3->calculer(driver.getContexteint());
            driver.setVariableint($1, val); // Par défaut pour les variables, on ne stocke que l'entier (et on rajoute arbitrairement "px" lorsque c'est nécessaire)
        } catch(const std::exception& err) {
            std::cerr << "#!-> " << err.what() << std::endl;
        }
    }
    |identifiant_int '=' valeur_int{
        try {
            std::string val = std::to_string($3->calculer(driver.getContexteint()))+$3->getSuffixe(driver.getContexteint()); // Ici, val est un string (std::string(1000px) par exemple) car identifiant_int ne peut être qu'un identifiant d'attribut, qui nécessite donc une chaîne 
            $1->setVal(val);
        } catch(const std::exception& err) {
            std::cerr << "#!-> " << err.what() << std::endl;
        }
    }
    |ID '=' valeur_couleur{
        try { // Lorsqu'on tente d'affecter une variable à une autre, on ne peut pas savoir à priori de quel type est la variable à droite, ce qui amène le parser à choisir arbitrairement une règle, et donc un contexte, à utiliser, ce qui amène la plupart du temps à une erreur
            std::string val = $3->calculer(driver.getContextecouleur()); 
            driver.setVariablecouleur($1, val);
        } catch(const std::exception& err) {
            std::cerr << "#!-> " << err.what() << std::endl;
        }
    }
    |identifiant_couleur '=' valeur_couleur{
        try {
            std::string val = $3->calculer(driver.getContextecouleur());
            $1->setVal(val);
        } catch(const std::exception& err) {
            std::cerr << "#!-> " << err.what() << std::endl;
        }
    }
    |ID '=' valeur_style{
        try {
            std::vector<std::shared_ptr<Attribut>> val = $3->calculer(driver.getContextestyle());
            driver.setVariablestyle($1, val);
        } catch(const std::exception& err) {
            std::cerr << "#!-> " << err.what() << std::endl;
        }
    }
    |identifiant_style '=' valeur_style{
        try {
            std::vector<std::shared_ptr<Attribut>> val = $3->calculer(driver.getContextestyle()); 
            $1->setAttributs(val);
        } catch(const std::exception& err) {
            std::cerr << "#!-> " << err.what() << std::endl;
        }
    }
    |ID '=' valeur_bloc{
        try{
            driver.setVariablebloc($1, $3); 
        } catch(const std::exception& err) {
            std::cerr << "#!-> " << err.what() << std::endl;
        }
    }

//Types de Données :

// Int
identifiant_int:
    valeur_bloc '.' HEIGHT{ // Grâce au CSS, ajouter un nouvel attribut ou changer la valeur du dernier de ceux-là ne change rien au résultat, on a donc ces deux implémentation en utilisant la plus pratique à chaque instant
        std::shared_ptr<Hauteur> h(std::make_shared<Hauteur>());
        for(auto a : $1->getAttributs()){
            if(a->type()=="height"){
                h=std::dynamic_pointer_cast<Hauteur>(a);
            }
        }
        if(h->getVal()==""){
            $1->addAttribut(h); // En l'occurrence, on ajoute un nouvel attribut s'il n'existe pas
        }
        $$=h; // Sinon on renvoie le dernier de ceux-ci pour que "affectation" puisse changer sa valeur
    }
    |valeur_bloc '.' WIDTH{
        std::shared_ptr<Largeur> l(std::make_shared<Largeur>());
        for(auto a : $1->getAttributs()){
            if(a->type()=="width"){
                l=std::dynamic_pointer_cast<Largeur>(a);
            }
        }
        if(l->getVal()==""){
            $1->addAttribut(l);
        }
        $$=l;
    }
    |valeur_bloc '.' OPACITY{
        std::shared_ptr<Opacite> o(std::make_shared<Opacite>());
        for(auto a : $1->getAttributs()){
            if(a->type()=="opacity"){
                o=std::dynamic_pointer_cast<Opacite>(a);
            }
        }
        if(o->getVal()==""){
            $1->addAttribut(o);
        }
        $$=o;
    }
    |ID '.' HEIGHT{
        std::shared_ptr<Hauteur> h(std::make_shared<Hauteur>());
        for(auto a : (driver.getVariablebloc($1))->getAttributs()){
            if(a->type()=="height"){
                h=std::dynamic_pointer_cast<Hauteur>(a);
            }
        }
        if(h->getVal()==""){
            (driver.getVariablebloc($1))->addAttribut(h);
        }
        $$=h;
    }
    |ID '.' WIDTH{
        std::shared_ptr<Largeur> l(std::make_shared<Largeur>());
        for(auto a : (driver.getVariablebloc($1))->getAttributs()){
            if(a->type()=="width"){
                l=std::dynamic_pointer_cast<Largeur>(a);
            }
        }
        if(l->getVal()==""){
            (driver.getVariablebloc($1))->addAttribut(l);
        }
        $$=l;
    }
    |ID '.' OPACITY{
        std::shared_ptr<Opacite> o(std::make_shared<Opacite>());
        for(auto a : (driver.getVariablebloc($1))->getAttributs()){
            if(a->type()=="opacity"){
                o=std::dynamic_pointer_cast<Opacite>(a);
            }
        }
        if(o->getVal()==""){
            (driver.getVariablebloc($1))->addAttribut(o);
        }
        $$=o;
    }

valeur_int:
    ID{
        $$=std::make_shared<Variable<int>>($1);
    }
    |NUMBER{
        $$ = std::make_shared<Constante<int>>($1);
    }
    |taille{
        $$ = std::make_shared<Constante<int>>($1,"px");
    }
    |ratio{
        $$ = std::make_shared<Constante<int>>($1,"%");
    }
    |valeur_int '+' valeur_int{
        try {
        int val1 = $1->calculer(driver.getContexteint());
        int val2 = $3->calculer(driver.getContexteint());
        std::string s;
        if(($1->getSuffixe(driver.getContexteint()).back()='x')){ // Avec ce IF, on permet à l'utilisateur d'ajouter plusieurs entiers de type différents ("10px+10%"" par exemple) et on ne garde que le type du premier entier rentré (qui serait donc "px" en l'occurrence)
            s="px";
        }
        else{
            s="%";
        }
        $$=std::make_shared<Constante<int>>(val1+val2,s);
        } catch(const std::exception& err) {
            std::cerr << "#-> " << err.what() << std::endl;
        }
    }
    |valeur_int '-' valeur_int
    {
        try {
        int val1 = $1->calculer(driver.getContexteint());
        int val2 = $3->calculer(driver.getContexteint());
        std::string s;
        if(($1->getSuffixe(driver.getContexteint()).back()='x')){
            s="px";
        }
        else{
            s="%";
        }
        $$=std::make_shared<Constante<int>>(val1-val2,s);
        } catch(const std::exception& err) {
            std::cerr << "#-> " << err.what() << std::endl;
        }
    }
    |valeur_int '*' valeur_int
    {
        try {
        int val1 = $1->calculer(driver.getContexteint());
        int val2 = $3->calculer(driver.getContexteint());
        std::string s;
        if(($1->getSuffixe(driver.getContexteint()).back()='x')){
            s="px";
        }
        else{
            s="%";
        }
        $$=std::make_shared<Constante<int>>(val1*val2,s);
        } catch(const std::exception& err) {
            std::cerr << "#-> " << err.what() << std::endl;
        }
    }
    |valeur_int '/' valeur_int
    {
        try {
        int val1 = $1->calculer(driver.getContexteint());
        int val2 = $3->calculer(driver.getContexteint());
        std::string s;
        if(($1->getSuffixe(driver.getContexteint()).back()='x')){
            s="px";
        }
        else{
            s="%";
        }
        $$=std::make_shared<Constante<int>>(val1/val2,s);
        } catch(const std::exception& err) {
            std::cerr << "#-> " << err.what() << std::endl;
        }
    }

taille:
     NUMBER'p'{
        $$=$1;
    }

ratio:
     NUMBER'%'{
        $$=$1;
    }

// Couleur (std::string)
identifiant_couleur:
    valeur_bloc '.' TEXTCOLOR{
        std::shared_ptr<CouleurTexte> t(std::make_shared<CouleurTexte>());
        for(auto a : $1->getAttributs()){
            if(a->type()=="color"){
                t=std::dynamic_pointer_cast<CouleurTexte>(a);
            }
        }
        if(t->getVal()==""){
            $1->addAttribut(t);
        }
        $$=t;
    }
    |valeur_bloc '.' BACKGROUNDCOLOR{
        std::shared_ptr<CouleurFond> f(std::make_shared<CouleurFond>());
        for(auto a : $1->getAttributs()){
            if(a->type()=="background-color"){
                f=std::dynamic_pointer_cast<CouleurFond>(a);
            }
        }
        if(f->getVal()==""){
            $1->addAttribut(f);
        }
        $$=f;
    }
    |ID '.' TEXTCOLOR{
        std::shared_ptr<CouleurTexte> t(std::make_shared<CouleurTexte>());
        for(auto a : (driver.getVariablebloc($1))->getAttributs()){
            if(a->type()=="color"){
                t=std::dynamic_pointer_cast<CouleurTexte>(a);
            }
        }
        if(t->getVal()==""){
            (driver.getVariablebloc($1))->addAttribut(t);
        }
        $$=t;
    }
    |ID '.' BACKGROUNDCOLOR{
        std::shared_ptr<CouleurFond> f(std::make_shared<CouleurFond>());
        for(auto a : (driver.getVariablebloc($1))->getAttributs()){
            if(a->type()=="background-color"){
                f=std::dynamic_pointer_cast<CouleurFond>(a);
            }
        }
        if(f->getVal()==""){
            (driver.getVariablebloc($1))->addAttribut(f);
        }
        $$=f;
    }

valeur_couleur:
    ID{
        $$=std::make_shared<Variable<std::string>>($1);
    }
    |couleur{
        $$ = std::make_shared<Constante<std::string>>($1);
    }

couleur:
    HEXANUMBER {
        for(auto & c : $1){
            c=std::toupper(c); // On met tout en majuscule pour pouvoir comparer les couleurs en tant que std::string
        }
        $$=$1;
    }
    |RGB '(' valeur_int ',' valeur_int ',' valeur_int ')'{
        try {
            std::string s="#";
            char c[10]; 
            int v1=$3->calculer(driver.getContexteint());
            sprintf(c,"%X",v1/16);
            s+=c;
            sprintf(c,"%X",v1%16);
            s+=c;
            int v2=$5->calculer(driver.getContexteint());
            sprintf(c,"%X",v2/16);
            s+=c;
            sprintf(c,"%X",v2%16);
            s+=c;
            int v3=$7->calculer(driver.getContexteint());
            sprintf(c,"%X",v3/16);
            s+=c;
            sprintf(c,"%X",v3%16);
            s+=c;
            $$=s;
        } catch(const std::exception& err) {
            std::cerr << "#-> " << err.what() << std::endl;
        } 
    }

// Style (std::vector<std::shared_ptr<Attribut>>)
identifiant_style:
    valeur_bloc '.' VAR_STYLE{
        $$=$1;
    }
    |ID '.' VAR_STYLE{
        $$=driver.getVariablebloc($1);
    }


valeur_style:
    ID{
        $$=std::make_shared<Variable<std::vector<std::shared_ptr<Attribut>>>>($1);
    }
    |'[' attributs_nl ']'{
        $$ = std::make_shared<Constante<std::vector<std::shared_ptr<Attribut>>>>($2);
    }

attributs_nl:
    NL attributs_nl {
        $$=$2;
    }
    |attribut NL attributs_nl {
        $3.push_back($1);
        $$=$3;
    }
    |attribut {
        std::vector<std::shared_ptr<Attribut>> a;
        a.push_back($1);
        $$=a;
    }
    |attribut NL {
        std::vector<std::shared_ptr<Attribut>> a;
        a.push_back($1);
        $$=a;
    }

// Bloc (std::shared_ptr<Bloc>)
valeur_bloc:
    ID{
        $$=driver.getVariablebloc($1);
    }
    |TITRE selecteur { // On commence les indices à 0
        $$=prog.getTitre($2);
    }
    | PARAGRAPH selecteur {
        $$=prog.getParagraphe($2);
    } 
    | IMAGE  selecteur {
        $$=prog.getImage($2);
    }

selecteur:
    '[' valeur_int ']'{
        try {
            int val1 = $2->calculer(driver.getContexteint());
            $$=val1;
        } catch(const std::exception& err) {
            std::cerr << "#-> " << err.what() << std::endl;
        }
    }

//----------------------------------------------------------------------------------------------------------------
// Bloc

bloc:
    TITRE objet{
        $$=std::make_shared<Titre>($2.attr,$2.text,$1);
    }
    | PARAGRAPH objet{
        $$=std::make_shared<Paragraphe>($2.attr,$2.text);
    }
    | IMAGE objet{
        $$=std::make_shared<Image>($2.attr,$2.text);
    }

objet: 
    texte{
        $$.attr=std::vector<std::shared_ptr<Attribut>>();
        $$.text=$1;
    }
    |  '[' attributs_virgules ']' texte{
        $$.attr=$2;
        $$.text=$4;
    }

attributs_virgules:
    attribut ',' attributs_virgules{
        $3.push_back($1);
        $$=$3;
    }
    | attribut {
        std::vector<std::shared_ptr<Attribut>> a;
        a.push_back($1);
        $$=a;
    }

attribut:
    HEIGHT ':' valeur_int{
        $$=std::make_shared<Hauteur>(std::to_string($3->calculer(driver.getContexteint()))+$3->getSuffixe(driver.getContexteint()));
    }
    | WIDTH ':' valeur_int{
        $$=std::make_shared<Largeur>(std::to_string($3->calculer(driver.getContexteint()))+$3->getSuffixe(driver.getContexteint()));
    }
    | TEXTCOLOR ':' valeur_couleur{
        $$=std::make_shared<CouleurTexte>($3->calculer(driver.getContextecouleur()));
    }
    | BACKGROUNDCOLOR ':' valeur_couleur{
        $$=std::make_shared<CouleurFond>($3->calculer(driver.getContextecouleur()));
    }
    | OPACITY ':'  valeur_int{
        $$=std::make_shared<Opacite>(std::to_string($3->calculer(driver.getContexteint()))+$3->getSuffixe(driver.getContexteint()));
    }

//----------------------------------------------------------------------------------------------------------------
// Conditionnelles

conditionelle: // Nous n'avons pas réussi à n'affecter des variables que lorsque la condition est vérifié (le parser reconnaît une affectation et l'effectue à la lecture)
    IF '(' condition ')' ':' code code_else ENDIF {
        if($3){
            std::cout << "Condition vérifiée, exécution des instructions du SI" << std::endl;
        }
        else{
            std::cout << $7 << std::endl;
        }
    }

code_else:
    {$$="Condition non vérifiée, pas de statement SINON";}
    |ELSE ':' code{
        $$="Condition non vérifiée, exécution des instructions du SINON";
    }

condition:
    booleen '&' condition{
        $$=($1 & $3);
    }
    |booleen '|' condition{
        $$=($1 | $3);
    }
    |'!' booleen{
        $$=not($2);
    }
    |booleen{
        $$=$1;
    }

booleen:
    TRUE {
        $$=true;
    }
    |FALSE{
        $$=false;
    }
    |int_comp '=''=' int_comp{
        $$=($1==$4);
    }
    |int_comp '!''=' int_comp{
        $$=($1!=$4);
    }
    |int_comp '<''=' int_comp{
        $$=($1<=$4);
    }
    |int_comp '>''=' int_comp{
        $$=($1>=$4);
    }
    |couleur_comp '=''=' couleur_comp{
        $$=($1==$4);
    }
    |couleur_comp '!''=' couleur_comp{
        $$=($1!=$4);
    }
    |style_comp '=''=' style_comp{
        $$=($1==$4);
    }
    |style_comp '!''=' style_comp{
        $$=($1!=$4);
    }
    |valeur_bloc '=''=' valeur_bloc{
        $$=($1==$4);
    }
    |valeur_bloc '!''=' valeur_bloc{
        $$=($1!=$4);
    }

int_comp:
    valeur_int{
        $$=$1->calculer(driver.getContexteint());
    }
    |identifiant_int{
        $$=std::stoi($1->getVal());
    }

couleur_comp:
    valeur_couleur{
        $$=$1->calculer(driver.getContextecouleur());
    }
    |identifiant_couleur{
        $$=$1->getVal();
    }

style_comp:
    valeur_style{
        $$=$1->calculer(driver.getContextestyle());
    }
    |identifiant_style{
        $$=$1->getAttributs();
    }

//----------------------------------------------------------------------------------------------------------------
// Boucles for

boucle:
    FOR  ID '['NUMBER','NUMBER']' operation_for ':' NL bloc NL END{
        driver.setVariableint($2, $4);
        for (int i=$4; i<$6;i=i+$8){
            prog.addBloc($11);
        }
    }
    |FOR  ID '['NUMBER','NUMBER']' operation_for ':' NL bloc ID NL END{
        for (int i=$4; i<$6;i=i+$8){
            driver.setVariableint($2, i);
            auto nouv = std::make_shared<Titre>($11->getAttributs(),$11->getText(), $11->getNiv());
            std::string text=nouv->getText()+std::to_string(driver.getContexteint()[$12]);
            nouv->setText(text);
            prog.addBloc(nouv);
        }
    }
    |FOR  ID '['NUMBER','NUMBER']' operation_for ':' NL bloc ID'/'valeur_int NL END{
        for (int i=$4; i<$6;i=i+$8){
            driver.setVariableint($2, i);
            auto nouv = std::make_shared<Titre>($11->getAttributs(),$11->getText(), $11->getNiv());
            std::string text=nouv->getText()+std::to_string(driver.getContexteint()[$12]/$14->calculer(driver.getContexteint()));
            nouv->setText(text);
            prog.addBloc(nouv);
        }
    }
    |FOR  ID '['NUMBER','NUMBER']' operation_for ':' NL bloc ID'-'valeur_int NL END{
        for (int i=$4; i<$6;i=i+$8){
            driver.setVariableint($2, i);
            auto nouv = std::make_shared<Titre>($11->getAttributs(),$11->getText(), $11->getNiv());
            std::string text=nouv->getText()+std::to_string(driver.getContexteint()[$12]-$14->calculer(driver.getContexteint()));
            nouv->setText(text);
            prog.addBloc(nouv);
        }
    }
    |FOR  ID '['NUMBER','NUMBER']' operation_for ':' NL bloc ID'+'valeur_int NL END{
        for (int i=$4; i<$6;i=i+$8){
            driver.setVariableint($2, i);
            auto nouv = std::make_shared<Titre>($11->getAttributs(),$11->getText(), $11->getNiv());
            std::string text=nouv->getText()+std::to_string(driver.getContexteint()[$12]+$14->calculer(driver.getContexteint()));
            nouv->setText(text);
            prog.addBloc(nouv);
        }
    }
    |FOR  ID '['NUMBER','NUMBER']' operation_for ':' NL bloc ID'*'valeur_int NL END{
        for (int i=$4; i<$6;i=i+$8){
            driver.setVariableint($2, i);
            auto nouv = std::make_shared<Titre>($11->getAttributs(),$11->getText(), $11->getNiv());
            std::string text=nouv->getText()+std::to_string(driver.getContexteint()[$12]*$14->calculer(driver.getContexteint()));
            nouv->setText(text);
            prog.addBloc(nouv);
        }
    }

operation_for:
    '+'NUMBER{
        $$=+$2;
    }
    |'-'NUMBER{
        $$=-$2;
    }
   
//----------------------------------------------------------------------------------------------------------------
// Meta_données (@define)

meta_donnees: // Contrairement aux attributs CSS, on ne sait pas vraiment si mettre plusieurs fois une définition en HTML pose problème, on a donc mis une seule définition de chaque par page puisque cela ne peut être changé qu'ici
    DEFINITION '('ENCODAGE')' '{'texte'}'{
        prog.setEncodage($6);
    }
    | DEFINITION '('ICON')' '{'texte'}'{
        prog.setIcone($6);
    }
    | DEFINITION '('CSS')' '{'texte'}'{ // Sauf pour les pages CSS qui peuvent être plusieurs dans un même fichier
        prog.addCss($6);
    }
    | DEFINITION '('LANG')' '{'texte'}'{
        prog.setLangue($6);
    }
    | TITREPAGE texte{
        prog.setTitre($2);
    }
    | STYLE '(' PAGE ')' '[' attributs_nl ']' {
        prog.addStyle(Style($6,"all"));
    }
    | STYLE '(' PARA ')' '[' attributs_nl ']' {
        prog.addStyle(Style($6,"p"));
    }
    | STYLE '(' TITR ')' '[' attributs_nl ']' {
        prog.addStyle(Style($6,"h"+std::to_string($3)));
    }

//----------------------------------------------------------------------------------------------------------------
// Commentaire (des std::string à modifier)

commentaire:
    COMMENTAIRE {
        $$ = Commentaire($1).calculer(); // On enlève les %% à gauche et les %%% de part et d'autre
    }

texte:
    TEXT {
        $$ = Text($1).calculer(); // On enlève les '' de part et d'autre et on remplace \' par '
    }

%%

//----------------------------------------------------------------------------------------------------------------
//Erreur :

void yy::Parser::error( const location_type &l, const std::string & err_msg) {
    std::cerr << "Erreur : " << l << ", " << err_msg << std::endl;
}