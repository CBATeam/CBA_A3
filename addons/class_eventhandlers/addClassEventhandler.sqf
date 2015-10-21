/* ----------------------------------------------------------------------------
Function: CBA_fnc_addClassEventhandler

Description:
    Add an eventhandler to a class and all children.

Parameters:
    _type - The classname of objects you wish to add the eventhandler too. Can be a base class.
    _event - The type of the eventhandler. E.g. "init", "fired", "killed" etc.
    _func - Function to execute when event happens.

Returns:
    _success - Boolean value. Whether adding the eventhandler was successful or not.

Examples:
    (begin example)
        ["CAManBase", "fired", {systemChat str _this}] call CBA_fnc_addClassEventhandler;
        ["All", "init", {systemChat str _this}] call CBA_fnc_addClassEventhandler;
    (end)

Author:
    commy2.

---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_type", "", [""]], ["_event", "", [""]], ["_code", {}, [{}]]];

_event = toLower _event;

// no such CfgVehicles class
if (!isClass (configFile >> "CfgVehicles" >> _type)) exitWith {false};

// no such event
if (_event != "init" && {!(_event in SUPPORTED_EH)}) exitWith {false};

// add events to already existing classes
{
    if (_x isKindOf _type) then {
        _x addEventHandler [_event, _code];
    };
    false
} count (missionNamespace getVariable [QGVAR(entities), []]);

// define for units that are created later
private _events = EVENTHANDLERS(_event,_type);

_events pushBack _code;

SETEVENTHANDLERS(_event,_type,_events);

true
