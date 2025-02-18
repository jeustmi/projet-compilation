#pragma once
#include "expression.hh"

class Constante : public ExpressionCouleur {
public:
    Constante() = delete;
    Constante(const Constante&) = default;
    Constante(std::string valeur);


    std::string calculer(const Contexte& contexte) const override;

private:
    std::string _valeur;
};
