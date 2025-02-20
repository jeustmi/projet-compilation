#pragma once
#include "expression.hh"

class ConstanteCouleur : public Expression<std::string> {
    public:
    ConstanteCouleur() = delete;
    ConstanteCouleur(std::string couleur) : _couleur(couleur) {}


    std::string calculer(const Contexte<std::string>& contexte) const override;
    std::string to_string(const Contexte<std::string>& contexte) const override {return "";}


    private:
    std::string _couleur;
};