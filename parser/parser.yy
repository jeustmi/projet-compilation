%skeleton "lalr1.cc"
%require "3.0"

%defines
%define api.parser.class { Parser }
%define api.value.type variant
%define parse.assert

%locations

%code requires{
    #include "contexte.hh"
    #include "expressionBinaire.hh"
    #include "expressionUnaire.hh"
    #include "constante.hh"
    #include "variable.hh"
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
%token <std::string>    TEXT

%type <std::shared_ptr<ExpressionText>> text
%type <int>             operation
%left '-' '+'
%left '*' '/'
%precedence  NEG

%%

programme:
    instruction NL programme
    | END NL {
        YYACCEPT;
    }

instruction:
    expression  {
        YYACCEPT;
    }
    | affectation {
      YYACCEPT;
    }

expression:
    operation {
        //Modifier cette partie pour prendre en compte la structure avec expressions
        std::cout << "#-> " << $1 << std::endl;
    }
    | text {
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

affectation:
    '=' { std::cout << "Affectation à réaliser" << std::endl;
    }

operation:
    NUMBER {
        $$ = $1;
    }
    | '(' operation ')' {
        $$ = $2;
    }
    | operation '+' operation {
        $$ = $1 + $3;
    }
    | operation '-' operation {
        $$ = $1 - $3;
    }
    | operation '*' operation {
        $$ = $1 * $3;
    }
    | operation '/' operation {
        $$ = $1 / $3;
    }
    | '-' operation %prec NEG {
        $$ = - $2;
    }

%%

void yy::Parser::error( const location_type &l, const std::string & err_msg) {
    std::cerr << "Erreur : " << l << ", " << err_msg << std::endl;
}
