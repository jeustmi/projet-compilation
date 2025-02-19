#include "variable.hh"

Variable::Variable(const std::string& nom) : _nom(nom) {}

std::string Variable::calculer(const Contexte & contexte) const {
    return contexte[_nom];
}

int Variable::toint(const Contexte & contexte) const {
    return std::atoi(contexte[_nom].c_str());
}