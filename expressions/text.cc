#include "text.hh"

std::string Text::calculer(/*const Contexte& contexte*/) {
    _text.erase(0,1);
    _text.erase(_text.length()-1,1);
    for(long unsigned int i=0; i<_text.length();++i){
        if(_text[i]=='\\' and _text[i+1]=='\''){
            _text.erase(i,1);
            --i;
        }
    }
    return _text;
}