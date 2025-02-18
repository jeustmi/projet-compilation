#pragma once
#include "expression.hh"

class Constante : public ExpressionEntiere {
public:
    Constante() = delete;
    Constante(const Constante&) = default;
    Constante(double valeur);


    int calculer(const Contexte& contexte) const override;

private:
    int _valeur;
};
