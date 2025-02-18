#pragma once
#include "../contexte.hh"

#include <memory>
#include <string>

class ExpressionCouleur {
public:
    virtual std::string calculer(const Contexte & contexte) = 0;
};

using ExpressionCouleurPtr = std::shared_ptr<ExpressionCouleur>;

