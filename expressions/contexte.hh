#ifndef context_h
#define context_h

#include <string>
#include <map>

class Contexte {
private:
    std::map<std::string, std::string> variables;

public:
    Contexte() = default;
    Contexte(const Contexte & autre) = default;

    std::string& get(const std::string & nom);
    const std::string& get(const std::string & nom) const;

    std::string& operator[](const std::string & nom);
    const std::string& operator[](const std::string & nom) const;

};


#endif