#pragma once

#include <string>

class Attribut{
    public:
    Attribut(std::string val) : _val(val) {}
    virtual std::string type() const =0;
    std::string getVal() const {return _val;}
    private:
    std::string _val;
};