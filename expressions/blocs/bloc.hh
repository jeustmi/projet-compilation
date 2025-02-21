#pragma once

#include "../attributs/attribut.hh"
#include "../attributs/hauteur.hh"
#include "../attributs/largeur.hh"
#include "../attributs/couleurFond.hh"
#include "../attributs/couleurTexte.hh"
#include "../attributs/opacite.hh"
#include "../../parser/driver.hh" 


#include <vector>
#include <memory>
class Style;


class Bloc{

    public:
    //Bloc(std::string const & text) : _attr(),_text(text) {}
    Bloc(std::vector<std::shared_ptr<Attribut>> const & attr,std::string const & text) : _attr(attr),_text(text) {}
    bool operator==(Bloc const & b) const {return (_attr==b._attr) & (_text==b._text);}
    bool operator!=(Bloc const & b) const {return (_attr!=b._attr) | (_text!=b._text);}
    virtual std::string type() const {return _text;}; 
    std::string calculer(const Driver & d) const;
    void setAttributs(std::vector<std::shared_ptr<Attribut>> attr) {_attr=attr;}
    void addAttribut(std::shared_ptr<Attribut> attr) {_attr.push_back(attr);}
    private:
    std::vector<std::shared_ptr<Attribut>> _attr;
    std::string _text;
    friend Style;
};