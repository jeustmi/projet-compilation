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

    class Scanner;
    class Driver;
}

%parse-param { Scanner &scanner }
%parse-param { Driver &driver }

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




%type <std::string> objet
//%type <ExpressionPtr> commentaire
%type <std::shared_ptr<Text>> texte
%type <int> taille
%type <int> ratio
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
    FOR {std::cout<<"ox";} ID {std::cout<<"ox";} '['NUMBER','NUMBER']' operation_for ':' code END{

    }

operation_for:
    '+'NUMBER{

    }
    |'-'NUMBER{
    
    }

meta_donnees:
    DEFINITION '('ENCODAGE')' '{'TEXT'}'{
        std::cout<<"Encodage "<<" : "<<$6<< std::endl;
    }
    | DEFINITION '('ICON')' '{'TEXT'}'{
        std::cout<<"Icone "<<" : "<<$6<< std::endl;
    }
    | DEFINITION '('CSS')' '{'TEXT'}'{
        std::cout<<"CSS "<<" : "<<$6<< std::endl;
    }
    | DEFINITION '('LANG')' '{'TEXT'}'{
        std::cout<<"Langue "<<" : "<<$6<< std::endl;
    }
    | TITREPAGE TEXT{
        std::cout<<"La page s'apellera "<<" : "<<$2<< std::endl;
        Text D2($2);
        try{
            std::string val = D2.calculer(/*driver.getContexte()*/);
            std::cout<<val<<std::endl;
			driver.setVariable("charset", val);
			std::cout << "#-> " << $2 << " = " << val << std::endl;
        }
        catch(const std::exception& err) {
            std::cerr << "#-> " << err.what() << std::endl;
        }
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
    TITRE objet surcharge{
        std::cout<<"Titre "<<std::to_string($1)<<" : "<<$2<< std::endl;
    }
    | PARAGRAPH objet{
        std::cout<<"Paragraphe "<<" : "<<$2<< std::endl;
    }
    | IMAGE objet{
        std::cout<<"Image "<<" : "<<$2<< std::endl;
    }

surcharge:
    
    |valeur

objet:
    texte{
        $$=$1->calculer();
    }
    |  '[' atributs_virgules ']' texte{
        $$=$4->calculer();
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

    }
    | atribut

atributs_nl:
    atribut NL atributs_nl{//fonctione pour detecter les différents retours à la ligne, mais me parait peu élégant cepandant.

    }
    |atribut  
    |NL atributs_nl
    |

atribut:
    HEIGHT ':' valeur{

    }
    | WIDTH ':' valeur{
        
    }
    | TEXTCOLOR ':' valeur{
        
    }
    | BACKGROUNDCOLOR ':' valeur{
        
    }
    | OPACITY ':'  valeur{
        
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
        $$ = std::make_shared<Text>($1);
    }

commentaire:
    COMMENTAIRE {
        //$ $ = std::make_shared<ExpressionComm>($1);
        //std::cout << "#-> commentaire "<< $ $->calculer() << std::endl;
        Commentaire D1($1);
        std::cout << "#-> commentaire "<< D1.calculer() << std::endl;
    }

%%


//----------------------------------------------------------------------------------------------------------------
//Erreur :
void yy::Parser::error( const location_type &l, const std::string & err_msg) {
    std::cerr << "Erreur : " << l << ", " << err_msg << std::endl;
}