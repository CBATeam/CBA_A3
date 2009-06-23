#include "script_component.hpp"
/* General Purpose Debug Message Writer
 * [ Message (String), optional: component (String), optional: typeOfDebug (Array)] call CBA_fnc_Debug;
 * typeOfDebug: [ globalChatMessage, local arma.rpt, local and remote arma.rpt]
 * e.g: [ "New Player Joined the Server!", "cba_network", [true, false, true] ] call CBA_fnc_Debug;
 * (Would write the debug message in chatlog of local computer, and in local+remote arma.rpt
 *
*/
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
_component = "CBA_DEBUG";
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
	[-2, { _this call CBA_fnc_Debug }, [_message, _component], [_type select 0,_type select 1,false]] call CBA_fnc_remoteExecute;
};

_msgAr = [];
switch (typeName _message) do
{
	case "ARRAY": { _msgAr = [format["(%2) %1 -", _component, time]]; _msgAr = _msgAr + (_message call _ar2msg) };
	default { _msgAr = (format["(%3) %1 - %2", _component, _message, time] call _format) };
};

if (_type select 0) then { if (SLX_XEH_MACHINE select 0) then { { ADDON globalChat _x } forEach _msgAr } };
if (_type select 1) then { { if (_x != "") then { diag_log _x } } forEach _msgAr };
PUSH(GVAR(debug),_msgAr); // TODO: Evaluate cleanup system?