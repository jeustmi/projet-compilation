#pragma once

#include "attribut.hh"

class CouleurTexte : public Attribut {
    public:
    CouleurTexte()=default;
    CouleurTexte(std::string val) : Attribut(val){}
    std::string type() const override {return "color";}
};