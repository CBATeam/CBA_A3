#include "script_component.hpp"
private ["_settings", "_code"];
#ifdef DEBUG
	private ["_ar"];
	_ar = [];
#endif
{
	_settings = _x select 0;
	_code = _x select 1;
	if (true) then
	{
		if (_settings select 0 && !(_this select 2)) exitWith {};
		if (_settings select 1 && !(_this select 3)) exitWith {};
		if (_settings select 2 && !(_this select 4)) exitWith {};
		if (!(_settings select 0) && _this select 2) exitWith {};
		if (!(_settings select 1) && _this select 3) exitWith {};
		if (!(_settings select 2) && _this select 4) exitWith {};
		#ifdef DEBUG
			PUSH(_ar,_code);
		#endif
		_this call _code;
	};
} forEach (GVAR(keys) select (_this select 1));
#ifdef DEBUG
	if (count _ar > 0) then
	{
		[format["KeyPressed: %1, Executing: %2", _this, _ar], QUOTE(ADDON)] call CBA_fDebug;
	} else {
		[format["KeyPressed: %1, No Execution", _this], QUOTE(ADDON)] call CBA_fDebug;
	};
#endif
