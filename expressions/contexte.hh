#pragma once

#include <string>
#include <map>

template<typename t>
class Contexte {
private:
    std::map<std::string, t> variables;

public:
    Contexte() = default;
    Contexte(const Contexte & autre) = default;

    t& get(const std::string & nom);
    const t& get(const std::string & nom) const;

    t& operator[](const std::string & nom);
    const t& operator[](const std::string & nom) const;

};

template<typename t>
t& Contexte<t>::get(const std::string & nom) {
    return variables[nom];
}

template<typename t>
const t& Contexte<t>::get(const std::string & nom) const {
    return variables.at(nom);
}

template<typename t>
t& Contexte<t>::operator[](const std::string & nom) {
    return variables[nom];
}

template<typename t>
const t& Contexte<t>::operator[](const std::string & nom) const {
    return variables.at(nom);
}