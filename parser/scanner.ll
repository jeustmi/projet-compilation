%{

#include "scanner.hh"
#include <cstdlib>

#define YY_NO_UNISTD_H

using token = yy::Parser::token;

#undef  YY_DECL
#define YY_DECL int Scanner::yylex( yy::Parser::semantic_type * const lval, yy::Parser::location_type *loc )

/* update location on matching */
#define YY_USER_ACTION loc->step(); loc->columns(yyleng);

%}

%option c++
%option yyclass="Scanner"
%option noyywrap

%%
%{
    yylval = lval;
%}

"+" return '+';
"*" return '*';
"-" return '-';
"/" return '/';
"(" return '(';
")" return ')';
"{" return '{';
"}" return '}';
"[" return '[';
"]" return ']';
"=" return '=';
"," return ',';
":" return ':';
"px" return 'p';
"%" return 'p';

[0-9]+      {
    yylval->build<int>(std::atoi(YYText()));
    return token::NUMBER;
}

\@DEFINE {
    return token::DEFINITION;
}

\@TITREPAGE {
    return token::TITREPAGE;
}

\!T+ {
yylval->build<int>(YYLeng()-1);
return token::TITRE;
}

\'([^']|\\\')*\' {
    yylval->build<std::string>(YYText());
    return token::TEXT;
}

\!P {
return token::PARAGRAPH;
}

\!I {
return token::IMAGE;
}

encodage {
    return token::ENCODAGE;
}


langue {
    return token::LANG;
}


icone {
    return token::ICON;
}

css {
    return token::CSS;
}

largeur {
    return token::WIDTH;
}

hauteur {
    return token::HEIGHT;
}

couleurTexte {
    return token::TEXTCOLOR;
}

couleurFond {
    return token::BACKGROUNDCOLOR;
}

opacité {
    return token::OPACITY;
}

\%\%.* {
    yylval->build<std::string>(YYText());
    return token::COMMENTAIRE;
}

\%\%\%(%{0,2}[^%])*\%\%\%    {
    yylval->build<std::string>(YYText());
    return token::COMMENTAIRE;
}

"\n"          {
    loc->lines();
    return token::NL;
}

%%
