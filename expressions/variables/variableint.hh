#pragma once
#include "expression.hh"



class VariableInt : public Expression<int> {
public:
    VariableInt() = delete;
    VariableInt(const VariableInt &) = default;
    VariableInt(const std::string & nom);
    
    int calculer(const Contexte<int>& contexte) const override;
    std::string to_string(const Contexte<int>& contexte) const override {return std::to_string(calculer(contexte))+"px";}

private:
    std::string _nom;
};
