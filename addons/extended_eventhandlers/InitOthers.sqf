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
	"_xeh", "_xehPlayer", "_event", "_ha", "_event_id", "_data"
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
{
	_event = _x;
	_event_id = _forEachIndex;

	_handler = "";
	_handlerPlayer = "";
	{
		_data = [_config, _event_id, _unitClass, _classes, _hasDefaultEH] call SLX_XEH_F2_INIT_OTHER;
		ADD(_handler,_data select 0);
		ADD(_handlerPlayer,_data select 1);
	} forEach SLX_XEH_CONFIG_FILES;

	if (isNull _unit) exitWith {};

	// Attach the compiled extended event handler to the unit.
	_xeh = format["Extended_%1EH", _event];
	_xehPlayer = format["Extended_%1EH_Player", _event];
	_ha = _unit getVariable _xeh;
	if (isNil "_ha") then { _ha = [] };
	if (_handler != "") then {
		_ha set [0, compile _handler];
	};
	_unit setVariable [_xeh, _ha];
	_unit setVariable [_xehPlayer, compile _handlerPlayer];

	#ifdef DEBUG_MODE_FULL
		format["XEH RUN: %2 - %3 - %4 - %5", time, _this, _event, typeOf (_this select 0), _handler != "", _handlerPlayer != ""] call SLX_XEH_LOG;
	#endif
} forEach SLX_XEH_OTHER_EVENTS;

_unit setVariable ["SLX_XEH_READY", true];

#ifdef DEBUG_MODE_FULL
	format["XEH END: %2", time, _this] call SLX_XEH_LOG;
#endif

nil;
