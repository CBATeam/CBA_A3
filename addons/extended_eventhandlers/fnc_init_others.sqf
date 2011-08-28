// Init Others per Object

/* Extended event handlers by Solus and Killswitch
*
* Get all inherited classes, then check if each inherited class has a
* counterpart in the extended event handlers classes. Then and add all lines
* from each matching EH class and set things up.
*
*/
// #define DEBUG_MODE_FULL
#include "script_component.hpp"
private [
	"_unit", "_unitClass", "_handlers", "_handler",
	"_xeh", "_xehPlayer", "_ha", "_data"
];

#ifdef DEBUG_MODE_FULL
	format["XEH BEG: %2 - %3", time, _this, typeOf (_this select 0)] call SLX_XEH_LOG;
#endif

// Get unit.
PARAMS_1(_unit);
_unitClass = typeOf _unit;

// Iterate over the event types and set up any extended event handlers
// that might be defined.

_data = _unitClass call FUNC(init_others_enum_cache);

{
	_eventData = _data select _forEachIndex;

	// TODO: Improve - current implementation is to remove empty code
	// New array per entitity is at least important for _handler, because of optional player handlers.
	_handler = [];
	_handlerPlayer = [];
	{ if !(isNil "_x") then { PUSH(_handler,_x) } } forEach (_eventData select 0);
	{ if !(isNil "_x") then { PUSH(_handlerPlayer,_x) } } forEach (_eventData select 1);

	// Attach the compiled extended event handler to the unit.
	// TODO: Add alternative handler implementation; no setVariables on the units, just grab directly from uiNamespace
	_xeh = SLX_XEH_OTHER_EVENTS_XEH select _forEachIndex;
	_xehPlayer = SLX_XEH_OTHER_EVENTS_XEH_PLAYERS select _forEachIndex;

	_unit setVariable [_xeh, _handler];
	_unit setVariable [_xehPlayer, _handlerPlayer];

	#ifdef DEBUG_MODE_FULL
		format["XEH RUN: %2 - %3 - %4 - %5", time, _this, _x, _unitClass, count _handler > 0, count _handlerPlayer > 0] call SLX_XEH_LOG;
	#endif
} forEach SLX_XEH_OTHER_EVENTS;

_unit setVariable ["SLX_XEH_READY", true];

#ifdef DEBUG_MODE_FULL
	format["XEH END: %2", time, _this] call SLX_XEH_LOG;
#endif

nil;
