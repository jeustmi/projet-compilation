#include "driver.hh"
#include <iostream>

const Contexte<int>& Driver::getContexteint() const {
    return _variables_int;
}

int Driver::getVariableint(const std::string & name) const {
    return _variables_int.get(name);
}

void Driver::setVariableint(const std::string & name, int value) {
    _variables_int[name] = value;
}

const Contexte<std::shared_ptr<Bloc>>& Driver::getContextebloc() const{
    return _variables_bloc;
}

std::shared_ptr<Bloc> Driver::getVariablebloc(const std::string& name) const{
    return _variables_bloc.get(name);
}

void Driver::setVariablebloc(const std::string& name, std::shared_ptr<Bloc> value){
    _variables_bloc[name] = value;
}

const   Contexte<std::string>& Driver::getContextecouleur() const{
    return _variables_couleur;
}

std::string  Driver::getVariablecouleur(const std::string& name) const{
    return _variables_couleur.get(name);
}

void    Driver::setVariablecouleur(const std::string& name, std::string value){
    _variables_couleur[name] = value;
}


const   Contexte<std::vector<std::shared_ptr<Attribut>>>& Driver::getContextestyle() const{
    return _variables_style;
}

std::vector<std::shared_ptr<Attribut>>  Driver::getVariablestyle(const std::string& name) const{
    return _variables_style.get(name);
}

void    Driver::setVariablestyle(const std::string& name, std::vector<std::shared_ptr<Attribut>> const & value){
    _variables_style[name] = value;
}
