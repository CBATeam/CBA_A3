#define DEBUG_MODE_FULL
#include "script_component.hpp"

private ["_localVersion"]; // _key, _value  are injected by the CBA_fnc_hashEachPair
_localVersion = [GVAR(versions), _key] call CBA_fnc_hashGet;
TRACE_3("Version Check",_key,_value,_localVersion);
if (_localVersion != _value) then
{
	// Allow custom handler
	if (isText ((CFGSETTINGS) >> _key >> "handler")) then
	{
		// TODO: PreCompile and spawn from Hash or so?
		[_value, _localVersion, player] spawn (call compile getText((CFGSETTINGS) >> _key >> "handler"));
	};
	// Actually disconnect em? 
	// endMission "END1"

	// Default version mismatch handling, broadcast to all!
	[format["%1 - Version Mismatch! (Machine: %2, Server: %3, Local: %4)", _key, player, _value, _localVersion], QUOTE(ADDON), [true, true, true]] call CBA_fnc_debug;
};
