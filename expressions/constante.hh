#pragma once
#include "expression.hh"

class Constante : public Expression {
public:
    Constante() = delete;
    Constante(const Constante&) = default;
    Constante(std::string valeur);
    Constante(int valeur);


    std::string calculer(const Contexte& contexte) const override;
    int toint(const Contexte& contexte) const override;

private:
std::string _valeur;
};
