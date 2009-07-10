/* ----------------------------------------------------------------------------
Function: CBA_fnc_debug

Description:
	General Purpose Debug Message Writer

	Handles very long messages without losing text or crashing the game.

Parameters:
	_message - Message to write or data structure to dump [String or Array].
	_component - component [String, defaults to "CBA_DEBUG"]
	_typeOfDebug - Type of message [3-element Array, as described below...]
	... _useGlobalChat - Write to global chat [Boolean, defaults to true].
	... _local - Log to local arma.rpt [Boolean, defaults to true]
    ... _global - Log to local and remote arma.rpt [Boolean, defaults to false]

Returns:
	nil

Examples:
    (begin example)
		// Write the debug message in chat-log of local computer, and in
		// local and remote arma.rpt.
		[ "New Player Joined the Server!", "cba_network", [true, false, true] ] call CBA_fnc_debug;
    (end)

Author:
	Sickboy
---------------------------------------------------------------------------- */

#include "script_component.hpp"

if (isNil QUOTE(ADDON)) then
{
	CREATELOGICLOCAL;
	// GVAR(debug) = []; // TODO: Evaluate if this is useful... Logging to rpt and using a tail reader seems okay too!
};

_ar2msg = {
	private ["_ar", "_str", "_msg", "_orig", "_total", "_i"];
	_ar = [];
	if (typeName (_this select 0) == "ARRAY") then
	{
		_orig = _this select 0;
		_str = format["%1 [", _this select 1];
	} else {
		_orig = _this;
		_str = "[";
	};
	{ _ar = _ar + [toArray _x] } forEach _orig;
	_msg = [];
	_total = 0; _i = 0;
	{
		_c = count _x;
		if (_total + _c < 178) then
		{
			_total = _total + _c;
			if (_i > 0) then { _str = _str + ", " };
			_str = _str + toString(_x);
		} else {
			_msg = _msg + [_str];
			_total = _c;
			_str = toString(_x);
		};
		_i = _i + 1;
	} forEach _ar;
	_str = _str + "]";
	_msg = _msg + [_str];
	_msg
};

_str2msg = {
	private ["_ar", "_i", "_nar", "_msg"];
	_ar = toArray _this;
	if (count _ar < 180) exitWith { [_this] };
	_i = 0; _nar = []; _msg = [];
	{
		if (_i < 180) then
		{
			_nar = _nar + [_x];
			_i = _i + 1;
		} else {
			_msg = _msg + [toString(_nar)];
			_nar = [_x];
			_i = 1;
		};
	} forEach _ar;
	if (count _nar > 0) then { _msg = _msg + [toString(_nar)] };
	_msg
};

_format = {
	private ["_msg"];
	_msg = [];
	switch (typeName _this) do
	{
		case "ARRAY": { { _msg = _msg + (_x call _str2msg) } forEach _this };
		case "STRING": { _msg = _this call _str2msg };
		default { _msg = format["%1", _this] call _str2msg };
	};
	_msg
};

private ["_c", "_type", "_component", "_message", "_msg", "_ar2", "_i", "_msgAr"];
_c = count _this;
_type = [true, true, false];
_component = QUOTE(ADDON);
_message = _this select 0;
if (_c > 1) then
{
	_component = _this select 1;
	if (_c > 2) then
	{
		_type = _this select 2;
	};
};

if (_type select 2) exitWith
{
	[GVAR(debug), [_message, _component, [_type select 0,_type select 1,false]]] call CBA_fnc_globalEvent;
};

_msgAr = [];
switch (typeName _message) do
{
	case "ARRAY": { _msgAr = [format["%3 (%2) %1 -", _component, time, [diag_tickTime, "H:MM:SS.mmm"] call CBA_fnc_formatElapsedTime]]; _msgAr = _msgAr + (_message call _ar2msg) };
	default { _msgAr = (format["%4 (%3) %1 - %2", _component, _message, time, [diag_tickTime, "H:MM:SS.mmm"] call CBA_fnc_formatElapsedTime] call _format) };
};

if (_type select 0) then { if (SLX_XEH_MACHINE select 0) then { { ADDON globalChat _x } forEach _msgAr } };
if (_type select 1) then { { if (_x != "") then { diag_log text _x } } forEach _msgAr };
//PUSH(GVAR(debug),_msgAr); // TODO: Evaluate cleanup system?
