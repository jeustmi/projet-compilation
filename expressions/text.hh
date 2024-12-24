#pragma once
#include "expression.hh"

class ExpressionText {
public:
    ExpressionText() = delete;
    ExpressionText(const ExpressionText &) = default;
    ExpressionText(std::string const & text);

    std::string calculer(/*const Contexte& contexte*/);

private:
    std::string _text;
};