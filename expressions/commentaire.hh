#pragma once

#include <string>

class Commentaire{
public:
    Commentaire() = delete;
    Commentaire(const Commentaire &) = default;
    Commentaire(std::string const & comm) : _comm(comm) {}

    std::string calculer(/*const Contexte& contexte*/);

private:
    std::string _comm;
};