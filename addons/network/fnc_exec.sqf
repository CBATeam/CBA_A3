/*
Internal Function: CBA_network_fnc_exec
*/
#include "script_component.hpp"
// #define DEBUG_MODE_FULL
// Generic NET Execution Handler
private ["_ar", "_id", "_chan", "_cmd", "_objAr", "_ex", "_msg"];
PARAMS_2(_id,_ar);
if (count _ar < 2) exitWith {};
_chan = _ar select 0;
_cmd = _ar select 1;
if (count _ar > 2) then { _objAr = _ar select 2 } else { _objAr = [] };
TRACE_2("",_id,_ar);

if ((typeName _chan) == "OBJECT") then
{
	_ex = (local _chan);
} else {
	switch _chan do
	{
		case 0: { if (isServer) then { _ex = true } };
		case -1: { if (SLX_XEH_MACHINE select 0) then { _ex = true } };
		case -2: { _ex = true };
		//case -3: { if (GVAR(uID) != _id) then { _ex = true } };
		//default { if (GVAR(uID) == _chan) then { _ex = true } };
	};
};

if (GVAR(debug)) then
{
	_msg = format["RCV: receiverID %1, senderID %2, destination %3, param %4, command %5", call FUNC(id), _id, _chan, _objAr, _cmd];

	if (_ex) then { _msg = (_msg + ". Executing!") } else { _msg = (_msg + ". Not Executing!") };

	// Output to Chat and local arma.rpt
	[_msg, QUOTE(ADDON)] call CBA_fnc_Debug;
};

if (_ex) then
{
	TRACE_2("executing",_objAr,_cmd);
	_objAr call _cmd; // Changed to call; should not be necessary to spawn here? this way _id etc is given to calling instance
};
