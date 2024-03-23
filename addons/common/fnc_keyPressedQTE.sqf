#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_keyPressedQTE

Description:
	Process Quick-Time Key Press

Parameters:
    _eventQTE - <STRING>


Example:
    ["↑"] call CBA_fnc_keyPressedQTE;

Returns:
    Nil

Author:
    john681611
---------------------------------------------------------------------------- */


params ["_eventQTE"];
GVAR(QTERunning) = RETDEF(GVAR(QTERunning),false);
if!(GVAR(QTERunning)) exitWith {};
if!(_eventQTE in ["↑", "↓", "→", "←"]) exitWith {};


private _object = GVAR(QTEArgs) get "object";
private _args = GVAR(QTEArgs) get "args";
private _onDisplay = GVAR(QTEArgs) get "onDisplay";
private _onFinish = GVAR(QTEArgs) get "onFinish";
private _onFail = GVAR(QTEArgs) get "onFail";
private _max_distance = GVAR(QTEArgs) get "max_distance";
private _qte_sequence = GVAR(QTEArgs) get "qte_seqence";
private _start_time = GVAR(QTEArgs) get "start_time";

private _elapsedTime = CBA_missionTime - _start_time;

GVAR(QTEHistory) pushBack _eventQTE;


if (GVAR(QTEHistory) isEqualTo _qte_sequence) exitWith {
	GVAR(QTEHistory) = [];
	GVAR(QTERunning) = false;
	TRACE_1("QTE Completed",_elapsedTime);
	if (_onFinish isEqualType "") then {
		[_onFinish, [_args, _elapsedTime]] call CBA_fnc_localEvent;
	} else {
		[_args, _elapsedTime] call _onFinish;
	};
};

if !(GVAR(QTEHistory) isEqualTo (_qte_sequence select [0, count GVAR(QTEHistory)])) then {
	GVAR(QTEHistory) = [];
};

if (_onDisplay isEqualType "") then {
	[_onDisplay, 	[_args, _qte_sequence,  GVAR(QTEHistory)]] call CBA_fnc_localEvent;
} else {
	[_args, _qte_sequence,  GVAR(QTEHistory)] call _onDisplay;
};