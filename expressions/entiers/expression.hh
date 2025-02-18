#pragma once
#include "../contexte.hh"

#include <memory>
#include <string>

class ExpressionEntiere {
public:
    virtual int calculer(const Contexte & contexte)const = 0;
};

using ExpressionEntierePtr = std::shared_ptr<ExpressionEntiere>;

