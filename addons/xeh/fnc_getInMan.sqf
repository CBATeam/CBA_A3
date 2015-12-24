/* ----------------------------------------------------------------------------
Function: CBA_XEH_fnc_getInMan

Description:
    Emulates GetInMan event handler by adding a GetIn event to all objects and rearranging parameters.
    Internal use only.

Parameters:
    0: _className        - Object classname, case sensitive <STRING>
    1: _eventFunc        - Function called on event <CODE>
    2: _allowInheritance - Allow event for objects that only inherit from the given classname? <BOOLEAN>
    3: _excludedClasses  - Exclude these classes from this event including their children <ARRAY>

Returns:
    None

Examples:
    (begin example)
        ["CAManBase", {systemChat str _this}, true, []] call CBA_XEH_fnc_getInMan;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params ["_className", "_eventFunc", "_allowInheritance", "_excludedClasses"];

if (isNil QGVAR(getInAllEvents)) then {
    GVAR(getInAllEvents) = [];

    ["All", "getIn", {
        {
            // is matching class name if inheritance is disabled and is not a child of any of the excluded classes
            if ((_this select 2) isKindOf (_x select 0) && {(_x select 2 || {typeOf (_this select 2) isEqualTo (_x select 0)}) && {{(_this select 2) isKindOf _x} count (_x select 3) == 0}}) then {
                [_this select 2, _this select 1, _this select 0, _this select 3] call (_x select 1);
            };
        } forEach GVAR(getInAllEvents);
    }] call CBA_fnc_addClassEventHandler;
};

GVAR(getInAllEvents) pushBack [_className, _eventFunc, _allowInheritance, _excludedClasses];

true
