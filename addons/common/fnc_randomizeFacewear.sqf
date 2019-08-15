#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_randomizeFacewear

Description:
    Add config defined weighted random facewear to unit.

    CBA_facewearList[] = {}; // default: ignore and use facewear from BIS_fnc_unitHeadgear instead
    CBA_facewearList[] = {"", 1}; // no facewear, delete and overwrite facewear from BIS_fnc_unitHeadgear

    // 40% no facewear, 30% balaclava, 30% bandana. Weighted randomization: Sum of propabilites must not necessarily equal 1.
    CBA_facewearList[] = {"", 0.4, "G_Balaclava_blk", 0.3, "G_Bandanna_blk", 0.3};

Parameters:
    _unit - unit <OBJECT>

Returns:
    true on success, false on error <BOOLEAN>

Examples:
    (begin example)
        [unit] call CBA_fnc_randomizeFacewear;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

params [["_unit", objNull, [objNull]]];

if (isNull _unit) exitWith {
    WARNING_1("Unit [%1] is null",_unit);
    false
};

if (!local _unit || {!(_unit getVariable ["BIS_enableRandomization", true])}) exitWith {true};

private _facewearList = getArray (configFile >> "CfgVehicles" >> typeOf _unit >> "CBA_facewearList");

if (_facewearList isEqualTo []) exitWith {true};

private _facewear = selectRandomWeighted _facewearList;

if (_facewear == "") then {
    removeGoggles _unit;
} else {
    _unit addGoggles _facewear;
};

true
