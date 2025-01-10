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
%token <std::string>    COMMENTAIRE
%token <std::string>    TEXT




%type <std::shared_ptr<ExpressionText>> text
%left '-' '+'
%left '*' '/'
%precedence  NEG

%%

programme:
    instruction NL programme
    |commentaire NL programme
    | instruction{
        std::cout << "YYACEPT"  << std::endl;
        YYACCEPT;
    }
    | commentaire{
        std::cout << "YYACEPT"  << std::endl;
        YYACCEPT;
    }

instruction:
    expression  {
        //YYACCEPT;
    }
    | affectation {
      //YYACCEPT;
    }

expression:
    text {
        try{
            std::string val = $1->calculer(/*driver.getContexte()*/);
            std::cout << "text-> " << val << std::endl;
        }
        catch(const std::exception& err) {
			std::cerr << "#-> " << err.what() << std::endl;
		}
    }

text:
    TEXT {
        $$ = std::make_shared<ExpressionText>($1);
    }

commentaire:
    COMMENTAIRE{
        std::cout << "#-> commentaire "<<$1 << std::endl;
    }


affectation:
    '=' { std::cout << "Affectation à réaliser" << std::endl;
    }

%%

void yy::Parser::error( const location_type &l, const std::string & err_msg) {
    std::cerr << "Erreur : " << l << ", " << err_msg << std::endl;
}