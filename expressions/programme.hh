#pragma once
#include "commentaire.hh"
#include "blocs/bloc.hh"
#include "blocs/titre.hh"
#include "blocs/paragraphe.hh"
#include "blocs/image.hh"
#include "blocs/style.hh"

#include <vector>
#include <memory>

class Programme{
    public:
    Programme() = default;

    std::string creation_page();
    void addComm(const Commentaire & c){_comms.push_back(c);}
    void addBloc(const std::shared_ptr<Bloc> & b){_insts.push_back(b);}
    
    void addCss(const std::string & s){_defs._css.push_back(s);}
    void setTitre(const std::string & s){_defs._titre=s;}
    void setIcone(const std::string & s){_defs._icone=s;}
    void setEncodage(const std::string & s){_defs._encodage=s;}
    void setLangue(const std::string & s){_defs._langue=s;}

    void addStyle(Style const & s){_styles.push_back(s);}

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
    std::vector<Style> _styles;
};

struct objet{
    std::vector<std::shared_ptr<Attribut>> attr;
    std::string text;
};