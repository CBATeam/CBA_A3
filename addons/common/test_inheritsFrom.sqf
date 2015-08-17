// ----------------------------------------------------------------------------

#include "script_component.hpp"

SCRIPT(test_inheritsFrom);

// ----------------------------------------------------------------------------

private ["_class", "_base", "_expected", "_result", "_fn", "_game", "_clssname"];

_fn = "CBA_fnc_inheritsFrom";
ASSERT_DEFINED("CBA_fnc_inheritsFrom","");

LOG("Testing " + _fn);

/*
Game as integer from SLX_XEH_MACHINE
0 = Arma2
1 = Arma2 OA
2 = TOH
3 = Arma3
*/
_game = SLX_XEH_MACHINE select 14;

if (_game > 3) then {
    LOG ("FIXME! - Unknown game " + (SLX_XEH_MACHINE select 15) + ". All assert tests will fail! " + _fn); //Sanity check and reminder
    Diag_log ("FIXME! - Unknown game " + (SLX_XEH_MACHINE select 15) + ". All assert tests will fail! " + _fn);
};

if (_game < 2) then {
    _clssname = "m16a4_acg_gl"; //Arma2 variants
    } else {
    if (_game == 2) then {
        _clssname = "M4A1_H"; //TOH
    } else {
        _clssname = "arifle_MXC_F"; //Arma3
    };
};

_class = configFile >> "CfgWeapons" >> _clssname;
_base = configFile >> "CfgWeapons" >> "RifleCore";
_result = [_class, _base] call CBA_fnc_inheritsFrom;
ASSERT_TRUE(_result,_fn);

_class = configFile >> "CfgWeapons" >> "RifleCore";
_base = configFile >> "CfgWeapons" >> _clssname;
_result = [_class, _base] call CBA_fnc_inheritsFrom;
ASSERT_FALSE(_result,_fn);

_class = configFile >> "CfgWeapons" >> _clssname;
_base = configFile >> "CfgWeapons" >> "PistolCore";
_result = [_class, _base] call CBA_fnc_inheritsFrom;
ASSERT_FALSE(_result,_fn);

nil;
