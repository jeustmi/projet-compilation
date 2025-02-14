#pragma once

#include "attribut.hh"
#include "hauteur.hh"
#include "text.hh"

#include <vector>
#include <memory>

class Bloc{
    public:
    Bloc(Text const & text) : _attr(),_text(text) {}
    Bloc(std::vector<std::shared_ptr<Attribut>> attr,Text const & text) : _attr(attr),_text(text) {}
    virtual std::string type() const =0; 
    std::string calculer() const;
    private:
    std::vector<std::shared_ptr<Attribut>> _attr;
    Text _text;
};