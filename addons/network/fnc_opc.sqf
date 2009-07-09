/*
Internal Function: CBA_network_fnc_opc
*/
#include "script_component.hpp"
#define __scriptname opc
private["_name", "_id", "_uid", "_idx", "_dbg", "_handle", "_plName"];
_dbg = 1;

PARAMS_2(_obj,_name);
_id = 1;
//_id = _this select 1;

_plName = if (isNull player) then { "" } else { name player };
// Deprecated
_this spawn { _name = _this select 0; _id = _this select 1; { _this call _x } forEach GVAR(oPCB) }; // OnPlayerConnectedB, execute even without confirmation

if ((_name!= "__SERVER__") && (_name!= format["%1", _plName])) then
{
	_this spawn
	{
		PARAMS_2(_name,_id);
		sleep 6;
		//GVAR(cLSET) set [_this select 0, true];
		// Deprecated
		{ _params call _x } forEach GVAR(oPC); // OnPlayerConnected, execute after confirmation // Must still implement more means for verification?

		if (time > 0 ) then { [] spawn { sleep 5; [QUOTE(GVAR(sync))] call CBA_fnc_localEvent; { _x setMarkerPos (getMarkerPos _x) } forEach GVAR(mARKERS) } };
	};

	#ifdef DEBUG
	[format["Player Connected: %1", _name], QUOTE(GVAR(__scriptname)), DEBUGSETTINGS] call CBA_fnc_Debug;
	#endif
};
