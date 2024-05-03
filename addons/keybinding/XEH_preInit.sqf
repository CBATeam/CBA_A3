#include "script_component.hpp"
SCRIPT(XEH_preInit);

ADDON = false;

if (!hasInterface) exitWith {
    ADDON = true;
};

#include "XEH_PREP.hpp"

// Load DIK to string conversion table.
with uiNamespace do {
    GVAR(keyNames) = [GVAR(keyNamesHash)] call CBA_fnc_deserializeNamespace;
};

GVAR(keyNames) = uiNamespace getVariable QGVAR(keyNames);
GVAR(forbiddenKeys) = uiNamespace getVariable QGVAR(forbiddenKeys);

if (isNil QGVAR(addons)) then {
    GVAR(addons) = [] call CBA_fnc_createNamespace;
    GVAR(actions) = [] call CBA_fnc_createNamespace;
};

if (isNil QGVAR(modPrettyNames)) then {
    GVAR(modPrettyNames) = [] call CBA_fnc_createNamespace;
};

ADDON = true;
