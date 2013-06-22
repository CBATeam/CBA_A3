/* ----------------------------------------------------------------------------
Function: CBA_fnc_peek

Description:
	Peek at variable on the server
	To receive the variable content back, you will have to
	["cba_diagnostics_receive_peak", {_this call myFunction}] call CBA_fnc_addEventHandler;

Parameters:
        _variable - string

Returns:
	nil

Author:
	Sickboy
-----------------------------------------------------------------------------*/
#include "script_component.hpp"

SCRIPT(peek);
PARAMS_1(_variable);

// ----------------------------------------------------------------------------

[GVAR(peek), _variable] call CBA_fnc_globalEvent;

nil;
