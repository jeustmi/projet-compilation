#pragma once
#include "expression.hh"

#include <string>

class ExpressionText : public Expression {
public:
    ExpressionText() =delete;
    ExpressionText(const ExpressionText &) = default;
    ExpressionText(std::string const & text) : _text(text) {}

    std::string calculer(/*const Contexte& contexte*/) override;

private:
    std::string _text;
};