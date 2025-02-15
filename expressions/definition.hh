// supprimer

#pragma once

#include "text.hh"

class Definition{
    public:
    Definition() = delete;
    Definition(std::string text) : _text(text) {}

    std::string getText() const {return _text;}

    private:
    std::string _text;
};