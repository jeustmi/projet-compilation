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
%token <int>            TITRE
%token                  PARAGRAPH
%token                  IMAGE
%token                  DEFINITION
%token                  TITREPAGE
%token                  COMMENTAIRE
%token                  ENCODAGE
%token                  ICON
%token                  CSS
%token                  LANG
%token <std::string>    LANG_VAL
%token <std::string>    ENCODAGE_VAL
%token <std::string>    CHEMIN
%token <std::string>    TEXT




%type <std::string> objet
%type <ExpressionPtr> commentaire
%type <ExpressionPtr> texte
%left '-' '+'
%left '*' '/'
%precedence  NEG

%%

programme:
    instruction NL programme 
    |commentaire NL programme
    | instruction{
        YYACCEPT;
    }
    | commentaire{
        YYACCEPT;
    }
    | instruction NL{
        YYACCEPT;
    }
    | commentaire NL{
        YYACCEPT;
    }

instruction:
    bloc{

    }
    | meta_donnees{

    }
    //variables
    //conditions
    //boucles

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
    }/*
    |ENCODAGE texte{
        $$=$2;
    }
    |ICON texte{
        $$=$2;
    }
    |CSS texte{
            $$=$2;
        }
    |LANG LANG_VAL texte{
            $$=$2;
        }*/


texte:
    TEXT {
        $$ = std::make_shared<ExpressionText>($1);
    }

commentaire:
    COMMENTAIRE NL {
        //std::cout << "#-> commentaire "<< $1 << std::endl;
        //$$ = std::make_shared<ExpressionComm>($1);
    }

%%

void yy::Parser::error( const location_type &l, const std::string & err_msg) {
    std::cerr << "Erreur : " << l << ", " << err_msg << std::endl;
}