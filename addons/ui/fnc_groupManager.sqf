#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_groupManager

Description:
    Opens group manager in 3D editor.

Parameters:
    None

Returns:
    Nothing

Examples:
    (begin example)
        call (uiNamespace getVariable "CBA_fnc_groupManager");
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

#define GET_DISPLAY_NAME(unit) getText (configFile >> "CfgVehicles" >> unit >> "displayName")
#define GET_VAR_NAME(unit) ((unit) get3DENAttribute "name")
#define GET_SLOT_NAME(unit) ((unit) get3DENAttribute "description")

private _editor = uiNamespace getVariable "Display3DEN";
private _display = _editor createDisplay QGVAR(GroupManager);

private _ctrlGroups = _display displayCtrl IDC_LM_SLOTS;

for "_i" from 1 to 30 do {
    _ctrlGroups lbAdd format ["dummy group %1", _i];
};

systemChat str _display;
_display




//groupId (allGroups#0)





