#pragma once
#include "../contexte.hh"

#include <memory>
#include <string>
template <typename t>
class Expression {
public:
    virtual t calculer(const Contexte & contexte)const = 0;
};

using ExpressionEntierePtr = std::shared_ptr<Expression<int>>;
using ExpressionEntierePtr = std::shared_ptr<Expression<int>>;
using ExpressionEntierePtr = std::shared_ptr<Expression<int>>;
using ExpressionEntierePtr = std::shared_ptr<Expression<int>>;

