#pragma once

#include "attribut.hh"

class Opacite : public Attribut {
    public:
    Opacite()=default;
    Opacite(std::string val) : Attribut(val){}
    std::string type() const override {return "opacity";}
};