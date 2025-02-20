#include "variablebloc.hh"

VariableBloc::VariableBloc(const std::string& nom) : _nom(nom) {}

std::shared_ptr<Bloc> VariableBloc::calculer(const Contexte<std::shared_ptr<Bloc>> & contexte) const {
    return contexte[_nom];
}