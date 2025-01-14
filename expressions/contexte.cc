#include "contexte.hh"

std::string& Contexte::get(const std::string & nom) {
    return variables[nom];
}

const std::string& Contexte::get(const std::string & nom) const {
    return variables.at(nom);
}

std::string& Contexte::operator[](const std::string & nom) {
    return variables[nom];
}

const std::string& Contexte::operator[](const std::string & nom) const {
    return variables.at(nom);
}