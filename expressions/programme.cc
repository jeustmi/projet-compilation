#include "programme.hh"

#include <iostream>

std::string Programme::creation_page(const Driver & d) {
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
    _page+=calculer(d);

    _page.decTab();
    _page+="</body>";
    
    _page.decTab();
    _page+="</html>";


    std::cout<<"-------------------------------------------\n";
    std::cout<<_page.getCode()<<std::endl;
    return _page.getCode();
}

std::string Programme::calculer(const Driver & d) {
    Page ret;
    for(auto c : _comms){
        ret+=c;
    }

    for( auto s : _styles){
        if(s.type()=="all"){
            for(auto b : _insts){
                b->setAttributs(s.getAttributs());
            }
        }
        else{
            for(auto b : _insts){
                if(s.type()==b->type()){
                    b->setAttributs(s.getAttributs());
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
        ret+=b->calculer(d);
    }
    return ret.getCode();
}



std::shared_ptr<Titre> Programme::getTitre(int i){
    int j=0;
    for(auto b : _insts){
        if(b->type()[0]=='h'){
            if(i==j){
                return std::dynamic_pointer_cast<Titre>(b);
            }
            else{
                ++j;
            }
        }
    }
    throw std::out_of_range ("Pas de titre d'indice "+std::to_string(i));
}

std::shared_ptr<Paragraphe> Programme::getParagraphe(int i){
    int j=0;
    for(auto b : _insts){
        if(b->type()=="p"){
            if(i==j){
                return std::dynamic_pointer_cast<Paragraphe>(b);
            }
            else{
                ++j;
            }
        }
    }
    throw std::out_of_range ("Pas de paragraphe d'indice "+std::to_string(i));
}

std::shared_ptr<Image> Programme::getImage(int i){
    int j=0;
    for(auto b : _insts){
        if(b->type()=="img"){
            if(i==j){
                return std::dynamic_pointer_cast<Image>(b);
            }
            else{
                ++j;
            }
        }
    }
    throw std::out_of_range ("Pas d'image d'indice "+std::to_string(i));
}