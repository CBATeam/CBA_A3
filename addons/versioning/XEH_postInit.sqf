#include "script_component.hpp"
SCRIPT(XEH_postInit);

// Dependency check and warn
call CBA_fnc_checkDependencies;
