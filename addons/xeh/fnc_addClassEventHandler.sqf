/* ----------------------------------------------------------------------------
Function: CBA_fnc_addClassEventHandler

Description:
    Add an eventhandler to a class and all children.

Parameters:
    0: _className        - The classname of objects you wish to add the eventhandler too. Can be a base class. <STRING>
    1: _eventName        - The type of the eventhandler. E.g. "init", "fired", "killed" etc. <STRING>
    2: _eventFunc        - Function to execute when event happens. <CODE>
    3: _allowInheritance - Allow event for objects that only inherit from the given classname? [optional] <BOOLEAN> (default: true)
    4: _excludedClasses  - Exclude these classes from this event including their children [optional] <ARRAY> (default: [])

Returns:
    _success - Whether adding the event was successful or not. <BOOLEAN>

Examples:
    (begin example)
        ["CAManBase", "fired", {systemChat str _this}] call CBA_fnc_addClassEventHandler;
        ["All", "init", {systemChat str _this}] call CBA_fnc_addClassEventHandler;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_className", "", [""]], ["_eventName", "", [""]], ["_eventFunc", {}, [{}]], ["_allowInheritance", true, [false]], ["_excludedClasses", [], [[]]]];

private _config = configFile >> "CfgVehicles" >> _className;

// init fallback loop when executing on incompatible class for the first time
if (!GVAR(fallbackRunning) && {ISINCOMP(_className)}) then {
    diag_log text format ["[XEH]: One or more children of class %1 do not support Extended Event Handlers. Fall back to loop.", configName _config];
    call CBA_fnc_startFallbackLoop;
};

// no such CfgVehicles class
if (!isClass _config) exitWith {false};

//Handle initReto event type:
private _runRetroactiveInit = false;
if (_eventName == "initRetro") then {
    _runRetroactiveInit = true;
    _eventName = "init";
};

_eventName = toLower _eventName;

// no such event
if (_eventName == "FiredBIS") exitWith {
    WARNING("Cannot add 'FiredBIS' - Use 'Fired' instead");
    false
};
if !(_eventName in GVAR(EventsLowercase)) exitWith {false};

// add events to already existing objects
private _entities = entities "" + allUnits;
private _eventVarName = format [QGVAR(%1), _eventName];

{
    if (_x isKindOf _className) then {
        private _unit = _x;

        if (ISKINDOF(_unit,_className,_allowInheritance,_excludedClasses)) then {
            if (isNil {_unit getVariable _eventVarName}) then {
                _unit setVariable [_eventVarName, []];
            };

            (_unit getVariable _eventVarName) pushBack _eventFunc;

            //Run initReto now if the unit has already been initialized
            if (_runRetroactiveInit && {ISINITIALIZED(_unit)}) then {
                [_unit] call _eventFunc;
            };
        };
    };
} forEach (_entities arrayIntersect _entities); // filter duplicates

// define for units that are created later
private _events = EVENTHANDLERS(_eventName,_className);

_events pushBack [_eventFunc, _allowInheritance, _excludedClasses];

SETEVENTHANDLERS(_eventName,_className,_events);

// set flag for this event handler to be used on this class. reduces overhead on init.
private _eventNameFlagsVarName = format [QGVAR(::%1), _className];
private _eventNameFlags = missionNamespace getVariable [_eventNameFlagsVarName, []];

if !(_eventName in _eventNameFlags) then {
    _eventNameFlags pushBack _eventName;
    missionNamespace setVariable [_eventNameFlagsVarName, _eventNameFlags];
};

true
