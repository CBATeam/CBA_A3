#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_statusEffects_fnc_handleEngine
Description:
    Blocks turning on the vehicles engine if set by the status effect handler.

Parameters:
    _vehicle     - Vehicle <OBJECT>
    _engineState - Engine state <BOOL>

Returns:
    None

Examples
    (begin example)
        [player, true] call CBA_statusEffects_fnc_handleEngine
    (end)

Author:
    BaerMitUmlaut
---------------------------------------------------------------------------- */
SCRIPT(handleEngine);
params ["_vehicle", "_engineOn"];

if (local _vehicle && _engineOn && {_vehicle getVariable ["CBA_blockEngine", false]}) then {
    _vehicle engineOn false;
};
