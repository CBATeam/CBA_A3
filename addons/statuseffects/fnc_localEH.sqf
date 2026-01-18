#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_statusEffects_fnc_localEH
Description:
    Handles locality switch, runs a respawn check and then reapplies all effect events.

Parameters:
    _object  - Vehicle that it will be attached to (player or vehicle) <OBJECT>
    _isLocal - Is local <BOOL>

Returns:
    None

Examples
    (begin example)
        [player, true] call CBA_statusEffects_fnc_localEH
    (end)

Author:
    PabstMirror
---------------------------------------------------------------------------- */
SCRIPT(localEH);
params ["_object", "_isLocal"];

// Only run this after the settings are initialized
// Need to wait for all EH to be installed (local event will happen between pre and post init)
if !(missionNamespace getVariable [QGVAR(ready), false]) exitWith {
    TRACE_1("pushing to runAtSettingsInitialized",_this);
    EGVAR(settings,runAtSettingsInitialized) pushBack [FUNC(localEH), _this];
};

if (!_isLocal) exitWith { TRACE_1("object no longer local",_this) };
if (isNull _object) exitWith { TRACE_1("object null",_this) };

// Reset any variables because of respawn
[_object, false] call FUNC(resetVariables);

// Send all Variables to client
[_object, ""] call FUNC(sendEffects);
