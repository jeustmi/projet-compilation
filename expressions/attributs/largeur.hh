#pragma once

#include "attribut.hh"

class Largeur : public Attribut{
    public:
    Largeur()=default;
    Largeur(std::string val) : Attribut(val){}
    contexte_type contexte() const override {return contexte_type::integer;}
    std::string type() const override {return "width";}
};