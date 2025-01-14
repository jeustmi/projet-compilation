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
fin return token::END;

"+" return '+';
"*" return '*';
"-" return '-';
"/" return '/';
"(" return '(';
")" return ')';
"{" return '{';
"}" return '}';
"=" return '=';

\@DEFINE {
    return token::DEFINITION;
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

(encodage)|(icone)|(css)|(langue) {
    return token::PARAGRAPH;
}

\%\%.*\n {
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
