#pragma once

#include "bloc.hh"
#include "attributs/attribut.hh"

#include <vector>

class Image : public Bloc {
    public:
    //Titre(std::string const & text, int niv) : Bloc(text),_niv(niv) {}
    Image(std::vector<std::shared_ptr<Attribut>> const & attr, std::string const & text) : Bloc(attr,text) {}
    std::string type() const override {return "img";}
};