#include "constanteint.hh"

ConstanteInt::ConstanteInt(int valeur) : _valeur(valeur),_suffixe("") {}
ConstanteInt::ConstanteInt(int valeur, std::string suffixe) : _valeur(valeur),_suffixe(suffixe) {}


int ConstanteInt::calculer(const Contexte<int> & contexte) const {
    return _valeur;
}