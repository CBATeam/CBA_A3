/* ----------------------------------------------------------------------------
Function: CBA_fnc_createCenter

Description:
	bla
	
Parameters:
	bla

Returns:
	Center [Side]
	
Examples:
	(begin example)
	(end)

Author:
	Sickboy
---------------------------------------------------------------------------- */
#include "script_component.hpp"

PARAMS_1(_side);
// TODO: Add _side if already a unit exists on this side ? by trying to create one or otherwise
if (_side in GVAR(centers)) then { _side } else { createCenter _side };
