#pragma once
#include "expression.hh"

#include <string>

class ExpressionComm : public Expression {
public:
    ExpressionComm() = delete;
    ExpressionComm(const ExpressionComm &) = default;
    ExpressionComm(std::string const & comm) : _comm(comm) {}

    std::string calculer(/*const Contexte& contexte*/) override;

private:
    std::string _comm;
};