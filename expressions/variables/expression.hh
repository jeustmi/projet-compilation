#pragma once
#include <memory>
#include "../contexte.hh"

template<typename t>
class Expression {
public:
    virtual t calculer(const Contexte<t> & contexte) const = 0;
    virtual std::string to_string(const Contexte<t> & contexte) const = 0;
};


