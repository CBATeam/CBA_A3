/* ----------------------------------------------------------------------------
Function: CBA_fnc_initEvents

Description:
    Adds all event handlers to this object.
    Internal use only.

Parameters:
    0: Any CfgVehicles object <OBJECT>

Returns:
    None

Examples:
    (begin example)
        _unit call CBA_fnc_initEvents;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params ["_unit"];

if !(ISPROCESSED(_unit)) then {
    SETPROCESSED(_unit);

    private _class = configFile >> "CfgVehicles" >> typeOf _unit;
    private _eventClass = _class >> "EventHandlers" >> QUOTE(XEH_CLASS);

    // adds ability to disable XEH completely on a unit, by manually clearing the CBA event handler class.
    if (isClass _eventClass && {configProperties [_eventClass] isEqualTo []}) exitWith {};

    // add events to XEH incompatible units
    if (!isClass _eventClass) then {
        {
            _unit addEventHandler [_x, format ['call FUNC(%1)', _x]];
        } forEach ([XEH_EVENTS] - ["FiredBis", "InitPost"]);
    };

    while {isClass _class} do {
        private _className = configName _class;

        // add other event handlers
        {
            private _eventName = _x;
            private _eventVarName = format [QGVAR(%1), _eventName];

            {
                if (ISKINDOF(_unit,configName _class,_x select 1,_x select 2)) then {
                    if (isNil {_unit getVariable _eventVarName}) then {
                        _unit setVariable [_eventVarName, []];
                    };

                    (_unit getVariable _eventVarName) pushBack (_x select 0);
                };
            } forEach EVENTHANDLERS(_eventName,_className);
        } forEach (missionNamespace getVariable [format [QGVAR(::%1), _className], []]); // flags

        _class = inheritsFrom _class;
    };
};
