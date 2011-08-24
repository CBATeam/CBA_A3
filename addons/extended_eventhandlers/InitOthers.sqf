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
	"_unit", "_event", "_unitClass", "_classes", "_handlers", "_handler",
	"_xeh", "_xehPlayer", "_event", "_ha", "_data", "_i"
];

#ifdef DEBUG_MODE_FULL
	format["XEH BEG: %2 - %3", time, _this, typeOf (_this select 0)] call SLX_XEH_LOG;
#endif

// Get unit.
_unit = _this select 0;
_unitClass = typeOf _unit;

_ehSuper = inheritsFrom(configFile/"CfgVehicles"/_unitClass/"EventHandlers");
_hasDefaultEH = (configName(_ehSuper)=="DefaultEventhandlers");

// Get array of inherited classes of unit.
_classes = [_unitClass];
while {!((_classes select 0) in SLX_XEH_DEF_CLASSES)} do
{
	_classes = [(configName (inheritsFrom (configFile/"CfgVehicles"/(_classes select 0))))]+_classes;
};


// Iterate over the event types and set up any extended event handlers
// that might be defined.

_data = [_unitClass, _classes, _hasDefaultEH] call SLX_XEH_F2_INIT_OTHERS_CACHE;
_i = 0;
{
	_event = _x;

	// Collect eventhandlers for configFile, campaignConfigFile and missionConfigFile
	_eventData = _data select _i;
	_handler = _eventData select 0;
	_handlerPlayer = _eventData select 1;

	// Attach the compiled extended event handler to the unit.
	_xeh = SLX_XEH_OTHER_EVENTS_XEH select _i;
	_xehPlayer = _xeh + "_Player";
	_unit setVariable [_xeh, _handler];
	_unit setVariable [_xehPlayer, _handlerPlayer];

	#ifdef DEBUG_MODE_FULL
		format["XEH RUN: %2 - %3 - %4 - %5", time, _this, _event, typeOf (_this select 0)] call SLX_XEH_LOG; // , _handler != "", _handlerPlayer != ""
	#endif
	INC(_i);
} forEach SLX_XEH_OTHER_EVENTS;

_unit setVariable ["SLX_XEH_READY", true];

#ifdef DEBUG_MODE_FULL
	format["XEH END: %2", time, _this] call SLX_XEH_LOG;
#endif

nil;
