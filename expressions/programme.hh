#pragma once
#include "commentaire.hh"
#include "instruction.hh"

#include <vector>

class Definition;

class programme{
    public:
    programme();
    void creation_page();
    private:
    std::vector<Definition> _defs;
    std::vector<Instruction> _insts;
    std::vector<Commentaire> _comms;
};