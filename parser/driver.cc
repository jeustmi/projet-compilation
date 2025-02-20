#include "driver.hh"
#include <iostream>

const Contexte<int>& Driver::getContexteint() const {
    return _variablesint;
}

int Driver::getVariableint(const std::string & name) const {
    return _variablesint.get(name);
}

void Driver::setVariableint(const std::string & name, int value) {
    _variablesint[name] = value;
}

const Contexte<std::shared_ptr<Bloc>>& Driver::getContextebloc() const{
    return _variablesbloc;
}

std::shared_ptr<Bloc> Driver::getVariablebloc(const std::string& name) const{
    return _variablesbloc.get(name);
}

void Driver::setVariablebloc(const std::string& name, std::shared_ptr<Bloc> value){
    _variablesbloc[name] = value;
}

const   Contexte<std::string>& Driver::getContextecouleur() const{
    return _variablescouleur;
}

std::string  Driver::getVariablecouleur(const std::string& name) const{
    return _variablescouleur.get(name);
}

void    Driver::setVariablecouleur(const std::string& name, std::string value){
    _variablescouleur[name] = value;
}


const   Contexte<std::vector<std::shared_ptr<Attribut>>>& Driver::getContextestyle() const{
    return _variablesstyle;
}

std::vector<std::shared_ptr<Attribut>>  Driver::getVariablestyle(const std::string& name) const{
    return _variablesstyle.get(name);
}

void    Driver::setVariablestyle(const std::string& name, std::vector<std::shared_ptr<Attribut>> const & value){
    _variablesstyle[name] = value;
}
