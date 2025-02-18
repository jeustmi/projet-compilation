#include "constante.hh"

Constante::Constante(std::string valeur) : _valeur(valeur) {}

std::string Constante::calculer(const Contexte & contexte) const {
    return _valeur;
}
 