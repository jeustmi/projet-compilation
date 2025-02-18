#pragma once

#include <string>

class Text{
public:
    Text() =delete;
    Text(const Text &) = default;
    Text(std::string const & text) : _text(text) {}

    std::string calculer(/*const Contexte& contexte*/);

private:
    std::string _text;
};