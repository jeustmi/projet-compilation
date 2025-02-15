#pragma once

#include "attribut.hh"

class CouleurTexte : public Attribut {
    public:
    CouleurTexte(std::string val) : Attribut(val){}
    std::string type() const override {return "color";}
};