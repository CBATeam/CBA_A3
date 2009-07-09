/*
Internal Function: CBA_network_fnc_opd
*/
#include "script_component.hpp"
#define __scriptname opd

private["_id", "_idx", "_name", "_uid"];
PARAMS_2(_name,_id);

// Deprecated
_this spawn { _name = _this select 0; _id = _this select 1; { _this call _x } forEach GVAR(oPD) };
/*
_idx = GVAR(cLNAME) find _name;
if (_idx > -1) then
{
	_uid = format["%1", GVAR(cLUID) select _idx];
	GVAR(cLSET) set [_idx, false]; // maybe unnececairy, depends if CLSET is going to be used for sth more
	GVAR(cLUID) set [_idx, -9]; // maybe good substitute for GVAR(cLSET)?

	GVAR(uPDATE) set [0, true]; // Initiate buffer for updating CLUID
};
*/
#ifdef DEBUG_MODE_FULL
[format["Player Disconnected: %1", _name], QUOTE(GVAR(__scriptname)), DEBUGSETTINGS] call CBA_fnc_Debug;
#endif
