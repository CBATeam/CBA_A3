#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_help_fnc_setVersionLine

Description:
    Displays all CfgPatches with a "versionDesc" entry in the main menu.

    Mods are cycled automatically every 4 seconds or can be browsed using LMB and RMB.
    Double clicking executes the script in "versionAct".

Parameters:
    0: _control - Either version line or button control <CONTROL>
    1: _key     - 0: LMB - next mod, 1: RMB - previous mod <NUMBER> (optional, default: 0)

Returns:
    None
---------------------------------------------------------------------------- */

params ["_control", ["_key", 0]];

private _display = ctrlParent _control;

private _ctrlText = _display displayCtrl IDC_VERSION_TEXT;
private _ctrlButton = _display displayCtrl IDC_VERSION_BUTTON;

// create addon list
if (isNil {uiNamespace getVariable QGVAR(VerList)}) then {
    private _verList = [];
    uiNamespace setVariable [QGVAR(VerList), _verList];

    // gather version info
    {
        private _entry = _x;

        private _verLine = format ["%1 v%2", getText (_entry >> "versionDesc"), getText (_entry >> "version")];
        private _verAct = getText (_entry >> "versionAct");

        _verList pushBack [_verLine, _verAct];
    } forEach ("isText (_x >> 'versionDesc')" configClasses (configFile >> "CfgPatches"));
};

// start loop that cycles through all addons
terminate (uiNamespace getVariable [QGVAR(VerScript), scriptNull]);

private _verScript = [_control] spawn { // will terminate when main menu mission exits
    uiSleep 4;
    isNil (uiNamespace getVariable QFUNC(setVersionLine)); // execute unscheduled
};

uiNamespace setVariable [QGVAR(VerScript), _verScript];

// start loop with mouse moving event on main menu. this is used, because loops can't be used at that point
if (isNull (uiNamespace getVariable [QGVAR(VerScriptFlag), displayNull])) then {
    uiNamespace setVariable [QGVAR(VerScriptFlag), _display];

    _display displayAddEventHandler ["MouseMoving", {
        params ["_display"];

        if (!scriptDone (uiNamespace getVariable [QGVAR(VerScript), scriptNull])) exitWith {};

        private _verScript = [allControls _display select 0] spawn { // will terminate when main menu mission exits
            uiSleep 4;
            isNil (uiNamespace getVariable QFUNC(setVersionLine)); // execute unscheduled
        };

        uiNamespace setVariable [QGVAR(VerScript), _verScript];
    }];
};

// left click forward, other click back
if (isNil {uiNamespace getVariable QGVAR(VerNext)}) then {
    uiNamespace setVariable [QGVAR(VerNext), -1];
};

private _next = uiNamespace getVariable QGVAR(VerNext);

if (_key isEqualTo 0) then {
    _next = _next + 1;
} else {
    _next = _next - 1;
};

// stay in bounds
_verList = uiNamespace getVariable QGVAR(VerList);

if (_next >= count _verList) then {
    _next = 0;
} else {
    if (_next < 0) then {
        _next = count _verList - 1;
    };
};

uiNamespace setVariable [QGVAR(VerNext), _next];

// add single line
(_verList select _next) params ["_verLine", "_verAct"];

_ctrlText ctrlSetText _verLine; // print version line
_ctrlButton ctrlSetEventHandler ["MouseButtonDblClick", _verAct]; // set double-click action if any
