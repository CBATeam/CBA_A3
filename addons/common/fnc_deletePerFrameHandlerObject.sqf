#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_deletePerFrameHandlerObject

Description:
    Deletes a PFH object that was previously created via CBA_fnc_createPerFrameHandlerObject

Parameters:
    _logic - The PFH object <LOCATION>

Returns:
    None

Examples:
    (begin example)
        _pfhLogic call CBA_fnc_deletePerFrameHandlerObject;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

params [["_logic", locationNull, [locationNull]]];

_logic setVariable ["exit_condition", {true}];
