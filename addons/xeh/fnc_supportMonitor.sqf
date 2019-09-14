#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_supportMonitor

Description:
    Iterate through all vehicle classes and find those who don't support extended event handlers.

Parameters:
    0: _addAddonToOutput  - false: simple list of classnames - true: include addon in output [optional] <BOOLEAN> (default: false)
    1: _includeDuplicates - Include classes that inherit class EventHandlers? [optional] <BOOLEAN> (default: false)
    2: _includeDisabled   - Include classes that have XEH explicitly disabled? [optional] <BOOLEAN> (default: false)
    3: _classFilter       - Only include children of this class. "" to disable filter [optional] <STRING> (default: "")

Returns:
    List of addons not supporting XEH <ARRAY>

Examples:
    (begin example)
        [true] call CBA_fnc_supportMonitor;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

params [["_addAddonToOutput", false, [false]], ["_includeDuplicates", false, [false]], ["_includeDisabled", false, [false]], ["_classFilter", "", [""]]];

private _notSupportingClasses = [];

{
    if (_classFilter == "" || {configName _x isKindOf _classFilter}) then {
        if (!isText (_x >> "EventHandlers" >> QUOTE(XEH_CLASS) >> "init")) then {
            // don't list duplicates
            if (!_includeDuplicates && {{configName _x == "EventHandlers"} count configProperties [_x, "isClass _x", false] == 0}) exitWith {};

            // ignore classes where XEH is disabled
            if (!_includeDisabled && {getNumber (_x >> "SLX_XEH_DISABLED") == 1}) exitWith {};

            if (_addAddonToOutput) then {
                _notSupportingClasses pushBack [configName _x, configSourceMod _x];
            } else {
                _notSupportingClasses pushBack configName _x;
            };
        };
    };
} forEach ("true" configClasses (configFile >> "CfgVehicles"));

_notSupportingClasses
