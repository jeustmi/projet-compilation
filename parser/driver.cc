#include "driver.hh"
#include <iostream>

Driver::Driver() {}
Driver::~Driver() {}


const Contexte& Driver::getContexte() const {
    //TODO Retourne le contexte pour qu'il soit accessible en dehors de la classe Driver
    return _variables;
}

std::string Driver::getVariable(const std::string & name) const {
    //TODO Retourne la valeur de la variable name
    return _variables.get(name);
}

void Driver::setVariable(const std::string & name, std::string value) {
    //TODO Affecte une valeur à une variable avec l'utilisation du contexte variables
    _variables[name] = value;
}

