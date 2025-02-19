#pragma once
#include <string>
#include "expression.hh"


template <typename t>
class Variable : public Expression<t> {
public:
    Variable() = delete;
    Variable(const Variable &) = default;
    Variable(const std::string & nom);
    

    Variable::Variable(const std::string& nom) : _nom(nom) {}

    t Variable::calculer(const Contexte & contexte) const override{
        if(t==int){
            return std::atoi((contexte[_nom]).c_str());
        }
        else{
            return contexte[_nom];
        }
    }


private:
    std::string _nom;
};
