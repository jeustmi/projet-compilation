#pragma once

#include <string>

class Attribut{
    public:
    Attribut();
    std::string getval() const {return _val;}
    private:
    std::string _val;
};