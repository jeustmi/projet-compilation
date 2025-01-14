#include "commentaire.hh"

std::string ExpressionComm::calculer() {
    int i=0;
    while(_comm[i]=='%'){
        _comm[i]='\0';
        ++i;
    }
    i=_comm.length()-1;
    if(_comm[i]=='\n'){
        _comm[i]='\0';
    }
    while(_comm[i]=='%'){
        _comm[i]='\0';
        --i;
    }
    return "<!--"+_comm+"-->";
}