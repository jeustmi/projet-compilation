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

    #include "variables/constanteint.hh"
    #include "variables/variableint.hh"
    #include "variables/constantecouleur.hh"
    #include "variables/variablecouleur.hh"
    #include "variables/constantebloc.hh"
    #include "variables/variablebloc.hh"
    #include "variables/constantestyle.hh"
    #include "variables/variablestyle.hh"

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




//%type <std::vector<std::shared_ptr<Bloc>>> inst
%type <std::vector<std::shared_ptr<Bloc>>> code_else
%type <std::shared_ptr<Bloc>> instruction
%type <std::vector<std::shared_ptr<Bloc>>> boucle
%type <std::vector<std::shared_ptr<Bloc>>> conditionelle
%type <std::shared_ptr<Bloc>> bloc
%type <std::shared_ptr<Bloc>> var_bloc
%type <std::shared_ptr<Expression<int>>> valeurint
%type <std::shared_ptr<Expression<std::string>>> valeurcouleur
%type <std::shared_ptr<Expression<std::vector<std::shared_ptr<Attribut>>>>> valeurstyle
%type <std::string> couleur
%type <std::string> texte
%type <std::shared_ptr<Attribut>> atribut 
%type <std::shared_ptr<Attribut>> identifiant_int
%type <std::shared_ptr<Attribut>> identifiant_couleur
%type <std::shared_ptr<Bloc>> identifiant_style
%type <std::vector<std::shared_ptr<Attribut>>>  atributs_virgules
%type <std::vector<std::shared_ptr<Attribut>>>  atributs_nl
%type <objet> objet
%type <int> taille
%type <int> ratio
%type <int> selecteur
%type <bool> condition
%type <bool> booleen
%left '-' '+'
%left '*' '/'

%%

//----------------------------------------------------------------------------------------------------------------
//Reconnaissance du langage :

programme:
    code{
        //prog.creation_page();
        YYACCEPT;
    }

code:
    /*inst{
        for(auto e : $1){
            prog.addBloc(e);
        }
    }*/
    instruction NL code {

    }
    | NL code{
    }
    | instruction{
    }
    | instruction NL{
    }

/*inst:
    instruction NL inst{
        if($1!=nullptr){
            $3.push_back($1);
        }
        $$=$3;
    }
    |instruction{
        std::cout<<($1!=nullptr);
        std::vector<std::shared_ptr<Bloc>> b;
        if($1!=nullptr){
            b.push_back($1);
        }
        $$=b;
    }
    |instruction NL{
        std::vector<std::shared_ptr<Bloc>> b;
        if($1!=nullptr){
            b.push_back($1);
        }
        $$=b;
    }
    |conditionelle NL inst{
        for(auto e : $3){
            $1.push_back(e);
        }
        $$=$1;
    }
    |conditionelle{
        $$=$1;
    }
    |boucle{
        $$=$1;
    }*/

    

instruction:
    bloc{
        //std::cout<<"uiuiuiui\n";
        prog.addBloc($1);
        $$=$1;
    }
    |meta_donnees{

    }
    |commentaire{

    }
    |declaration{

    }
    |affectation{

    }
    // |var_bloc{
        
    // }

declaration:
    ID  '=' valeurint{
        try {
        int val = $3->calculer(driver.getContexteint());
        driver.setVariableint($1, val);
        std::cout << "#=-> " << $1 << " = " << val << std::endl;
        } catch(const std::exception& err) {
            std::cerr << "#!-> " << err.what() << std::endl;
        }
    }
    |ID '=' var_bloc{
        try{
            driver.setVariablebloc($1, $3);
        } catch(const std::exception& err) {
            std::cerr << "#!-> " << err.what() << std::endl;
        }
    }
    |ID '=' valeurcouleur{
        try {
        std::string val = $3->calculer(driver.getContextecouleur());
        driver.setVariablecouleur($1, val);
        std::cout << "#=-> " << $1 << " = " << val << std::endl;
        } catch(const std::exception& err) {
            std::cerr << "#!-> " << err.what() << std::endl;
        }
    }
    |ID '=' valeurstyle{
        try {
        std::vector<std::shared_ptr<Attribut>> val = $3->calculer(driver.getContextestyle());
        driver.setVariablestyle($1, val);
        std::cout << "#=-> " << $1 << " = " << "euh ouais le style" << std::endl;
        } catch(const std::exception& err) {
            std::cerr << "#!-> " << err.what() << std::endl;
        }
    }

