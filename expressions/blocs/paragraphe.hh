#pragma once

#include "bloc.hh"
#include "../attributs/attribut.hh"

#include <vector>

class Paragraphe : public Bloc {
    public:
    //Titre(std::string const & text, int niv) : Bloc(text),_niv(niv) {}
    Paragraphe(std::vector<std::shared_ptr<Attribut>> const & attr, std::string const & text) : Bloc(attr,text) {}
    std::string type() const override {return "p";}
};