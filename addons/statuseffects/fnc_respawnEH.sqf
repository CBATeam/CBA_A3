#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_statusEffects_fnc_respawnEH
Description:
    Handles the Respawn Event Handler to reset effects.

Parameters:
    _object - Vehicle that it will be attached to (player or vehicle) <OBJECT>

Returns:
    None

Examples
    (begin example)
        [player, objNull] call CBA_statusEffects_fnc_respawnEH
    (end)

Author:
    PabstMirror
---------------------------------------------------------------------------- */
SCRIPT(respawnEH);
params ["_object"];

// Only run this after the settings are initialized
// Need to wait for all EH to be installed (local event will happen between pre and post init)
if !(GVAR(settingsInitFinished)) exitWith { // TODO: Switch to CBA equivalent, was ace_common_...
    TRACE_1("pushing to runAtSettingsInitialized",_this);
    GVAR(runAtSettingsInitialized) pushBack [FUNC(respawnEH), _this];
};

if (!local _object) exitWith {TRACE_1("object no longer local",_this)};
if (isNull _object) exitWith {TRACE_1("object null",_this)};

 // Reset any variables on "real" respawn
[_object, false] call FUNC(resetVariables);

// Send all Variables to client
[_object, ""] call FUNC(sendEffects);
