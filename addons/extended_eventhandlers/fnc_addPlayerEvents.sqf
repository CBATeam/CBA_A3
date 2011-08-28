// Add Player Events to Player Object

// #define DEBUG_MODE_FULL
#include "script_component.hpp"

private ["_event", "_curEvt"];

PARAMS_1(_object);

if (isNull _object) exitWith {}; // not a valid object

{
	_event = SLX_XEH_OTHER_EVENTS_XEH select _forEachIndex;
	_curEvt = _object getVariable _event;
	if (isNil "_curEvt") then { _curEvt = []; _object setVariable [_event, _curEvt] };
	PUSH(_curEvt,SLX_XEH_OTHER_EVENTS_PLAYERS select _forEachIndex);
} forEach SLX_XEH_OTHER_EVENTS;
