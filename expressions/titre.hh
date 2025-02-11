#pragma once

#include "bloc.hh"
#include "attribut.hh"
#include "text.hh"

#include <vector>

class Titre : public Bloc {
    public:
    Titre();
    private:
    int _niv;
    
};