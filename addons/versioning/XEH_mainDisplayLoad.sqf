#include "script_component.hpp"

with uiNamespace do {
    params ["_display"];

    #include "init_dependencies.sqf"

    0 call CBA_fnc_logVersion;
    call CBA_fnc_checkDependencies;
};
