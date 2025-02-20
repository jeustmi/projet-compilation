#pragma once
#include "bloc.hh"

class Style : public Bloc {
    public:
    Style(std::vector<std::shared_ptr<Attribut>> const & attr,std::string const & text) : Bloc(attr,text) {}
    std::vector<std::shared_ptr<Attribut>> getAttr() const {return _attr;}
};