/* ----------------------------------------------------------------------------
Function: CBA_fnc_createTrigger

Description:
    Create a trigger all at once.

Parameters:
    _pos - Position [Array]

Optional Parameters:
    "AREA:" - e.g. [5, 5, 0, false]
    "ACT:" - e.g. ["CIV", "PRESENT", true]
    "STATE:" - e.g. ["this", "hint 'Civilian near player'", "hint 'no civilian near'"]
    "NAME:" - e.g. "VariableName"

Returns:
    Trigger and parameters given in an array: [_trigger, _parameters]

Examples:
    (begin example)
        [_position] call CBA_fnc_createTrigger;

        [_position, "AREA:", [5, 5, 0, false], "ACT:", ["CIV", "PRESENT", true]] call CBA_fnc_createTrigger;
    (end)

Author:
    Sickboy (sb_at_dev-heaven.net)
---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(createTrigger);

/*
    createTrigger function by

*/

private
[
    "_pos",
    "_area",
    "_activation",
    "_name",
    "_statements",
    "_trg"
];

params ["_pos"];
_area = ["AREA:", "area:", [],_this] call CBA_fnc_getArg;
_activation = ["ACT:", "act:", [],_this] call CBA_fnc_getArg;
_statements = ["STATE:", "state:", [],_this] call CBA_fnc_getArg;
_name = ["NAME:", "name:", "", _this] call CBA_fnc_getArg;

_trg = createTrigger["EmptyDetector", _pos];
if (count _area>0) then { _trg setTriggerArea _area };
if (count _activation>0) then { _trg setTriggerActivation _activation };
if (count _statements>0) then { _trg setTriggerStatements _statements };
if (_name != "") then { missionNamespace setVariable[format["%1",_name],_trg]; };

[_trg, _this]
