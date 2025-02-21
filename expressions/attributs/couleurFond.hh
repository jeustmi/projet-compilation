#pragma once

#include "attribut.hh"

class CouleurFond : public Attribut {
    public:
    CouleurFond()=default;
    CouleurFond(std::string val) : Attribut(val){}
    contexte_type contexte() const override {return contexte_type::couleur;}
    std::string type() const override {return "background-color";}
};