#pragma once
#include "contexte.hh"

#include <memory>
#include <string>

class Expression {
public:
    virtual std::string calculer(/*const Contexte & contexte*/) = 0;
};

using ExpressionPtr = std::shared_ptr<Expression>;

