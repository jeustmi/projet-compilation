#pragma once
#include "expression.hh"
#include "../blocs/bloc.hh"

class ConstanteBloc : public Expression<std::shared_ptr<Bloc>> {
    public:
    ConstanteBloc() = delete;
    ConstanteBloc(std::shared_ptr<Bloc> bloc): _bloc(bloc) {}


    std::shared_ptr<Bloc> calculer(const Contexte<std::shared_ptr<Bloc>>& contexte) const override;
    std::string to_string(const Contexte<std::shared_ptr<Bloc>>& contexte) const override {return "";}

    private:
    std::shared_ptr<Bloc> _bloc;
};