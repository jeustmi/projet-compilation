#include "variable.hh"

Variable::Variable(const std::string& nom) : _nom(nom) {}

std::string Variable::calculer(const Contexte & contexte) const {
    return contexte[_nom];
}