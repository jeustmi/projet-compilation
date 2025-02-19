#include "constante.hh"

Constante::Constante(std::string valeur) : _valeur(valeur) {}
Constante::Constante(int valeur) : _valeur(std::to_string(valeur)) {}


std::string Constante::calculer(const Contexte & contexte) const {
    return _valeur;
}

int Constante::toint(const Contexte & contexte) const {
    return std::atoi(_valeur.c_str());
}