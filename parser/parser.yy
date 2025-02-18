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
    #include "constante.hh"
    #include "variable.hh"

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




%type <std::shared_ptr<Bloc>> bloc
%type <std::string> texte
%type <std::shared_ptr<Attribut>> atribut 
%type <std::vector<std::shared_ptr<Attribut>>>  atributs_virgules
%type <objet> objet
%type <int> taille
%type <int> ratio
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
    instruction NL code {

    }
    | NL code{
    }
    | instruction{
    }
    | instruction NL{
    }
    

instruction:
    conditionelle{

    }
    |boucle{

    }
    |bloc{
        //std::cout<<"uiuiuiui\n";
        prog.addBloc($1);
    }
    |meta_donnees{
        
    }
    |commentaire{

    }
    |declaration{

    }

declaration:
    identite  '=' {std::cout<<" est affecté à ";} valeur{
        std::cout<<std::endl;
    }

conditionelle:
    IF '(' condition ')' ':'  code code_else ENDIF 

code_else:
    |ELSE ':' code

condition:
    booleen '&' condition{

    }
    |booleen '|' condition{

    }
    |'!' booleen{

    }
    |booleen{
        
    }

booleen://fonctionnera probablement comme les opérateurs binaires de la calculatrice
    valeur '=''=' valeur{

    }
    |valeur '<''=' valeur{

    }
    |valeur '>''=' valeur{

    }
    |valeur '!''=' valeur{

    }
    |TRUE
    |FALSE

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
    | STYLE '(' PAGE ')' {std::cout<<"Style sur une page";}'[' atributs_nl ']'
    | STYLE '(' PARA ')' {std::cout<<"Style sur un paragrahpe";}'[' atributs_nl ']'
    | STYLE '(' TITR ')' {std::cout<<"Style sur un titre";}'[' atributs_nl ']'

var_bloc:
    TITRE selecteur {
        std::cout<<"un bloc par selection d'un titre";
    }
    | PARAGRAPH selecteur {
        std::cout<<"un bloc par selection d'un paragragphe";
    } 
    | IMAGE  selecteur {
        std::cout<<"un bloc par selection d'une image";
    }
    /*|bloc {
        std::cout<<" pure";
    }*/


selecteur:
    '[' valeur ']'{

    }

bloc:
    TITRE objet{
        std::cout<<"Titre "<<std::to_string($1)<<" : "<<$2.text<< std::endl;
        $$=std::make_shared<Titre>($2.attr,$2.text,$1/*$3.calculer()*/);
    }
    |TITRE objet valeur{// pour plus d'infos sur la couleur :https://en.wikipedia.org/wiki/ANSI_escape_code#Select_Graphic_Rendition_parameters
        if($1!=1){
            std::cout<<"\033[;33mWarning : number behind title definition overrides a level that isn't 1 (default value).\033[0m\n";
        }
        std::cout<<"Titre "<<std::to_string($1)<<" : "<<$2.text<< std::endl;
        $$=std::make_shared<Titre>($2.attr,$2.text,$1/*$3.calculer()*/);
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

identite:
    ID {std::cout<<"une variable";}
    |var_bloc '.' VAR_STYLE{std::cout<<"le style d'un blc";}
    |var_bloc '.' HEIGHT{std::cout<<"la hauteur d'un bloc";}
    |var_bloc '.' WIDTH{std::cout<<"la largeur d'un bloc";}
    |var_bloc '.' TEXTCOLOR{std::cout<<"la couleur de texte d'un bloc";}
    |var_bloc '.' BACKGROUNDCOLOR{std::cout<<"la couleur de fond d'un bloc";}
    |var_bloc '.' OPACITY{std::cout<<"l'opacité d'une variable";}
    |ID '.' VAR_STYLE{std::cout<<"le style d'une variable";}
    |ID '.' HEIGHT{std::cout<<"la hauteur d'une variable";}
    |ID '.' WIDTH{std::cout<<"la largeur d'une variable";}
    |ID '.' TEXTCOLOR{std::cout<<"la couleur de texte d'une variable";}
    |ID '.' BACKGROUNDCOLOR{std::cout<<"la couleur de fond d'une variable";}
    |ID '.' OPACITY{std::cout<<"l'opacité d'une variable";}

valeur:
    var_bloc
    |identite
    |NUMBER{std::cout<<"un nombre";}
    |couleur{std::cout<<"une couleur";}
    |'[' atributs_virgules ']'{std::cout<<"un style";}
    |taille
    |ratio
    |valeur '+' valeur
    |valeur '-' valeur
    |valeur '*' valeur
    |valeur '/' valeur

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
    atribut NL atributs_nl{//fonctione pour detecter les différents retours à la ligne, mais me parait peu élégant cepandant.

    }
    |atribut  
    |NL atributs_nl
    |

atribut:
    HEIGHT ':' valeur{
        $$=std::make_shared<Hauteur>("feur"/*$3.calculer()*/);
    }
    | WIDTH ':' valeur{
        $$=std::make_shared<Largeur>("feur"/*$3.calculer()*/);
    }
    | TEXTCOLOR ':' valeur{
        $$=std::make_shared<CouleurTexte>("feur"/*$3.calculer()*/);
    }
    | BACKGROUNDCOLOR ':' valeur{
        $$=std::make_shared<CouleurFond>("feur"/*$3.calculer()*/);
    }
    | OPACITY ':'  valeur{
        $$=std::make_shared<Opacite>("feur"/*$3.calculer()*/);
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
        
    }
    |RGB '('valeur','valeur','valeur')'

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