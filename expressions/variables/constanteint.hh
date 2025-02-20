#pragma once
#include "expression.hh"

class ConstanteInt : public Expression<int> {
public:
    ConstanteInt() = delete;
    ConstanteInt(int valeur);
    ConstanteInt(int valeur,std::string suffixe);


    int calculer(const Contexte<int>& contexte) const override;
    std::string to_string(const Contexte<int>& contexte) const override {return std::to_string(calculer(contexte))+_suffixe;}


    private:
    int _valeur;
    std::string _suffixe;
};
