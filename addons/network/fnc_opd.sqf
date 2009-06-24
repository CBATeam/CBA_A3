/*
Function: CBA_network_fnc_opd
*/
#include "script_component.hpp"
#define __scriptname opd

private["_id", "_idx", "_name", "_uid"];
_name = _this select 0;
_id = _this select 1;

_this spawn { _name = _this select 0; _id = _this select 1; { _this call _x } forEach GVAR(OPD) };
/*
_idx = GVAR(CLNAME) find _name;
if (_idx > -1) then
{
	_uid = format["%1", GVAR(CLUID) select _idx];
	GVAR(CLSET) set [_idx, false]; // maybe unnececairy, depends if CLSET is going to be used for sth more
	GVAR(CLUID) set [_idx, -9]; // maybe good substitute for GVAR(CLSET)?

	GVAR(UPDATE) set [0, true]; // Initiate buffer for updating CLUID
};
*/
#ifdef DEBUG
[format["Player Disconnected: %1", _name], QUOTE(GVAR(__scriptname)), DEBUGSETTINGS] call CBA_fnc_Debug;
#endif