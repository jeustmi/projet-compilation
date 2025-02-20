#include "variablestyle.hh"

VariableStyle::VariableStyle(const std::string& nom) : _nom(nom) {}

std::vector<std::shared_ptr<Attribut>> VariableStyle::calculer(const Contexte<std::vector<std::shared_ptr<Attribut>>> & contexte) const {
    return contexte[_nom];
}