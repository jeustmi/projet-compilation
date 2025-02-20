#pragma once

#include "attribut.hh"

class Hauteur : public Attribut {
    public:
    Hauteur()=default;
    Hauteur(std::string val) : Attribut(val) {}
    std::string type() const override{return "height";}
};