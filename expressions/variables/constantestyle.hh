#pragma once
#include "expression.hh"
#include <vector>
#include "../attributs/attribut.hh"

class ConstanteStyle : public Expression<std::vector<std::shared_ptr<Attribut>>> {
    public:
    ConstanteStyle() = delete;
    ConstanteStyle(std::vector<std::shared_ptr<Attribut>> attributs) : _attributs(attributs) {}


    std::vector<std::shared_ptr<Attribut>> calculer(const Contexte<std::vector<std::shared_ptr<Attribut>>>& contexte) const override;
    std::string to_string(const Contexte<std::vector<std::shared_ptr<Attribut>>>& contexte) const override {return "";}


    private:
    std::vector<std::shared_ptr<Attribut>> _attributs;
};