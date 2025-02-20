#pragma once
#include "expression.hh"
#include "../blocs/bloc.hh"

class VariableBloc : public Expression<std::shared_ptr<Bloc>> {
    public:
    VariableBloc() = delete;
    VariableBloc(const VariableBloc &) = default;
    VariableBloc(const std::string & nom);
    
    std::shared_ptr<Bloc> calculer(const Contexte<std::shared_ptr<Bloc>>& contexte) const override;
    std::string to_string(const Contexte<std::shared_ptr<Bloc>>& contexte) const override {return "";}

    private:
    std::string _nom;
};