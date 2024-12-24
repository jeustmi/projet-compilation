#include "text.hh"

ExpressionText::ExpressionText(std::string const & text):
    _text(text) {

    }

std::string ExpressionText::calculer(/*const Contexte& contexte*/) {
    _text[0]='\0';
    _text[_text.length()-1]='\0';
    for(int i=0; i<_text.length();++i){
        if(_text[i]=='\\' and _text[i+1]=='\''){
            _text[i]='\0';
        }
    }
    return _text;
}