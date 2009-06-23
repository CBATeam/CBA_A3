/*
Function: CBA_network_fnc_opc
*/
#include "script_component.hpp"
#define __scriptname opc
private["_name", "_id", "_uid", "_idx", "_dbg", "_handle", "_plName"];
_dbg = 1;

_obj = _this select 0;
_name = _this select 1;
_id = 1;
//_name = _this select 0;
//_id = _this select 1;

_plName = if (isNull player) then { "" } else { name player };
_this spawn { _name = _this select 0; _id = _this select 1; { _this call _x } forEach GVAR(OPCB) }; // OnPlayerConnectedB, execute even without confirmation

if ((_name!= "__SERVER__") && (_name!= format["%1", _plName])) then
{
/*
	_uid = GVAR(UIDS); GVAR(UIDS) = GVAR(UIDS) + 1;
	_idx = GVAR(CLNAME) find _name;
	if (_idx == -1) then
	{
		GVAR(CLNAME) = GVAR(CLNAME) + [_name];
		_idx = GVAR(CLNAME) find _name;
	};
	GVAR(CLSET) set [_idx, false];
	GVAR(CLUID) set [_idx, _uid];
	GVAR(CLID) set [_idx, _this select 1];

	GVAR(UPDATE) set [0, true]; GVAR(UPDATE) set [1, true]; // Initiate buffer for updating CLNAME and CLUID
*/
	[_idx,_this] spawn
	{
		_params = _this select 1;
		_name = _params select 0;
		_id = _params select 1;
		sleep 6;
		//GVAR(CLSET) set [_this select 0, true];
		{ _params call _x } forEach GVAR(OPC); // OnPlayerConnected, execute after confirmation // Must still implement more means for verification?
	}; // OnPlayerConnected

	#ifdef DEBUG
	[format["Player Connected: %1", _name], QUOTE(GVAR(__scriptname)), DEBUGSETTINGS] call CBA_fnc_Debug;
	#endif
};