affectation:
    identifiant_int '=' valeurint{
        try {
        std::string val = $3->to_string(driver.getContexteint());
        $1->setVal(val);
        std::cout << "#=-> " << $1 << " = " << val << std::endl;
        } catch(const std::exception& err) {
            std::cerr << "#!-> " << err.what() << std::endl;
        }
    }
    |identifiant_couleur '=' valeurcouleur{
        try {
        std::string val = $3->calculer(driver.getContextecouleur());
        $1->setVal(val);
        std::cout << "#=-> " << $1 << " = " << val << std::endl;
        } catch(const std::exception& err) {
            std::cerr << "#!-> " << err.what() << std::endl;
        }
    }
    |identifiant_style '=' valeurstyle{
        try {
        std::vector<std::shared_ptr<Attribut>> val = $3->calculer(driver.getContextestyle());
        $1->setAttributs(val);
        std::cout << "#=-> " << "euh ouais le style du bloc" << " = " << "euh ouais le style" << std::endl;
        } catch(const std::exception& err) {
            std::cerr << "#!-> " << err.what() << std::endl;
        }
    }
    

/*conditionelle:
    IF '(' condition ')' ':' inst code_else ENDIF {
        std::cout<<$3;
        if($3){
            std::cout<<"ui";
            $$=$6;
        }else{
            std::cout<<"non";
            $$=$7;
        }
    }*/
    //SI ( true ) : !T 'Premier Titre' SINON : !TT 'cringe' FINSI
    /*
    SI ( true ) : SI ( false ) : !T 'Premier Titre' SINON : !TT 'cringe' FINSI 
    !TTT 'très cringe' SINON : !TTTT 'VRAIMENT très cringe' FINSI
    */
    //SI ( false ) : !T 'Premier Titre' SINON : !TT 'cringe' FINSI

/*code_else:

    |ELSE ':' inst{
        $$=$3;
    }*/

condition:
    booleen '&' condition{

    }
    |booleen '|' condition{

    }
    |'!' booleen{

    }
    |booleen{
        $$=$1;
    }

booleen://fonctionnera probablement comme les opérateurs binaires de la calculatrice
    TRUE {
        $$=true;
    }
    |FALSE{
        $$=false;
    }
    /*valeur '=''=' valeur{

    }
    |valeur '<''=' valeur{

    }
    |valeur '>''=' valeur{

    }
    |valeur '!''=' valeur{

    }
    |TRUE
    |FALSE*/

boucle:
    FOR  ID '['NUMBER','NUMBER']' operation_for ':' code END{

    }

operation_for:
    '+'NUMBER{

    }
    |'-'NUMBER{
    
    }

meta_donnees:
    DEFINITION '('ENCODAGE')' '{'texte'}'{
        std::cout<<"Encodage "<<" : "<<$6<< std::endl;
        prog.setEncodage($6);
    }
    | DEFINITION '('ICON')' '{'texte'}'{
        std::cout<<"Icone "<<" : "<<$6<< std::endl;
        prog.setIcone($6);
    }
    | DEFINITION '('CSS')' '{'texte'}'{
        std::cout<<"CSS "<<" : "<<$6<< std::endl;
        prog.addCss($6);
    }
    | DEFINITION '('LANG')' '{'texte'}'{
        std::cout<<"Langue "<<" : "<<$6<< std::endl;
        prog.setLangue($6);
    }
    | TITREPAGE texte{
        std::cout<<"Titre "<<" : "<<$2<< std::endl;
        prog.setTitre($2);
    }
    | STYLE '(' PAGE ')' {std::cout<<"Style sur une page";} '[' atributs_nl ']' {
        prog.addStyle(Style($7,"all"));
        //std::cout<<"feur";
    }
    | STYLE '(' PARA ')' {std::cout<<"Style sur un paragrahpe";}'[' atributs_nl ']' {
        prog.addStyle(Style($7,"p"));
    }
    | STYLE '(' TITR ')' {std::cout<<"Style sur un titre";}'[' atributs_nl ']' {
        prog.addStyle(Style($7,"h"+std::to_string($3)));
    }
     /*@STYLE ( titre1 ) [
couleurTexte : rgb(100,255,100)
couleurFond : #000000
]*/
/*@STYLE ( page ) [
couleurTexte : rgb(100,255,100)
]*/
/*@STYLE ( page ) [
]*/

