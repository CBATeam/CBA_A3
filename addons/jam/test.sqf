#define DEBUG_MODE_FULL
#include "script_component.hpp"
// ----------------------------------------------------------------------------
// execVM "x\cba\addons\jam\test.sqf"

LOG("=== Testing Jam ===");

private _wellsChecked = [];
{
    private _wpnCfg = _x;
    private _xWellArray = getArray (_wpnCfg >> "magazineWell");
    {
        if ((_wellsChecked pushBackUnique _x) > -1) then {
            if (isNull (configFile >> "CfgMagazineWells" >> _x)) then {
                diag_log text format ["ERROR: Well [%1] not valid, used in [%2]", _x,configName _wpnCfg];
            };
        };
    } forEach _xWellArray;
} forEach (configProperties [configFile >> "CfgWeapons", "(isClass _x) && {2 == getNumber (_x >> 'scope')}"]);

nil;
