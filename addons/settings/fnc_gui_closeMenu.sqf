/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_gui_closeMenu

Description:
    Save settings and clean up temporary data.

Parameters:
    _save - Name of the setting <BOOLEAN>

Returns:
    None

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_save", false, [false]]];

if (_save) then {
    call FUNC(saveTempData);
};

GVAR(clientSettingsTemp) call CBA_fnc_deleteNamespace;
GVAR(clientSettingsTemp) = nil;

GVAR(serverSettingsTemp) call CBA_fnc_deleteNamespace;
GVAR(serverSettingsTemp) = nil;

GVAR(missionSettingsTemp) call CBA_fnc_deleteNamespace;
GVAR(missionSettingsTemp) = nil;
