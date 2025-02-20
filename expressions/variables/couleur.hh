/*#include "constante.hh"

class Couleur : public Expression<std::string> {
    public:
    Couleur(int v1,int v2,int v3): _v1(v1),_v2(v2),_v3(v3){}
    std::string calculer(const Contexte & contexte) const {return "";};
    int toint(const Contexte & contexte) const {return 0;};
    std::string to_string() const {std::string s="#";
        char c[10]; 
        sprintf(c,"%X",_v1/16);
        s+=c;
        sprintf(c,"%X",_v1%16);
        s+=c;
        sprintf(c,"%X",_v2/16);
        s+=c;
        sprintf(c,"%X",_v2%16);
        s+=c;
        sprintf(c,"%X",_v3/16);
        s+=c;
        sprintf(c,"%X",_v3%16);
        s+=c;
        return s;};
    std::string type() const {return "couleur";};
    private:
    int _v1;
    int _v2;
    int _v3;
};*/