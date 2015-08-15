// Remove Player Events from Player Object

// #define DEBUG_MODE_FULL
#include "script_component.hpp"

private ["_event", "_curEvt"];

params ["_object"];

if (isNull _object) exitWith {}; // not a valid object

_i = 0;
{
    _event = SLX_XEH_OTHER_EVENTS_XEH select _i;
    _curEvt = _object getVariable _event;
    TRACE_2("",_event,_curEvt);
    if (!isNil "_curEvt" && {count _curEvt > 0}) then {
        _newEvt = [];
        TRACE_1("Adjusting array",count _curEvt);
        if (count _curEvt > 1) then {
            // Take all but the last (last = player handler)
            for "_i" from 0 to ((count _curEvt) - 2) do { PUSH(_newEvt,_curEvt select _i) };
        };
        _object setVariable [_event, _newEvt];
    };
    INC(_i);
} forEach SLX_XEH_OTHER_EVENTS;

_object setVariable ["SLX_XEH_PLAYER", nil]; // Used for Respawn determination (vs teamSwitch)
