#include "parser.hpp"
#include "scanner.hh"
#include "driver.hh"

#include <iostream>
#include <fstream>

#include <cstring>

int main( int  argc, char* argv[]) {
    Driver * driver = new Driver;
    Scanner * scanner = new Scanner(std::cin, std::cout);
    Programme * programme = new Programme; 
    yy::Parser * parser = new yy::Parser(*scanner, *driver, *programme);

    parser->parse();

    std::ofstream fic("page.html");
    if(fic){
        fic<<programme->creation_page();
    }


    return 0;
}
