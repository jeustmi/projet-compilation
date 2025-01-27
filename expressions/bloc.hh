#pragma once

#include "attribut.hh"

#include <vector>
#include <memory>

class Bloc{
    public:
    Bloc();
    private:
    std::vector<std::shared_ptr<Attribut>> _attr;
};