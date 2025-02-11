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
    Programme prog;
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
%token                  FOR
%token                  END
%token <std::string>    ID
%token <int>            TITR
%token <std::string>    TEXT
%token <std::string>    HEXANUMBER
%token                  RGB
%token                  WIDTH
%token                  HEIGHT
%token                  TEXTCOLOR
%token                  BACKGROUNDCOLOR
%token                  OPACITY




%type <std::string> objet
//%type <ExpressionPtr> commentaire
%type <std::string> texte
%type <int> taille
%type <int> ratio
%left '-' '+'
%left '*' '/'

%%

programme:
    code{
        prog.creation_page();
        YYACCEPT;
    }

code:
    instruction NL code {

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
    ID '=' NUMBER{

    }
    |ID '=' couleur{

    }
    |ID '=' bloc{

    }
    |ID '=' style{

    }

conditionelle:
    IF '(' condition ')' ':' code ENDIF
    |IF '(' condition ')' ':' code ELSE ':' code ENDIF

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

boucle:
    FOR ID '['NUMBER','NUMBER']' '+'NUMBER ':' code END{

    }
    |FOR ID '['NUMBER','NUMBER']' '-'NUMBER ':' code END{

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
    | STYLE '(' PAGE ')' style{

    }
    | STYLE '(' PARA ')' style{
        
    }
    | STYLE '(' TITR ')' style{
        
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
        $$=$1;
    }
    |  style texte{
        $$=$2;
    }

style:
    '['atributs']' {

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
    /*'#' HEXANUMBER {
        
    }*/
    HEXANUMBER {
        
    }
    |RGB '('NUMBER','NUMBER','NUMBER')'

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

void yy::Parser::error( const location_type &l, const std::string & err_msg) {
    std::cerr << "Erreur : " << l << ", " << err_msg << std::endl;
}