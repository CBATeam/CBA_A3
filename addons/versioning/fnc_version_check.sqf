#include "script_component.hpp"

// _key, _value  are injected by the CBA_fnc_hashEachPair

private _localValue = [GVAR(versions), _key] call CBA_fnc_hashGet;
TRACE_3("Version Check",_key,_value,_localValue);

private _failed = false;
private _localVersion = _localValue select 0;
private _remoteVersion = _value select 0;
private _level = _value select 1;
private _lc = count _localVersion; private _rc = count _remoteVersion;
switch _level do {
    case -1: { _level = _rc }; // All must match
    case -2: { _level = if (_lc == 0) then { 0 } else { _rc } }; // All must match, IF the addon is installed, otherwise ignore
};
if (_level == 0) exitWith {};

if (_level > _rc) then { _level = _rc };
if (_lc >= _level) then
{
    for "_i" from 0 to (_level - 1) do
    {
        private _local = _localVersion select _i;
        private _remote = _remoteVersion select _i;
        if (_local != _remote) exitWith { _failed = true; };
    };
} else {
    _failed = true;
};

if !(_failed) exitWith {};

// Default version mismatch handling, broadcast to all!
[format["%1 - Version Mismatch! (Machine: %2 (%6) version: %4, serverVersion: %3, Level: %5)", _key, player, _remoteVersion joinString ".", _localVersion joinString ".", _level, name player], QUOTE(ADDON), [CBA_display_ingame_warnings, true, true]] call CBA_fnc_debug;

// Allow custom handler
if (isText ((CFGSETTINGS) >> _key >> "handler")) then
{
    // TODO: PreCompile and spawn from Hash or so?
    [_remoteVersion, _localVersion, player, _level] spawn (call compile getText((CFGSETTINGS) >> _key >> "handler"));
};
// Actually disconnect em?
// endMission "END1"
