// Remove Player Events from Player Object

// #define DEBUG_MODE_FULL
#include "script_component.hpp"

private ["_event", "_curEvt"];

PARAMS_1(_object);

if (isNull _object) exitWith {}; // not a valid object

{
	_event = SLX_XEH_OTHER_EVENTS_XEH select _forEachIndex;
	_curEvt = _object getVariable _event;
	if (isNil "_curEvt") then { _curEvt = [] };
	if (count _curEvt > 0) then {
		_newEvt = [];
		if (count _curEvt > 1) then {
			// Take all but the last (last = player handler)
			for "_i" from 0 to ((count _curEvt) - 2) do { PUSH(_newEvt,_curEvt select _i) };
		};
		_object setVariable [_event, _newEvt];
	};
} forEach SLX_XEH_OTHER_EVENTS;
