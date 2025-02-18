#pragma once
#include <string>
#include "expression.hh"



class Variable : public ExpressionEntiere {
public:
    Variable() = delete;
    Variable(const Variable &) = default;
    Variable(const std::string & nom);
    
    int calculer(const Contexte& contexte) const override;


private:
    std::string _nom;
};
