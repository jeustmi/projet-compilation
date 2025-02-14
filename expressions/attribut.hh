#pragma once

#include <string>

class Attribut{
    public:
    Attribut(std::string val) : _val(val) {}
    std::string getval() const {return _val;}
    private:
    std::string _val;
};