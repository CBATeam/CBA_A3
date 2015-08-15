/*
Internal Function: CBA_network_fnc_exec
*/
#include "script_component.hpp"
// Generic NET Execution Handler
private ["_ar", "_id", "_chan", "_cmd", "_objAr", "_ex", "_msg"];
params ["_id","_ar"];

if (count _ar < 2) exitWith {};
_chan = _ar select 0;
_cmd = _ar select 1;
_objAr = if (count _ar > 2) then { _ar select 2 } else { [] };
TRACE_2("",_id,_ar);

//Validating variables
if (isNil "_id") exitWith {};
if (isNil "_ar") exitWith {};
if (isNil "_chan") exitWith {};
if (isNil "_cmd") exitWith {};
if (isNil "_objAr") exitWith {};

_ex = if ((typeName _chan) == "OBJECT") then {
    (local _chan);
} else {
    switch _chan do {
        case 0: { (SLX_XEH_MACHINE select 3) };
        case -1: { (SLX_XEH_MACHINE select 0) };
        case -2: { true };
        default { false };
    };
};

if (GVAR(debug)) then {
    TRACE_6("",_ex,call FUNC(id),_id,_chan,_objAr,_cmd);
};

if (isNil "_ex") exitwith {};

if (_ex) then {
    TRACE_2("executing",_objAr,_cmd);
    _objAr call _cmd; // Changed to call; should not be necessary to spawn here? this way _id etc is given to calling instance
};
