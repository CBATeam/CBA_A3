/* ----------------------------------------------------------------------------
Function: CBA_fnc_locked

Description:
	A2/OA/TOH compatible locked function
	The locked scripting command changed in TOH, it returns a number instead of a boolean.

Parameters:
	_object - The object the locked check is done for.
Returns:
	true if _object is locked otherwise false
Examples:
	(begin example)
	_islocked = myVehicle call CBA_fnc_locked;
	(end)

Author:
	Xeno
---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(locked);

if (call FUNC(determineGame) > 1) then {
	locked _this > 1
} else {
	locked _this
}
