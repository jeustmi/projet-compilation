#pragma once

#include "attribut.hh"
#include "text.hh"

#include <vector>
#include <memory>

class Bloc{
    public:
    Bloc() = default;
    private:
    std::vector<std::shared_ptr<Attribut>> _attr;
    Text _text;
};