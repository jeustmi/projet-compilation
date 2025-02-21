#pragma once

#include "bloc.hh"
#include "../attributs/attribut.hh"

#include <vector>

class Titre : public Bloc {
    public:
    //Titre(std::string const & text, int niv) : Bloc(text),_niv(niv) {}
    Titre(std::vector<std::shared_ptr<Attribut>> const & attr, std::string const & text, int niv) : Bloc(attr,text),_niv(niv) {}
    std::string type() const override {return "h"+std::to_string(_niv);}
    private:
    int _niv;
    
};