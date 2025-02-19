#pragma once
#include <memory>
#include "contexte.hh"


class Expression {
public:
    virtual std::string calculer(const Contexte & contexte) const = 0;
    virtual int toint(const Contexte & contexte) const = 0;

};

using ExpressionPtr = std::shared_ptr<Expression>;

