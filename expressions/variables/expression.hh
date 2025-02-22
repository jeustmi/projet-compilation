#pragma once
#include <memory>
#include "../contexte.hh"

template<typename t>
class Expression {
public:
    virtual t calculer(const Contexte<t> & contexte) const = 0;
    virtual std::string getSuffixe(const Contexte<t> & contexte) const = 0;
};


