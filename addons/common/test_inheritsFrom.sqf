// ----------------------------------------------------------------------------

#include "script_component.hpp"

SCRIPT(test_inheritsFrom);

// ----------------------------------------------------------------------------

private ["_class", "_base", "_expected", "_result", "_fn"];

_fn = "CBA_fnc_inheritsFrom";
ASSERT_DEFINED(_fn,_fn);

LOG("Testing " + _fn);

_class = configFile >> "CfgWeapons" >> "m16a4_acg_gl";
_base = configFile >> "CfgWeapons" >> "RifleCore";
_result = [_class, _base] call CBA_fnc_inheritsFrom;
ASSERT_TRUE(_result,_fn);

_class = configFile >> "CfgWeapons" >> "RifleCore";
_base = configFile >> "CfgWeapons" >> "m16a4_acg_gl";
_result = [_class, _base] call CBA_fnc_inheritsFrom;
ASSERT_FALSE(_result,_fn);

_class = configFile >> "CfgWeapons" >> "m16a4_acg_gl";
_base = configFile >> "CfgWeapons" >> "PistolCore"
_result = [_class, _base] call CBA_fnc_inheritsFrom;
ASSERT_FALSE(_result,_fn);

nil;
