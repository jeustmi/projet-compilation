#pragma once

#include "bloc.hh"
#include "attribut.hh"
#include "text.hh"

#include <vector>

class Titre : public Bloc {
    public:
    Titre(Text const & text, int niv) : Bloc(text),_niv(niv) {}
    Titre(std::vector<std::shared_ptr<Attribut>> attr, Text const & text, int niv) : Bloc(attr,text),_niv(niv) {}
    std::string type() const override {return "h"+std::to_string(_niv);}
    private:
    int _niv;
    
};