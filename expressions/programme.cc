#include "programme.hh"

#include <iostream>

std::string Programme::creation_page() {
    _page+="<!DOCTYPE html>";

    _page+="<html lang=\""+_defs._langue+"\">";
    _page.incTab();

    _page+="<head>";
    _page.incTab();

    _page+="<meta charset=\""+_defs._encodage+"\">";
    if(_defs._icone!=""){
        _page+="<link rel=\"icon\" type=\"image/jpg\" href=\""+_defs._icone+"\" />";
    }
    _page+="<title>"+_defs._titre+"</title>";

    _page.decTab();
    _page+="</head>";

    _page+="<body>";
    _page.incTab();

    for(auto c : _comms){
        _page+=c.calculer();
    }

    for(auto b : _insts){
        _page+=b->calculer();
    }

    _page.decTab();
    _page+="</body>";
    
    _page.decTab();
    _page+="</html>";


    std::cout<<"-------------------------------------------\n";
    std::cout<<_page.getCode()<<std::endl;
    return _page.getCode();
}