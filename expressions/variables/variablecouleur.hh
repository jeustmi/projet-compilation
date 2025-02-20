#pragma once
#include "expression.hh"

class VariableCouleur : public Expression<std::string> {
    public:
    VariableCouleur() = delete;
    VariableCouleur(const VariableCouleur &) = default;
    VariableCouleur(const std::string & nom);

    std::string calculer(const Contexte<std::string>& contexte) const override;
    std::string to_string(const Contexte<std::string>& contexte) const override {return "";}

    private:
    std::string _nom;
};