var_bloc:
    TITRE selecteur {
        std::cout<<"un bloc par selection d'un titre "+std::to_string($2);
        $$=prog.getTitre($2);
    }
    | PARAGRAPH selecteur {
        std::cout<<"un bloc par selection d'un paragragphe";
        $$=prog.getParagraphe($2);
    } 
    | IMAGE  selecteur {
        std::cout<<"un bloc par selection d'une image";
        $$=prog.getImage($2);
        
    }
    /*|bloc {
        std::cout<<" pur";
    }*/


selecteur:
    '[' valeurint ']'{
        try {
        int val1 = $2->calculer(driver.getContexteint());
        $$=val1;
        } catch(const std::exception& err) {
            std::cerr << "#-> " << err.what() << std::endl;
        }
    }

bloc:
    TITRE objet{
        std::cout<<"Titre "<<std::to_string($1)<<" : "<<$2.text<< std::endl;
        $$=std::make_shared<Titre>($2.attr,$2.text,$1);
    }
    |TITRE objet valeurint{// pour plus d'infos sur la couleur :https://en.wikipedia.org/wiki/ANSI_escape_code#Select_Graphic_Rendition_parameters
        if($1!=1){
            std::cout<<"\033[;33mWarning : number behind title definition overrides a level that isn't 1 (default value).\033[0m\n";
        }
        std::cout<<"Titre "<<std::to_string($1)<<" : "<<$2.text<< std::endl;
        $$=std::make_shared<Titre>($2.attr,$2.text,$3->calculer(driver.getContexteint()));
    }
    | PARAGRAPH objet{
        std::cout<<"Paragraphe "<<" : "<<$2.text<< std::endl;
        $$=std::make_shared<Paragraphe>($2.attr,$2.text/*$3.calculer()*/);
    }
    | IMAGE objet{
        std::cout<<"Image "<<" : "<<$2.text<< std::endl;
        $$=std::make_shared<Image>($2.attr,$2.text/*$3.calculer()*/);
    }

objet:
    texte{
        $$.attr=std::vector<std::shared_ptr<Attribut>>();
        $$.text=$1;
    }
    |  '[' atributs_virgules ']' texte{
        $$.attr=$2;
        $$.text=$4;
    }

//----------------------------------------------------------------------------------------------------------------
//Types de Données :

identifiant_int:
    /*var_bloc '.' VAR_STYLE{std::cout<<"le style d'un blc";}
    |*/var_bloc '.' HEIGHT{
        std::shared_ptr<Hauteur> h(std::make_shared<Hauteur>());
        $1->addAttribut(h);
        $$=h;
    }
    |var_bloc '.' WIDTH{
        std::shared_ptr<Largeur> l(std::make_shared<Largeur>());
        $1->addAttribut(l);
        $$=l;
    }
    /*|var_bloc '.' TEXTCOLOR{std::cout<<"la couleur de texte d'un bloc";}
    |var_bloc '.' BACKGROUNDCOLOR{std::cout<<"la couleur de fond d'un bloc";}*/
    |var_bloc '.' OPACITY{
        std::shared_ptr<Opacite> o(std::make_shared<Opacite>());
        $1->addAttribut(o);
        $$=o;
    }
    //|ID '.' VAR_STYLE{std::cout<<"le style d'une variable";}
    |ID '.' HEIGHT{
        std::shared_ptr<Hauteur> h(std::make_shared<Hauteur>());
        (driver.getVariablebloc($1))->addAttribut(h);
        $$=h;
    }
    |ID '.' WIDTH{
        std::shared_ptr<Largeur> l(std::make_shared<Largeur>());
        (driver.getVariablebloc($1))->addAttribut(l);
        $$=l;
    }
    // |ID '.' TEXTCOLOR{std::cout<<"la couleur de texte d'une variable";}
    // |ID '.' BACKGROUNDCOLOR{std::cout<<"la couleur de fond d'une variable";}
    |ID '.' OPACITY{
        std::shared_ptr<Opacite> o(std::make_shared<Opacite>());
        (driver.getVariablebloc($1))->addAttribut(o);
        $$=o;
    }

