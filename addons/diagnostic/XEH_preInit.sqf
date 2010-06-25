#include "script_component.hpp"
LOG(MSG_INIT);

[QUOTE(GVAR(debug)), { _this call CBA_fnc_debug }] call CBA_fnc_addEventHandler;

if (isServer) then
{
	FUNC(handle_peak) =
	{
		PARAMS_1(_variable);
		if (isNil _variable) then
		{
			[QUOTE(GVAR(receive_peak)), [_variable, nil]] call CBA_fnc_globalEvent;
		} else {
			[QUOTE(GVAR(receive_peak)), [_variable, call compile _variable]] call CBA_fnc_globalEvent;
		}; 
		
	};
	[QUOTE(GVAR(peek)), { _this call CBA_fnc_handle_peak }] call CBA_fnc_addEventHandler;
};

PREP(perf_loop);

