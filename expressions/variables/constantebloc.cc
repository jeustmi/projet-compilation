#include "constantebloc.hh"

std::shared_ptr<Bloc> ConstanteBloc::calculer(const Contexte<std::shared_ptr<Bloc>> & contexte) const {
    return _bloc;
}