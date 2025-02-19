#pragma once
#include "expression.hh"

template <typename t>
class Constante : public Expression<t> {
public:
    Constante() = delete;
    Constante(const Constante&) = default;
    Constante(t valeur);

    Constante::Constante(t valeur) : _valeur(valeur) {}

    t Constante::calculer(const Contexte & contexte) const override{
        return _valeur;
    }

private:
    t _valeur;
};
