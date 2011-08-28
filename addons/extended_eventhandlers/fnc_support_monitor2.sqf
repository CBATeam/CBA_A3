// #define DEBUG_MODE_FULL
#include "script_component.hpp"

// Used on Init of all objects, not on respawn.
private ["_type", "_cfg", "_partial", "_full"];
PARAMS_1(_obj);
_type = typeOf _obj;

// No XEH EH entries at all - Needs full XEH
if (_type in SLX_XEH_FULL_CLASSES) exitWith {
	TRACE_2("Adding XEH Full (cache hit)",_obj,_type);
	{ _obj addEventHandler [_x, compile format["_this call SLX_XEH_EH_%1", _x]] } forEach SLX_XEH_EVENTS_NAT;
};

// Already has Full XEH EH entries - Needs nothing!
if (_type in SLX_XEH_CLASSES) exitWith { TRACE_2("Already XEH (cache hit)",_obj,_type) };

_cfg = (configFile >> "CfgVehicles" >> _type >> "EventHandlers");

// Add script-eventhandlers for those events that are not setup properly.
_partial = false; _full = true;

{
	_event = (_cfg >> _x);
	_XEH = false;

	if (isText _event) then {
		_eventAr = toArray(getText(_event));
		if (count _eventAr > 13) then {
			_ar = [];
			for "_i" from 0 to 13 do {
				PUSH(_ar,_eventAr select _i);
			};
			if (toString(_ar) == "_this call SLX") then { _full = false; _XEH = true };
		};
	};
	if !(_XEH) then {
		_partial = true;
		TRACE_3("Adding missing EH",_obj,_type,_x);
		_obj addEventHandler [_x, compile format["_this call SLX_XEH_EH_%1", _x]];
	};
} forEach SLX_XEH_EVENTS_NAT;

if !(_partial) then { TRACE_2("Caching",_obj,_type); PUSH(SLX_XEH_CLASSES,_type); };
if (_full) then { TRACE_2("Caching (full)",_obj,_type); PUSH(SLX_XEH_FULL_CLASSES,_type); };
