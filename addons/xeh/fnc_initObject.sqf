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

    while {isClass _class} do {
        private _className = configName _class;

        // call Init event handlers
        {
            // is matching class name if inheritance is disabled and is not a child of any of the excluded classes
            if ((_x select 1 || {typeOf _unit isEqualTo configName _class}) && {{_unit isKindOf _x} count (_x select 2) == 0}) then {
                // prevent variable from being overwritten and causing issues without proper use of private
                private _class = nil;

                [_unit] call (_x select 0);
            };
        } forEach EVENTHANDLERS("init",_className);

        // add other event handlers
        {
            private _event = _x;

            {
                // is matching class name if inheritance is disabled and is not a child of any of the excluded classes
                if ((_x select 1 || {typeOf _unit isEqualTo configName _class}) && {{_unit isKindOf _x} count (_x select 2) == 0}) then {
                    _unit addEventHandler [_event, _x select 0];
                };
            } forEach EVENTHANDLERS(_event,_className);
        } forEach (missionNamespace getVariable [format [QGVAR(::%1), _className], []]); // flags

        _class = inheritsFrom _class;
    };

    // run InitPost or put on stack
    if (SLX_XEH_MACHINE select 8) then {
        _unit call CBA_fnc_initPostObject;
    } else {
        GVAR(InitPostStack) pushBack _unit;
    };
};

#ifdef DEBUG_MODE_FULL
    diag_log ["Init", _unit, local _unit, typeOf _unit];
#endif

nil
