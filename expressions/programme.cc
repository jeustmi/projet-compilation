#include "programme.hh"

#include <iostream>

void Programme::creation_page() {
    _page+="<!DOCTYPE html>";

    _page+="<html lang=\""+_defs._langue+"\">";
    _page.incTab();

    _page+="<head>";
    _page.incTab();

    _page+="<meta charset=\""+_defs._encodage+"\">";
    if(_defs._icone!=""){
        _page+="<link rel=\"icon\" type=\"image/jpg\" href=\""+_defs._icone+"\" />";
    }
    _page+="<titre>"+_defs._titre+"</titre>";

    _page.decTab();
    _page+="</head>";

    _page+="<body>";
    _page.incTab();

    for(auto e : _comms){
        _page+=e.calculer();
    }

    _page.decTab();
    _page+="</body>";
    
    _page.decTab();
    _page+="</html>";


    std::cout<<"-------------------------------------------\n";
    std::cout<<_page.getCode()<<std::endl;
}