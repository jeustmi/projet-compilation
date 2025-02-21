#pragma once

#include <string>

#include "contexte.hh"
#include "../expressions/blocs/bloc.hh"
#include "../expressions/blocs/style.hh" //souprim

class Driver {
private:
    Contexte<int> _variables_int;
    Contexte<std::shared_ptr<Bloc>> _variables_bloc;
    Contexte<std::string> _variables_couleur;
    Contexte<std::vector<std::shared_ptr<Attribut>>> _variables_style;

public:
    Driver() = default;
    Driver(Driver const & driver)= default;

    const   Contexte<int>& getContexteint() const;
    int  getVariableint(const std::string& name) const;
    void    setVariableint(const std::string& name, int value);

    const   Contexte<std::shared_ptr<Bloc>>& getContextebloc() const;
    std::shared_ptr<Bloc> getVariablebloc(const std::string& name) const;
    void    setVariablebloc(const std::string& name, std::shared_ptr<Bloc> value);

    const   Contexte<std::string>& getContextecouleur() const;
    std::string  getVariablecouleur(const std::string& name) const;
    void    setVariablecouleur(const std::string& name, std::string value);

    const   Contexte<std::vector<std::shared_ptr<Attribut>>>& getContextestyle() const;
    std::vector<std::shared_ptr<Attribut>> getVariablestyle(const std::string& name) const;
    void    setVariablestyle(const std::string& name, std::vector<std::shared_ptr<Attribut>> const & value);
};

