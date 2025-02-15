#include "bloc.hh"
#include <iostream>

std::string Bloc::calculer() const {
    std::string ret;
    ret="<"+type();
    if(!_attr.empty()){
        ret+=" style=\"";
        for(auto a : _attr){
            ret+=a->type()+":"+a->getVal()+"; ";
        }
        ret+="\"";
    }
    if(type()!="img"){
        ret+=">";
        ret+=_text;
        ret+="</"+type()+">";
    }
    else{
        ret+=" src=\""+_text+"\">";
    }
    return ret;
}