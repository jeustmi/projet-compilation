#pragma once

#include "attribut.hh"

class Largeur : public Attribut{
    public:
    Largeur(std::string val) : Attribut(val){}
    std::string type() const override {return "width";}
};