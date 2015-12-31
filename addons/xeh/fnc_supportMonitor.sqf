/* ----------------------------------------------------------------------------
Function: CBA_fnc_supportMonitor

Description:
    Iterate through all vehicle classes and find those who don't support extended event handlers.

Parameters:
    0: _addAddonToOutput  - false: simple list of classnames - true: include addon in output [optional] <BOOLEAN> (default: false)
    1: _includeDisabled   - Include classes that have XEH explicitly disabled? [optional] <BOOLEAN> (default: false)
    2: _includeDuplicates - Include classes that inherit class EventHandlers? [optional] <BOOLEAN> (default: false)
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
#include "script_component.hpp"

params [["_addAddonToOutput", false, [false]], ["_includeDisabled", false, [false]], ["_includeDuplicates", false, [false]], ["_classFilter", "", [""]]];

private _notSupportingClasses = [];

{
    if (_classFilter == "" || {configName _x isKindOf _classFilter}) then {
        private _eventhandlersClass = _x >> "EventHandlers";

        if (_eventhandlersClass in configProperties [_x, "isClass _x", false] && {!isClass (_eventhandlersClass >> QUOTE(XEH_CLASS))}) then {
            // ignore classes where XEH is disabled
            if (!_includeDisabled && {getNumber (_x >> "SLX_XEH_DISABLED") == 1}) exitWith {};

            // don't list duplicates
            if (!_includeDuplicates && {configName inheritsFrom _eventhandlersClass == "EventHandlers"}) exitWith {};

            if (_addAddonToOutput) then {
                _notSupportingClasses pushBack [configName _x, configSourceMod _x];
            } else {
                _notSupportingClasses pushBack configName _x;
            };
        };
    };
} forEach ("getNumber (_x >> 'scope') > 0" configClasses (configFile >> "CfgVehicles"));

_notSupportingClasses
