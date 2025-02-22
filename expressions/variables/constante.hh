#pragma once
#include "expression.hh"
#include "../blocs/bloc.hh"

template<typename t>
class Constante : public Expression<t> {
    public:
    Constante() = delete;
    Constante(t val): _val(val) ,_suffixe(""){}
    Constante(t val,const std::string & s ): _val(val),_suffixe(s){}



    t calculer(const Contexte<t>& contexte) const override {return _val;}
    std::string getSuffixe(const Contexte<t>& contexte) const override {return _suffixe;}

    private:
    t _val;
    std::string _suffixe;
};