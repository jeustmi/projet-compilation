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
%token <int>            TITR
%token <std::string>    TEXT
%token <std::string>    COLOR
%token                  WIDTH
%token                  HEIGHT
%token                  TEXTCOLOR
%token                  BACKGROUNDCOLOR
%token                  OPACITY




%type <std::string> objet
//%type <ExpressionPtr> commentaire
%type <ExpressionPtr> texte
%type <int> taille
%type <int> ratio
%left '-' '+'
%left '*' '/'
%precedence  NEG

%%

programme:
    code{
        YYACCEPT;
    }

code:
    instruction NL code 
    |commentaire NL code
    | instruction{
    }
    | commentaire{
    }
    | instruction NL{
    }
    | commentaire NL{
    }    

instruction:
    conditionelle{

    }
    bloc{

    }
    | meta_donnees{
        
    }
    //variables
    //conditions
    //boucles

conditionelle:
    IF '('  ')' ':' code ENDIF
    |IF '('  ')' ':' code ELSE ':' code ENDIF

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
        ExpressionText D2($2);
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
    | STYLE '(' PAGE ')' '['atributs']'{

    }
    | STYLE '(' PARA ')' '['atributs']'{
        
    }
    | STYLE '(' TITR ')' '['atributs']'{
        
    }

bloc:
    TITRE objet{
        std::cout<<"Titre "<<std::to_string($1)<<" : "<<$2<< std::endl;
    }
    | PARAGRAPH objet{
        std::cout<<"Paragraphe "<<" : "<<$2<< std::endl;
    }
    | IMAGE objet{
        std::cout<<"Image "<<" : "<<$2<< std::endl;
    }

objet:
    texte{
        $$=$1->calculer();
    }
    | '['atributs']' texte{
        $$=$4->calculer();
    }

atributs:
    atribut','atributs{

    }
    | atribut

atribut:
    HEIGHT ':' taille{

    }
    | WIDTH ':' taille{
        
    }
    | TEXTCOLOR ':' couleur{
        
    }
    | BACKGROUNDCOLOR ':' couleur{
        
    }
    | OPACITY ':' ratio{
        
    }

taille:
    NUMBER{
        $$=$1;
    }
    | NUMBER'p'{
        $$=$1;
    }

ratio:
    NUMBER{
        $$=$1;
    }
    | NUMBER'%'{
        $$=$1;
    }

couleur:
    COLOR

texte:
    TEXT {
        $$ = std::make_shared<ExpressionText>($1);
    }

commentaire:
    COMMENTAIRE NL {
        //$$ = std::make_shared<ExpressionComm>($1);
        //std::cout << "#-> commentaire "<< $$->calculer() << std::endl;
        ExpressionComm D1($1);
        std::cout << "#-> commentaire "<< D1.calculer() << std::endl;
    }

%%

void yy::Parser::error( const location_type &l, const std::string & err_msg) {
    std::cerr << "Erreur : " << l << ", " << err_msg << std::endl;
}