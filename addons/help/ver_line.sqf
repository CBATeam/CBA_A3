//#define DEBUG_MODE_FULL
#include "script_component.hpp"

disableSerialization;

// get display
params [["_display", displayNull, [displayNull, controlNull]], ["_key", 0]];

if (_display isEqualType controlNull) then {
    _display = ctrlParent _display;
};

private _ctrl = _display displayCtrl CBA_CREDITS_VER_IDC;
private _ctrlBtn = _display displayCtrl CBA_CREDITS_VER_BTN_IDC;

if (isNull _ctrl) exitWith {};

// create addon list
if (isNil {uiNamespace getVariable QGVAR(VerList)}) then {
    private _verList = [];
    uiNamespace setVariable [QGVAR(VerList), _verList];

    // align with BI version position
    private _posX = __RIX(-21);
    private _posY = __IY(23);
    private _posW = __IW(8);
    private _posH = __IH(1);

    _ctrl ctrlSetPosition [_posX, _posY, _posW, _posH];
    _ctrl ctrlCommit 0;

    // button align
    _ctrlBtn ctrlSetPosition [_posX, _posY, _posW, _posH];
    _ctrlBtn ctrlCommit 0;

    // gather version info
    _config = configFile >> "CfgPatches";

    {
        private _entry = _x;

        private _verLine = format ["%1 v%2", getText (_entry >> "versionDesc"), getText (_entry >> "version")];
        private _verAct = getText (_entry >> "versionAct");

        _verList pushBack [_verLine, _verAct];
    } forEach ("isText (_x >> 'versionDesc')" configClasses _config);
};

// start loop that cycles through all addons
terminate (_display getVariable [QGVAR(VerScript), scriptNull]);

private _verScript = [_display] spawn { // will terminate when main menu mission exits
    uiSleep 3;
    QUOTE(_this call COMPILE_FILE(ver_line)) configClasses (configFile >> "CBA_DirectCall");
};

_display setVariable [QGVAR(VerScript), _verScript];

// start loop with mouse moving event on main menu. this is used, because loops can't be used at that point
if !(_display getVariable [QGVAR(VerScriptFlag), false]) then {
    _display setVariable [QGVAR(VerScriptFlag), true];
    _display displayAddEventHandler ["mouseMoving", {
        params ["_display"];

        if (!scriptDone (_display getVariable [QGVAR(VerScript), scriptNull])) exitWith {};

        private _verScript = [_display] spawn { // will terminate when main menu mission exits
            uiSleep 3;
            QUOTE(_this call COMPILE_FILE(ver_line)) configClasses (configFile >> "CBA_DirectCall");
        };

        _display setVariable [QGVAR(VerScript), _verScript];
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

_ctrl ctrlSetText _verLine; // print version line
_ctrlBtn ctrlSetEventHandler ["MouseButtonDblClick", _verAct]; // set double-click action if any
