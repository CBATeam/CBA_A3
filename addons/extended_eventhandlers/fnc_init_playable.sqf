// Init Playable per Object

// #define DEBUG_MODE_FULL
#include "script_component.hpp"

private ["_var"];
PARAMS_1(_unit);

_var = _unit getVariable SLX_XEH_STR_PLAYABLE;
if !(isNil "_var") exitWith {}; // Already set
if (_unit in playableUnits || isPlayer _unit || _unit == player) then
{
	#ifdef DEBUG_MODE_FULL
		str(['Playable unit!', _unit]) call SLX_XEH_LOG;
	#endif
	if (_unit == player) then {
		_unit setVariable ['SLX_XEH_PLAYABLE', true, true]; // temporary until better solution for players in MP..
	} else {
		// Workaround for JIP players thinking they are respawners :P
		_unit setVariable ['SLX_XEH_PLAYABLE', true];
	};
};
