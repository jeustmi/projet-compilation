#pragma once

#include "attribut.hh"

class CouleurTexte : public Attribut {
    public:
    CouleurTexte()=default;
    CouleurTexte(std::string val) : Attribut(val){}
    contexte_type contexte() const override {return contexte_type::couleur;}
    std::string type() const override {return "color";}
};