#pragma once
#include "expression.hh"

template<typename t>
class Variable : public Expression<t> {
    public:
    Variable() = delete;
    Variable(const Variable &) = default;
    Variable(const std::string & nom):_nom(nom){};

    
    t calculer(const Contexte<t>& contexte) const override{
        return contexte[_nom];
    };
    std::string getSuffixe(const Contexte<t>& contexte) const override {return "";}

    private:
    std::string _nom;

};