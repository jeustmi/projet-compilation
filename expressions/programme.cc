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

    for( auto s : _styles){
        std::cout<<s.type()<<std::endl;
        if(s.type()=="all"){
            for(auto b : _insts){
                b->setAttr(s.getAttr());
            }
        }
        else{
            for(auto b : _insts){
                if(s.type()==b->type()){
                    b->setAttr(s.getAttr());
                }
                /*if(s.type()=="p"){

                }
                else if(s.type()[0]=='h'){
                    for(int i = 0; i<10; ++i){
                        if(s.type()=="h"+std::to_string(i)){
                            
                        }
                    }
                }*/
            }
        }
        
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