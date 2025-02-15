#include "commentaire.hh"
#include <iostream>
std::string Commentaire::calculer() {
    while(_comm[0]=='%'){
        _comm.erase(0,1);
    }
    int i=_comm.length()-1;
    if(_comm[i]=='\n'){
        _comm.erase(i,1);
    }
    while(_comm[i]=='%'){
        _comm.erase(i,1);
        --i;
    }
    return "<!--"+_comm+"-->";
}