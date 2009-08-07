/*
Internal Function: CBA_network_fnc_opc
*/
#include "script_component.hpp"
#define __scriptname opc
private["_id", "_uid", "_plName"];

PARAMS_2(_obj,_name);
_id = 1;

// TODO: Use a getUUID function?
// TODO: Evaluate using the globalEvent with localEvent, and simulate official OPC better

_plName = if (isNull player) then { "" } else { name player };

if ((_name!= "__SERVER__") && (_name!= format["%1", _plName])) then
{
	TRACE_3("Player Connected",_name,_id,_obj);
	if (time > 0) then 
	{
		[_obj] call FUNC(sync); { _x setMarkerPos (getMarkerPos _x) } forEach GVAR(markers);
	};
};
