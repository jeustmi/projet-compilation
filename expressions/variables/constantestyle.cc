#include "constantestyle.hh"

std::vector<std::shared_ptr<Attribut>> ConstanteStyle::calculer(const Contexte<std::vector<std::shared_ptr<Attribut>>> & contexte) const {
    return _attributs;
}