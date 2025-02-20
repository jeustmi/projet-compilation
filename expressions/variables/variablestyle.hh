#pragma once
#include "expression.hh"
#include <vector>
#include "../attributs/attribut.hh"


class VariableStyle : public Expression<std::vector<std::shared_ptr<Attribut>>> {
public:
    VariableStyle() = delete;
    VariableStyle(const VariableStyle &) = default;
    VariableStyle(const std::string & nom);
    
    std::vector<std::shared_ptr<Attribut>> calculer(const Contexte<std::vector<std::shared_ptr<Attribut>>>& contexte) const override;
    std::string to_string(const Contexte<std::vector<std::shared_ptr<Attribut>>>& contexte) const override {return "";}

private:
    std::string _nom;
};
