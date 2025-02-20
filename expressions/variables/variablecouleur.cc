#include "variablecouleur.hh"

VariableCouleur::VariableCouleur(const std::string& nom) : _nom(nom) {}

std::string VariableCouleur::calculer(const Contexte<std::string> & contexte) const {
    return contexte[_nom];
}