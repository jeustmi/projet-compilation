#pragma once
#include <string>
#include "expression.hh"



class Variable : public Expression {
public:
    Variable() = delete;
    Variable(const Variable &) = default;
    Variable(const std::string & nom);
    
    std::string calculer(const Contexte& contexte) const override;
    int toint(const Contexte& contexte) const override;
    


private:
    std::string _nom;
};
