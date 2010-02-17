#include "script_component.hpp"

private ["_localValue", "_remoteVersion", "_localVersion", "_lc", "_rc", "_level", "_local", "_remote", "_failed"]; // _key, _value  are injected by the CBA_fnc_hashEachPair

_localValue = [GVAR(versions), _key] call CBA_fnc_hashGet;
TRACE_3("Version Check",_key,_value,_localValue);

_failed = false;
_localVersion = _localValue select 0;
_remoteVersion = _value select 0;
_level = _value select 1;
_lc = count _localVersion; _rc = count _remoteVersion;
if (_level == -1) then { _level = _rc };
if (_level == 0) exitWith {};

if (_level > _rc) then { _level = _rc };
if (_lc >= _level) then
{
	for "_i" from 0 to (_level - 1) do
	{
		_local = _localVersion select _i;
		_remote = _remoteVersion select _i;
		if (_local != _remote) exitWith { _failed = true; };
	};
} else {
	_failed = true;
};

if !(_failed) exitWith {};

// Default version mismatch handling, broadcast to all!
[format["%1 - Version Mismatch! (Machine: %2, Server: %3, Local: %4, Level: %5)", _key, player, _value, _localValue, _level], QUOTE(ADDON), [true, true, true]] call CBA_fnc_debug;

// Allow custom handler
if (isText ((CFGSETTINGS) >> _key >> "handler")) then
{
	// TODO: PreCompile and spawn from Hash or so?
	[_remoteVersion, _localVersion, player, _level] spawn (call compile getText((CFGSETTINGS) >> _key >> "handler"));
};
// Actually disconnect em? 
// endMission "END1"
