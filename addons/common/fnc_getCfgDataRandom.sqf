#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getCfgDataRandom

Description:
    This function extracts data from a config property.
    If it is an Array, it will select a random entry from the array (nil if empty), otherwise it will simply return the provided data.

    Will check if _cfg exists, if not, returns nil.

Parameters:
    _cfg  - Entry to get value of <CONFIG>

Returns:
    Value found <STRING or NUMBER>

Examples:
    (begin example)
        [configFile >> "CfgJellies" >> "soundEffects"] call CBA_fnc_getCfgDataRandom
    (end)

Author:
    OverlordZorn
---------------------------------------------------------------------------- */


params [
    [ "_cfg", configNull, [configNull] ]
];

if (_cfg isEqualTo configNull) exitWith {nil};

private _data = [_cfg] call BIS_fnc_getCfgData;
if (_data isEqualType []) then { _data = selectRandom _data };

_data
