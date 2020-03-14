#include "\a3\ui_f\hpp\defineResinclDesign.inc"
#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_diagnostic_fnc_initTargetDebugConsole

Description:
    Adds additional watch statements that are run on a remote target and have their values returned to the client.
    Requires `EnableTargetDebug = 1;` in addon root config or description.ext or 3den scenario attribute with the same name

Author:
    (based on BIS's RscDebugConsole.sqf)
    PabstMirror
    commy2
---------------------------------------------------------------------------- */

#define COUNT_WATCH_BOXES 8
#define EXEC_RESULT ([nil] apply {[] call _this} param [0, text "<any>"])
#define EXEC_RESULT_CTRL (parsingNamespace getVariable ["BIS_RscDebugConsoleExpressionResultCtrl", controlNull])
#define EXEC_SEND_RESULT {[EXEC_RESULT, {EXEC_RESULT_CTRL ctrlSetText str _this}] remoteExec ["call", remoteExecutedOwner]}

if !(getMissionConfigValue ["EnableTargetDebug", 0] == 1 || {getNumber (configFile >> "EnableTargetDebug") == 1}) exitWith {};

params ["_display"];
TRACE_1("adding server watch debug",_display);

// adjust position of the main controls group to make it wider (may be slightly cut off with "Very-Large" text size)
private _debugConsole = _display displayCtrl IDC_RSCDEBUGCONSOLE_RSCDEBUGCONSOLE;
private _debugConsolePos = ctrlPosition _debugConsole;

_debugConsolePos set [2, (_debugConsolePos select 2) + 22.5 * GUI_GRID_W];
_debugConsole ctrlSetPosition _debugConsolePos;
_debugConsole ctrlCommit 0;

private _basePosition = ctrlPosition (_display displayCtrl IDC_RSCDEBUGCONSOLE_WATCHINPUT1);
_basePosition set [0, (_basePosition select 0) + 22.5 * GUI_GRID_W];
_basePosition set [1, (_basePosition select 1) - (1.5 + 2 * (COUNT_WATCH_BOXES - 4)) * GUI_GRID_H];

// Add background and "Target Watch" text:
private _targetWatchBackground = _display ctrlCreate ["RscText", -1, _debugConsole];
_targetWatchBackground ctrlSetBackgroundColor [0, 0, 0, 0.7];

private _ctrlPos = ctrlPosition (_display displayCtrl IDC_RSCDEBUGCONSOLE_WATCHBACKGROUND);
_ctrlPos set [0, (_ctrlPos select 0) + 22.5 * GUI_GRID_W];
_ctrlPos set [1, (_ctrlPos select 1) - (1.5 + 2 * (COUNT_WATCH_BOXES - 4)) * GUI_GRID_H];
_ctrlPos set [3, (_ctrlPos select 3) + (1.5 + 2 * (COUNT_WATCH_BOXES - 4)) * GUI_GRID_H];
_targetWatchBackground ctrlSetPosition _ctrlPos;
_targetWatchBackground ctrlCommit 0;

private _targetWatchText = _display ctrlCreate ["RscText", -1, _debugConsole];
_targetWatchText ctrlSetText format ["%1 %2", localize "str_watch_target", localize "STR_A3_RscDebugConsole_WatchText"];
_targetWatchText ctrlSetFontHeight (0.7 * GUI_GRID_H);
_ctrlPos set [0, (_ctrlPos select 0) + 0.2 * GUI_GRID_W];
_ctrlPos set [3, 0.5 * GUI_GRID_W];
_targetWatchText ctrlSetPosition _ctrlPos;
_targetWatchText ctrlCommit 0;

// Add target selector list
private _clientList = _display ctrlCreate ["RscXListBox", -1, _debugConsole];
// Note: RscCombo is a better choice for this, but seems to have stopped working with 1.76, try to switch back in the future
_clientList ctrlSetPosition _basePosition;
_clientList ctrlCommit 0;
_basePosition set [1, (_basePosition select 1) + 1.5 * GUI_GRID_H];

// - add available targets to list
private _lastSelected = 0;
{
    _x params ["_clientID", "_profileName"];
    _clientList lbSetValue [_clientList lbAdd format ["%1 - %2", _clientID, _profileName], _clientID];
    if (_clientID == GVAR(selectedClientID)) then {_lastSelected = _forEachIndex};
} forEach GVAR(clientIDs);

_clientList lbSetCurSel _lastSelected;
GVAR(selectedClientID) = _clientList lbValue lbCurSel _clientList;

_clientList ctrlAddEventHandler ["LBSelChanged", {
    params ["_clientList", "_index"];

    GVAR(selectedClientID) = _clientList lbValue _index;
}];

// Add TARGET EXEC button
private _serverExec = _display displayCtrl IDC_RSCDEBUGCONSOLE_BUTTONEXECUTESERVER;
_serverExec ctrlShow false;
_serverExec ctrlEnable false;

private _targetExec = _display ctrlCreate ["RscButtonMenu", -1, _debugConsole];
_targetExec ctrlSetPosition ctrlPosition _serverExec;
_targetExec ctrlCommit 0;
_targetExec ctrlSetText toUpper LLSTRING(TargetExec);

_targetExec ctrlAddEventHandler ["ButtonClick", {
    params ["_targetExec"];
    private _statement = ctrlText (ctrlParentControlsGroup _targetExec controlsGroupCtrl IDC_RSCDEBUGCONSOLE_EXPRESSION);

    [compile _statement, EXEC_SEND_RESULT] remoteExec ["call", GVAR(selectedClientID)];
}];

_targetExec ctrlAddEventHandler ["MouseButtonUp", {
    _this call FUNC(logStatement);
    false
}];

private _watchVars = [];
for "_varIndex" from 0 to (COUNT_WATCH_BOXES - 1) do {
    // Create the controls for each row and fill input with last saved value from profile
    private _profileVarName = format ["CBA_targetWatch_%1", _varIndex];
    private _savedStatement = profileNamespace getVariable [_profileVarName, ""];
    if (!(_savedStatement isEqualType "")) then {_savedStatement = ""};

    private _inputEditbox = _display ctrlCreate [QGVAR(watchInput), -1, _debugConsole];
    private _outputBackground = _display ctrlCreate ["RscText", -1, _debugConsole];
    private _outputEditBox = _display ctrlCreate [QGVAR(watchOutput), -1, _debugConsole];

    _outputBackground ctrlSetBackgroundColor [0, 0, 0, 0.75];
    _inputEditbox ctrlSetText _savedStatement;

    _inputEditbox ctrlSetPosition _basePosition;
    _inputEditbox ctrlCommit 0;
    _basePosition set [1, (_basePosition select 1) + 1 * GUI_GRID_H];

    _outputBackground ctrlSetPosition _basePosition;
    _outputBackground ctrlCommit 0;
    _outputEditBox ctrlSetPosition _basePosition;
    _outputEditBox ctrlCommit 0;
    _basePosition set [1, (_basePosition select 1) + 1 * GUI_GRID_H];

    _watchVars pushBack [_inputEditbox, _outputBackground, _outputEditBox, -1];
};
_display setVariable [QGVAR(watchVars), _watchVars];

// Runs constantly, sends statement to target and parses the result back in the output window
private _fnc_updateWatchInfo = {
    params ["_display"];

    private _watchVars = _display getVariable [QGVAR(watchVars), []];
    {
        private _varIndex = _forEachIndex;
        private _varName = format ["CBA_targetWatchVar_%1_%2", CBA_clientID, _varIndex];
        _x params ["_inputEditbox", "_outputBackground", "_outputEditBox", "_lastSent"];
        private _editText = ctrlText _inputEditbox;
        (missionNamespace getVariable [_varName, []]) params [["_responseStatement", "", [""]], ["_responseReturn", "", [""]], ["_duration", 0, [0]]];

        if (_editText == "") then {
            missionNamespace setVariable [_varName, nil];
        } else {
            if ((_editText isEqualTo _responseStatement) && {_duration > 0.1}) exitWith {}; // don't re-run if statement that took a long time
            if ((diag_tickTime - _lastSent) > random [0.1, 0.2, 0.3]) then {
                _x set [3, diag_tickTime]; // set last run to now
                [QGVAR(watchVariable), [CBA_clientID, _varIndex, _editText], GVAR(selectedClientID)] call CBA_fnc_ownerEvent; // send statement to target
            };
        };

        private _bgColor = switch (true) do {
            case (_duration < 0.0015): {
                [linearConversion [0.0001, 0.0015, _duration, 0, 0.4, true], linearConversion [0.0005, 0.0015, _duration, 0, 0.4, true], 0, 0.4];
            };
            case (_duration < 0.003): {
                [linearConversion [0.0015, 0.003, _duration, 0.4, 0.8, true], linearConversion [0.0015, 0.003, _duration, 0.4, 0.5, true], 0, 0.5];
            };
            case (_duration < 0.1): {
                [linearConversion [0.003, 0.05, _duration, 0.8, 1, true], linearConversion [0.003, 0.05, _duration, 0.5, 0.1, true], 0, 0.8];
            };
            default {[1, 0, 0, 1]};
        };
        _outputEditBox ctrlSetText _responseReturn;
        _outputBackground ctrlSetBackgroundColor _bgColor;
    } forEach _watchVars;
};
_display displayAddEventHandler ["MouseMoving", _fnc_updateWatchInfo];
_display displayAddEventHandler ["MouseHolding", _fnc_updateWatchInfo];


// On unload, save the statements to profile (only if they didn't stall badly)
private _fnc_onUnload = {
    params ["_display"];

    private _watchVars = _display getVariable [QGVAR(watchVars), []];
    {
        _x params ["_inputEditbox", "_outputBackground", "_outputEditBox", "_lastSent"];
        private _varIndex = _forEachIndex;
        private _varName = format ["CBA_targetWatchVar_%1_%2", CBA_clientID, _varIndex];
        private _editText = ctrlText _inputEditbox;
        (missionNamespace getVariable [_varName, []]) params [["_responseStatement", "", [""]], ["_responseReturn", "", [""]], ["_duration", 0, [0]]];

        if ((_editText isEqualTo _responseStatement) && {_duration < 0.1}) then {
            private _profileVarName = format ["CBA_targetWatch_%1", _varIndex];
            profileNamespace setVariable [_profileVarName, _responseStatement];
        };
    } forEach _watchVars;
};
_display displayAddEventHandler ["Unload", _fnc_onUnload];
