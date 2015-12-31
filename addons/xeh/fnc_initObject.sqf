/* ----------------------------------------------------------------------------
Function: CBA_fnc_initObject

Description:
    Runs Init and adds other event handlers on this object.
    Internal use only.

Parameters:
    0: Any CfgVehicles object <OBJECT>

Returns:
    None

Examples:
    (begin example)
        _unit call CBA_fnc_initObject;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params ["_unit"];

if !(ISPROCESSED(_unit)) then {
    SETPROCESSED(_unit);

    private _class = configFile >> "CfgVehicles" >> typeOf _unit;

    if (getNumber (_class >> "SLX_XEH_DISABLED") == 1) exitWith {};

    // add events to XEH incompatible units
    if (ISINCOMP(typeOf _unit)) then {
        {
            if (_x isEqualTo "hitpart") then {
                _unit addEventHandler ["hitpart", "{_this call _x} forEach ((_this select 0 select 0) getVariable ""cba_xeh_hitpart"")"];
            } else {
                if !(_x isEqualTo "init") then {
                    _unit addEventHandler [_x, format ["{_this call _x} forEach ((_this select 0) getVariable ""cba_xeh_%1"")", _x]];
                };
            };
        } forEach GVAR(EventsLowercase);
    };

    while {isClass _class} do {
        private _className = configName _class;

        // call Init event handlers
        if !(ISINITIALIZED(_unit)) then {
            {
                if (ISKINDOF(_unit,_className,_x select 1,_x select 2)) then {
                    // prevent variable from being overwritten and causing issues without proper use of private
                    private ["_class", "_className"];

                    [_unit] call (_x select 0);
                };
            } forEach EVENTHANDLERS("init",_className);
        };

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

    // run InitPost or put on stack
    if !(ISINITIALIZED(_unit)) then {
        if (SLX_XEH_MACHINE select 8) then {
            _unit call CBA_fnc_initPostObject;
        } else {
            GVAR(InitPostStack) pushBack _unit;
        };
    };

    SETINITIALIZED(_unit);
};

#ifdef DEBUG_MODE_FULL
    diag_log ["Init", _unit, local _unit, typeOf _unit];
#endif

nil
