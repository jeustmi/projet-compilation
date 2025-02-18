#pragma once
#include <string>
#include "expression.hh"



class Variable : public ExpressionCouleur {
public:
    Variable() = delete;
    Variable(const Variable &) = default;
    Variable(const std::string & nom);
    
    std::string calculer(const Contexte& contexte) const override;


private:
    std::string _nom;
};
