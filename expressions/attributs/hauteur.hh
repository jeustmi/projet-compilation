#pragma once

#include "attribut.hh"

class Hauteur : public Attribut {
    public:
    Hauteur()=default;
    Hauteur(std::string val) : Attribut(val) {}
    contexte_type contexte() const override {return contexte_type::integer;}
    std::string type() const override{return "height";}
};