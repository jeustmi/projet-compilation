#pragma once
#include "commentaire.hh"
#include "bloc.hh"
//#include "definition.hh"

#include <vector>
#include <memory>

/*using css = Definition;
using titre = Definition;
using icone = Definition;
using encodage = Definition;
using langue = Definition;*/

class Programme{
    public:
    Programme() = default;

    void creation_page();
    void addComm(const Commentaire & c){_comms.push_back(c);}
    
    void addCss(const std::string & s){_defs._css.push_back(s);}
    void setTitre(const std::string & s){_defs._titre=s;}
    void setIcone(const std::string & s){_defs._icone=s;}
    void setEncodage(const std::string & s){_defs._encodage=s;}
    void setLangue(const std::string & s){_defs._langue=s;}

    class Page{
        public:
        Page() = default;

        Page & operator+=(const std::string & str){
            for(int i=0;i<_tab;++i){
                _code+="\t";
            }
            _code+=str;
            _code+="\n";
            return *this;
        }

        void incTab(){++_tab;}
        void decTab(){--_tab;}

        std::string getCode() const {return _code;} 

        private:
        std::string _code{""};
        int _tab{0};
    };

    private:
    Page _page;
    struct defs{
        std::vector<std::string> _css;
        std::string _titre{""};
        std::string _icone{""};
        std::string _encodage{"utf-8"};
        std::string _langue{"fr"};
    } _defs;
    std::vector<Commentaire> _comms;
    std::vector<std::shared_ptr<Bloc>> _insts;
};