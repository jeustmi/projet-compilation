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
%token                  END
%token <int>            NUMBER
%token <int>            TITRE
%token                  PARAGRAPH
%token                  IMAGE
%token                  DEFINITION
%token <std::string>    COMMENTAIRE
%token <std::string>    TEXT



%type <ExpressionPtr> commentaire
%type <ExpressionPtr> texte
%left '-' '+'
%left '*' '/'
%precedence  NEG

%%

programme:
    instruction NL programme 
    | instruction{
        YYACCEPT;
    }
    | commentaire{
        std::cout << "comm : " << $1->calculer() << std::endl; 
        YYACCEPT;
    }
    | texte {
        std::cout << "texte : " << $1->calculer() << std::endl; 
        YYACCEPT;
    }

instruction:
    bloc{

    }
    //variables
    //conditions
    //boucles

bloc:
    TITRE texte{
        std::cout<<"Titre "<<std::to_string($1)<<" : "<<$2->calculer()<< std::endl;
    }
    |PARAGRAPH texte{
        std::cout<<"Paragraphe "<<" : "<<$2<< std::endl;
    }
    |IMAGE texte{
        std::cout<<"Image "<<" : "<<$2<< std::endl;
    }

texte:
    TEXT {
        $$ = std::make_shared<ExpressionText>($1);
    }

commentaire:
    COMMENTAIRE {
        $$ = std::make_shared<ExpressionComm>($1);
        std::cout << "#-> commentaire "<< $$->calculer() << std::endl;
    }

%%

void yy::Parser::error( const location_type &l, const std::string & err_msg) {
    std::cerr << "Erreur : " << l << ", " << err_msg << std::endl;
}