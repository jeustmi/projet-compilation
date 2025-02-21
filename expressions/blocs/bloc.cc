#include "bloc.hh"
#include <iostream>

std::string Bloc::calculer(const Driver & d) const {
    std::string ret;
    ret="<"+type();
    if(!_attr.empty()){
        ret+=" style=\"";
        for(auto a : _attr){
            if(! a->variable()){
                ret+=a->type()+":"+a->getVal()+"; ";
            }
            else{
                switch (a->contexte())
                {
                case Attribut::contexte_type::integer:
                    ret+=a->type()+":"+std::to_string(d.getContexteint()[a->getVal()])+"; ";
                    break;
                
                case Attribut::contexte_type::couleur:
                    ret+=a->type()+":"+d.getContextecouleur()[a->getVal()]+"; ";
                    break;
                }
            }
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