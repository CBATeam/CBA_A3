/*
 * Author: commy2
 * Add eventhandler to class and all children.
 *
 * Arguments:
 * 0: Classname <STRING>
 * 1: Event type <STRING>
 * 2: Event script <CODE>
 *
 * Return Value:
 * Successful? <BOOL>
 *
 * Public: Yes
 *
 * Example: 
 * ["CAManBase", "fired", {systemChat str _this}] call cba_fnc_addClassEventhandler;
 * ["All", "init", {systemChat str _this}] call cba_fnc_addClassEventhandler;
 */
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
