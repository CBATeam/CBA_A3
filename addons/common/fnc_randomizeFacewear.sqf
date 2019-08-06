#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_randomizeFacewear

Description:
    Add config defined weighted random facewear to unit.
    Working 'allowedFacewear' replacement for BIS_fnc_unitHeadgear. 

Parameters:
    _unit - unit <OBJECT>

Returns:
    true on success, false on error <BOOLEAN>

Examples:
    (begin example)
        [unit] call CBA_fnc_randomizeFacewear
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
SCRIPT(randomizeFacewear);

params [["_unit", objNull]];

if (isNull _unit) exitWith {
    TRACE_1("unit is null",_unit);
    false
};

if (!local _unit || {!(_unit getVariable ["BIS_enableRandomization", true])}) exitWith {true};

private _allowedFacewear = getArray (configFile >> "CfgVehicles" >> typeOf _unit >> "allowedFacewear");

if (_allowedFacewear isEqualTo []) exitWith {true};

private _facewear = selectRandomWeighted _allowedFacewear;

if (_facewear == "None") then {
    removeGoggles _unit;
} else {
    _unit addGoggles _facewear;
};
