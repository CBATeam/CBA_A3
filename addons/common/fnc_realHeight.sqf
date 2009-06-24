/* ----------------------------------------------------------------------------
Function: CBA_fnc_realHeight

Description:
	Real z coordinate of an object, for placing stuff on roofs, etc.
	
Parameters:

Returns:

Examples:
	(begin example)

	(end)

Author:

---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(realHeight);

private "_obj";
PARAMS_1(_obj);

((getpos _obj) select 2) + (_obj distance (getpos _obj))
