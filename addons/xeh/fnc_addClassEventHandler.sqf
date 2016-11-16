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
    5: _applyInitRetroactively - Apply "init" event type on existing units that have already been initilized. [optional] <BOOLEAN> ((default: false)

Returns:
    _success - Whether adding the event was successful or not. <BOOLEAN>

Examples:
    (begin example)
        ["CAManBase", "fired", {systemChat str _this}] call CBA_fnc_addClassEventHandler;
        ["All", "init", {systemChat str _this}] call CBA_fnc_addClassEventHandler;
        ["Car", "init", {(_this select 0) engineOn true}, true, [], true] call CBA_fnc_addClassEventHandler; //Starts all current cars and those created later
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_className", "", [""]], ["_eventName", "", [""]], ["_eventFunc", {}, [{}]], ["_allowInheritance", true, [false]], ["_excludedClasses", [], [[]]], ["_applyInitRetroactively", false, [false]]];

private _config = configFile >> "CfgVehicles" >> _className;

// init fallback loop when executing on incompatible class for the first time
if (!GVAR(fallbackRunning) && {ISINCOMP(_className)}) then {
    diag_log text format ["[XEH]: One or more children of class %1 do not support Extended Event Handlers. Fall back to loop.", configName _config];
    call CBA_fnc_startFallbackLoop;
};

// no such CfgVehicles class
if (!isClass _config) exitWith {false};

_eventName = toLower _eventName;

// no such event
if (_eventName == "FiredBIS") exitWith {
    WARNING("Cannot add 'FiredBIS' - Use 'Fired' instead");
    false
};
if !(_eventName in GVAR(EventsLowercase)) exitWith {false};

// don't use "apply retroactively" for non init events
if (_applyInitRetroactively && {!(_eventName in ["init", "initpost"])}) then {
    _applyInitRetroactively = false;
};

// add events to already existing objects
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
            if (_applyInitRetroactively && {ISINITIALIZED(_unit)}) then {
                [_unit] call _eventFunc;
            };
        };
    };
    true
} count (entities [[], [], true, true]);

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
