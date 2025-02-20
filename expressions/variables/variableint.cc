#include "variableint.hh"

VariableInt::VariableInt(const std::string& nom) : _nom(nom) {}

int VariableInt::calculer(const Contexte<int> & contexte) const {
    return contexte[_nom];
}