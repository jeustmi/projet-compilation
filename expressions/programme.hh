#pragma once
#include "commentaire.hh"
#include "bloc.hh"

#include <vector>
#include <memory>

class Definition;

class programme{
    public:
    programme();
    void creation_page();
    private:
    std::vector<Definition> _defs;
    std::vector<Commentaire> _comms;
    std::vector<std::shared_ptr<Bloc>> _insts;
};