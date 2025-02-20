#pragma once

#include "attribut.hh"

class CouleurFond : public Attribut {
    public:
    CouleurFond()=default;
    CouleurFond(std::string val) : Attribut(val){}
    std::string type() const override {return "background-color";}
};