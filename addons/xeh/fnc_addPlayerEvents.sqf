// Add Player Events to Player Object

// #define DEBUG_MODE_FULL
#include "script_component.hpp"

private ["_event", "_curEvt", "_isPlayer", "_i"];

params ["_object"];

if (isNull _object) exitWith {}; // not a valid object

// Respawn fix
_isPlayer = _object getVariable "SLX_XEH_PLAYER";
if !(isNil "_isPlayer") exitWith { TRACE_1("Abort. Unit is already tagged", _object) };

_i = 0;
{
    _event = SLX_XEH_OTHER_EVENTS_XEH select _i;
    _curEvt = _object getVariable _event;
    if (isNil "_curEvt") then { _curEvt = []; _object setVariable [_event, _curEvt] };
    PUSH(_curEvt,SLX_XEH_OTHER_EVENTS_PLAYERS select _i);
    INC(_i);
} forEach SLX_XEH_OTHER_EVENTS;

_object setVariable ["SLX_XEH_PLAYER", true];