valeurint:
    /*var_bloc
    |*/ID{
        $$=std::make_shared<VariableInt>($1);
    }
    |NUMBER{
        $$ = std::make_shared<ConstanteInt>($1);
    }
    /*|couleur{
        $$ = std::make_shared<ConstanteInt>($1);
    }*/
    /*|'[' atributs_virgules ']'{
    
    }*/
    |taille{
        $$ = std::make_shared<ConstanteInt>($1,"px");
    }
    |ratio{
        $$ = std::make_shared<ConstanteInt>($1,"%");
    }
    |valeurint '+' valeurint{//TODO: les valeurs n'etant pas des nombres sont transformées en 0. Peut être faire une erreur plutôt.
        try {
        int val1 = $1->calculer(driver.getContexteint());
        int val2 = $3->calculer(driver.getContexteint());
        //std::cout<<" avl2 = "<<std::to_string(val2)<<std::endl;
        std::string s;
        if(($1->to_string(driver.getContexteint()).back()='x')){
            s="px";
        }
        else{
            s="%";
        }
        $$=std::make_shared<ConstanteInt>(val1+val2,s);
        } catch(const std::exception& err) {
            std::cerr << "#-> " << err.what() << std::endl;
        }
    }
    |valeurint '-' valeurint
    {
        try {
        int val1 = $1->calculer(driver.getContexteint());
        int val2 = $3->calculer(driver.getContexteint());
        std::string s;
        if(($1->to_string(driver.getContexteint()).back()='x')){
            s="px";
        }
        else{
            s="%";
        }
        $$=std::make_shared<ConstanteInt>(val1-val2,s);
        } catch(const std::exception& err) {
            std::cerr << "#-> " << err.what() << std::endl;
        }
    }
    |valeurint '*' valeurint
    {
        try {
        int val1 = $1->calculer(driver.getContexteint());
        int val2 = $3->calculer(driver.getContexteint());
        std::string s;
        if(($1->to_string(driver.getContexteint()).back()='x')){
            s="px";
        }
        else{
            s="%";
        }
        $$=std::make_shared<ConstanteInt>(val1*val2,s);
        } catch(const std::exception& err) {
            std::cerr << "#-> " << err.what() << std::endl;
        }
    }
    |valeurint '/' valeurint
    {
        try {
        int val1 = $1->calculer(driver.getContexteint());
        int val2 = $3->calculer(driver.getContexteint());
        std::string s;
        if(($1->to_string(driver.getContexteint()).back()='x')){
            s="px";
        }
        else{
            s="%";
        }
        $$=std::make_shared<ConstanteInt>(val1/val2,s);
        } catch(const std::exception& err) {
            std::cerr << "#-> " << err.what() << std::endl;
        }
    }

identifiant_couleur:
    var_bloc '.' TEXTCOLOR{
        std::shared_ptr<CouleurTexte> t(std::make_shared<CouleurTexte>());
        $1->addAttribut(t);
        $$=t;
    }
    |var_bloc '.' BACKGROUNDCOLOR{
        std::shared_ptr<CouleurFond> f(std::make_shared<CouleurFond>());
        $1->addAttribut(f);
        $$=f;
    }
    |ID '.' TEXTCOLOR{
        std::shared_ptr<CouleurTexte> t(std::make_shared<CouleurTexte>());
        (driver.getVariablebloc($1))->addAttribut(t);
        $$=t;
    }
    |ID '.' BACKGROUNDCOLOR{
        std::shared_ptr<CouleurFond> f(std::make_shared<CouleurFond>());
        (driver.getVariablebloc($1))->addAttribut(f);
        $$=f;
    }

valeurcouleur:
    ID{
        $$=std::make_shared<VariableCouleur>($1);
    }
    |couleur{
        $$ = std::make_shared<ConstanteCouleur>($1);
    }

identifiant_style:
    var_bloc '.' VAR_STYLE{
        $$=$1;
    }
    |ID '.' VAR_STYLE{
        $$=driver.getVariablebloc($1);
    }


valeurstyle:
    ID{
        $$=std::make_shared<VariableStyle>($1);
    }
    |'[' atributs_nl ']'{
        $$ = std::make_shared<ConstanteStyle>($2);
    }



// valeur:
//     /*var_bloc
//     |*/identite{
//         $$=std::make_shared<VariableInt>($1);
//     }
//     |NUMBER{
//         $$ = std::make_shared<ConstanteInt>($1);
//     }
//     |couleur{
//         $$ = std::make_shared<ConstanteInt>($1);
//     }
//     /*|'[' atributs_virgules ']'{
    
