#pragma once
#include "expression.hh"

class Constante : public ExpressionCouleur {
public:
    Constante() = delete;
    Constante(const Constante&) = default;
    Constante(double valeur);


    std::string calculer(const Contexte& contexte) const override;

private:
    int _valeur;
};
