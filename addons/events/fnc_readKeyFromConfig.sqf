/* ----------------------------------------------------------------------------
Function: CBA_fnc_readKeyFromConfig
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(readKeyFromConfig);

private ["_component", "_action", "_settings", "_i"];
_component = _this select 0;
_action = _this select 1;
_settings = [false, false, false];
if (isNumber(CFGSETTINGS >> _component >> _action)) exitWith
{
	#ifdef DEBUG
		[format["readKeyFromConfig: %1, Found: %2", _this, getNumber(CFGSETTINGS >> _component >> _action)], QUOTE(ADDON)] call CBA_fDebug;
	#endif
	[getNumber(CFGSETTINGS >> _component >> _action), _settings]
};

if (isClass(CFGSETTINGS >> _component >> _action)) exitWith
{
	#ifdef DEBUG
		[format["readKeyFromConfig: %1, Found: %2", _this, getNumber(CFGSETTINGS >> _component >> _action >> "key")], QUOTE(ADDON)] call CBA_fDebug;
	#endif
	_i = 0;
	{
		if (getNumber(CFGSETTINGS >> _component >> _action >> _x) == 1) then { _settings set [_i, true] };
		INC(_i);
	} forEach ["shift", "ctrl", "alt"];
	[getNumber(CFGSETTINGS >> _component >> _action >> "key"), _settings]
};

[-1, _settings]