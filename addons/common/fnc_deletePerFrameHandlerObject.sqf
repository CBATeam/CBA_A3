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
#include "script_component.hpp"

params [["_logic", locationNull, [locationNull]]];

if (!isNull _logic) then {
    _logic call (_logic getVariable "end");

    (_logic getVariable "handle") call CBA_fnc_removePerFrameHandler;
    _logic call CBA_fnc_deleteNamespace;
};