//     }*/
//     |taille{
//         $$ = std::make_shared<ConstanteInt>($1);
//     }
//     |ratio{
//         $$ = std::make_shared<ConstanteInt>($1);
//     }
//     |valeur '+' valeur{//TODO: les valeurs n'etant pas des nombres sont transformées en 0. Peut être faire une erreur plutôt.
//         try {
//         int val1 = $1->calculer(driver.getContexteint());
//         int val2 = $3->calculer(driver.getContexteint());
//         //std::cout<<" avl2 = "<<std::to_string(val2)<<std::endl;
//         $$=std::make_shared<ConstanteInt>(val1+val2);
//         } catch(const std::exception& err) {
//             std::cerr << "#-> " << err.what() << std::endl;
//         }
//     }
//     |valeur '-' valeur
//     {
//         try {
//         int val1 = $1->calculer(driver.getContexteint());
//         int val2 = $3->calculer(driver.getContexteint());
//         $$=std::make_shared<ConstanteInt>(val1-val2);
//         } catch(const std::exception& err) {
//             std::cerr << "#-> " << err.what() << std::endl;
//         }
//     }
//     |valeur '*' valeur
//     {
//         try {
//         int val1 = $1->calculer(driver.getContexteint());
//         int val2 = $3->calculer(driver.getContexteint());
//         $$=std::make_shared<ConstanteInt>(val1*val2);
//         } catch(const std::exception& err) {
//             std::cerr << "#-> " << err.what() << std::endl;
//         }
//     }
//     |valeur '/' valeur
//     {
//         try {
//         int val1 = $1->calculer(driver.getContexteint());
//         int val2 = $3->calculer(driver.getContexteint());
//         $$=std::make_shared<ConstanteInt>(val1/val2);
//         } catch(const std::exception& err) {
//             std::cerr << "#-> " << err.what() << std::endl;
//         }
//     }

atributs_virgules:
    atribut ',' atributs_virgules{
        $3.push_back($1);
        $$=$3;
    }
    | atribut {
        std::vector<std::shared_ptr<Attribut>> a;
        a.push_back($1);
        $$=a;
    }
    //!T [couleurTexte : rgb(255,0,0)] 'Ceci est un long texte'
    //!T 'Ceci est un long texte'

atributs_nl:
    NL atributs_nl {
        $$=$2;
    }
    |atribut NL atributs_nl {//fonctione pour detecter les différents retours à la ligne, mais me parait peu élégant cepandant.
        $3.push_back($1);
        $$=$3;
    }
    |atribut {
        std::vector<std::shared_ptr<Attribut>> a;
        a.push_back($1);
        $$=a;
    }
    |atribut NL {
        std::vector<std::shared_ptr<Attribut>> a;
        a.push_back($1);
        $$=a;
    }
    //|/
    /*@STYLE ( titre1 ) [
largeur : 1000px
hauteur : 500%
]*/
/*@STYLE ( titre1 ) [couleurTexte : rgb(100,255,100)]*/
/*@STYLE ( titre1 ) []*/

atribut:
    HEIGHT ':' valeurint{
        $$=std::make_shared<Hauteur>($3->to_string(driver.getContexteint()));
    }
    | WIDTH ':' valeurint{
        $$=std::make_shared<Largeur>($3->to_string(driver.getContexteint()));
    }
    | TEXTCOLOR ':' valeurcouleur{
        $$=std::make_shared<CouleurTexte>($3->calculer(driver.getContextecouleur()));
    }
    | BACKGROUNDCOLOR ':' valeurcouleur{
        $$=std::make_shared<CouleurFond>($3->calculer(driver.getContextecouleur()));
    }
    | OPACITY ':'  valeurint{
        $$=std::make_shared<Opacite>($3->to_string(driver.getContexteint()));
    }

taille:
     NUMBER'p'{
        $$=$1;
    }

ratio:
     NUMBER'%'{
        $$=$1;
    }

couleur:
    HEXANUMBER {
        $$=$1;
    }
    |RGB '(' valeurint ',' valeurint ',' valeurint ')'{
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

texte:
    TEXT {
        $$ = Text($1).calculer();
    }

commentaire:
    COMMENTAIRE {
        //$ $ = std::make_shared<ExpressionComm>($1);
        //std::cout << "#-> commentaire "<< $ $->calculer() << std::endl;
        Commentaire D1($1);
        std::cout << "#-> commentaire "<< D1.calculer() << std::endl;
        prog.addComm(D1);
    }

%%


//----------------------------------------------------------------------------------------------------------------
//Erreur :
void yy::Parser::error( const location_type &l, const std::string & err_msg) {
    std::cerr << "Erreur : " << l << ", " << err_msg << std::endl;
}