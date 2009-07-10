/* ----------------------------------------------------------------------------
Function: CBA_fnc_readKeyFromConfig
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(readKeyFromConfig);

private ["_component", "_action", "_settings", "_i"];
PARAMS_2(_component,_action);
_settings = [false, false, false];
if (isNumber(CFGSETTINGS >> _component >> _action)) exitWith
{
	#ifdef DEBUG_MODE_FULL
		[format["readKeyFromConfig: %1, Found: %2", _this, getNumber(CFGSETTINGS >> _component >> _action)], QUOTE(ADDON)] call CBA_fnc_debug;
	#endif
	[getNumber(CFGSETTINGS >> _component >> _action), _settings]
};

if (isClass(CFGSETTINGS >> _component >> _action)) exitWith
{
	#ifdef DEBUG_MODE_FULL
		[format["readKeyFromConfig: %1, Found: %2", _this, getNumber(CFGSETTINGS >> _component >> _action >> "key")], QUOTE(ADDON)] call CBA_fnc_debug;
	#endif
	_i = 0;
	{
		if (getNumber(CFGSETTINGS >> _component >> _action >> _x) == 1) then { _settings set [_i, true] };
		INC(_i);
	} forEach ["shift", "ctrl", "alt"];
	[getNumber(CFGSETTINGS >> _component >> _action >> "key"), _settings]
};

[-1, _settings]
