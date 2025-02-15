#pragma once

#include "attribut.hh"

class Opacite : public Attribut {
    public:
    Opacite(std::string val) : Attribut(val){}
    std::string type() const override {return "opacity";}
};