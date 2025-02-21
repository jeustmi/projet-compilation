#pragma once

#include <string>

class Attribut{
    public:
    enum class contexte_type{
        integer,
        couleur
    };
    public:
    Attribut()=default;
    Attribut(std::string val) : _val(val),_variable(false) {}
    Attribut(std::string val, bool var) : _val(val),_variable(var) {}
    virtual std::string type() const =0;
    std::string getVal() const {return _val;}
    void setVal(std::string val) {_val=val;}
    virtual contexte_type contexte() const=0;
    bool variable()const {return _variable;}
    private:
    std::string _val;
    bool _variable;
};