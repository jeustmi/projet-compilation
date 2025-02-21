#pragma once

#include "attribut.hh"

class Opacite : public Attribut {
    public:
    Opacite()=default;
    Opacite(std::string val) : Attribut(val){}
    contexte_type contexte() const override {return contexte_type::integer;}
    std::string type() const override {return "opacity";}
};