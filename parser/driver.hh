#ifndef DRIVER_H
#define DRIVER_H

#include <string>

#include "contexte.hh"

class Driver {
private:
    Contexte _variables;       

public:
    Driver();
    ~Driver();

    const   Contexte& getContexte() const;
    std::string  getVariable(const std::string& name) const;
    void    setVariable(const std::string& name, std::string value);
};

#endif
