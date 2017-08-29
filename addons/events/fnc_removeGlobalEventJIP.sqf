/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeGlobalEventJIP

Description:
    Removes a globalEventJIP ID. Optionaly will wait until an object is deleted.

Parameters:
    _jipID  - A unique ID from CBA_fnc_globalEventJIP. <STRING>
    _object - Object, will remove jip EH when object is deleted. Or pass nil to ignore and remove immediately [optional] <OBJECT>or<NIL>

Returns:
    Nothing

Author:
    PabstMirror (idea from Dystopian)
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(removeGlobalEventJIP);

params [["_jipID", "", [""]], ["_object", nil, [nil, objNull]]];

if ((isNil "_object") || {isNull _object}) then {
    GVAR(eventNamespaceJIP) setVariable [_jipID, nil, true];
} else {
    [_object, "Deleted", {
        GVAR(eventNamespaceJIP) setVariable [_thisArgs, nil, true];
    }, _jipID] call CBA_fnc_addBISEventHandler;
};
