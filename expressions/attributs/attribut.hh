#pragma once

#include <string>

class Attribut{
    public:
    Attribut()=default;
    Attribut(std::string val) : _val(val) {}
    virtual std::string type() const =0;
    std::string getVal() const {return _val;}
    void setVal(std::string val) {_val=val;}
    private:
    std::string _val;
};