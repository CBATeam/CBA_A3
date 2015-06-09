/* ----------------------------------------------------------------------------
Function: CBA_fnc_locked

Description:
    A3 compatible locked function.

    The locked scripting command returns a numeric value.
    This function returns a boolean.

Parameters:
    _object - The object the locked check is done for.
Returns:
    true if _object is locked otherwise false
Examples:
    (begin example)
    _islocked = myVehicle call CBA_fnc_locked;
    (end)

Author:
    Killswitch
---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(locked);

locked _this > 1
