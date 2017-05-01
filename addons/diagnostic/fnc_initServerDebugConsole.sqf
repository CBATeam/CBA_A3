/* ----------------------------------------------------------------------------
Function: CBA_diagnostic_fnc_initServerDebugConsole

Description:
Adds addition watch statements that are run on the server and have their values returned to the client.

Author:
PabstMirror (based heavily on BIS's RscDebugConsole.sqf)
---------------------------------------------------------------------------- */

//#define DEBUG_MODE_FULL
#include "\a3\ui_f\hpp\defineResinclDesign.inc"
#include "script_component.hpp"

#define COUNT_WATCH_BOXES 4

if (!((getMissionConfigValue ["enableServerDebug", 0]) isEqualTo 1)) exitWith {};

params ["_display"];
TRACE_1("adding server watch debug",_display);

// adjust position of the controls group (make it wider)
private _debugConsole = _display displayCtrl IDC_RSCDEBUGCONSOLE_RSCDEBUGCONSOLE;
private _debugConsolePos = ctrlPosition _debugConsole;
_debugConsolePos set [2, (_debugConsolePos select 2) + 22.5 * (((safezoneW / safezoneH) min 1.2) / 40)];
_debugConsole ctrlSetPosition _debugConsolePos;
_debugConsole ctrlCommit 0;

// Add background and text:
private _serverWatchBackground = _display ctrlCreate ["RscText", -1, _debugConsole];
_serverWatchBackground ctrlSetBackgroundColor [0,0,0,0.7];
private _ctrlPos = ctrlPosition (_display displayCtrl IDC_RSCDEBUGCONSOLE_WATCHBACKGROUND);
_ctrlPos set [0, (_ctrlPos select 0) + 22.5 * (((safezoneW / safezoneH) min 1.2) / 40)];
_ctrlPos set [1, (_ctrlPos select 1) - 2 * (COUNT_WATCH_BOXES - 4) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)];
_ctrlPos set [3, (_ctrlPos select 3) + 2 * (COUNT_WATCH_BOXES - 4) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)];
_serverWatchBackground ctrlSetPosition _ctrlPos;
_serverWatchBackground ctrlCommit 0;
private _serverWatchText = _display ctrlCreate ["RscText", -1, _debugConsole];
_serverWatchText ctrlSetText format ["Server %1", localize "STR_A3_RscDebugConsole_WatchText"];
_serverWatchText ctrlSetFontHeight (0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25));
_ctrlPos set [0, (_ctrlPos select 0) + 0.2 * (((safezoneW / safezoneH) min 1.2) / 40)];
_ctrlPos set [3, 0.5 * (((safezoneW / safezoneH) min 1.2) / 40)];
_serverWatchText ctrlSetPosition _ctrlPos;
_serverWatchText ctrlCommit 0;


private _watchVars = [];
private _basePosition = ctrlPosition (_display displayCtrl IDC_RSCDEBUGCONSOLE_WATCHINPUT1);
_basePosition set [0, (_basePosition select 0) + 22.5 * (((safezoneW / safezoneH) min 1.2) / 40)];
_basePosition set [1, (_basePosition select 1) - 2 * (COUNT_WATCH_BOXES - 4) * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)];
for "_varIndex" from 0 to (COUNT_WATCH_BOXES - 1) do {
    private _profileVarName = format ["CBA_serverWatch_%1", _varIndex];
    private _savedStatement = profileNamespace getVariable [_profileVarName, ""];
    if (!(_savedStatement isEqualType "")) then {_savedStatement = ""};

    private _inputEditbox = _display ctrlCreate [QGVAR(watchInput), -1, _debugConsole];
    private _outputBackground = _display ctrlCreate ["RscText", -1, _debugConsole];
    private _outputEditBox = _display ctrlCreate [QGVAR(watchOutput), -1, _debugConsole];

    _outputBackground ctrlSetBackgroundColor [0,0,0,0.75];
    _inputEditbox ctrlSetText _savedStatement;

    _inputEditbox ctrlSetPosition _basePosition;
    _inputEditbox ctrlCommit 0;
    _basePosition set [1, (_basePosition select 1) + 1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)];

    _outputBackground ctrlSetPosition _basePosition;
    _outputBackground ctrlCommit 0;
    _outputEditBox ctrlSetPosition _basePosition;
    _outputEditBox ctrlCommit 0;
    _basePosition set [1, (_basePosition select 1) + 1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)];

    _watchVars pushBack [_inputEditbox, _outputBackground, _outputEditBox, -1];
};
_display setVariable [QGVAR(watchVars), _watchVars];


private _fnc_updateWatchInfo = {
    params ["_display"];

    private _watchVars = _display getVariable [QGVAR(watchVars), []];
    {
        private _varIndex = _forEachIndex;
        private _varName = format ["CBA_serverWatchVar_%1_%2", CBA_clientID, _varIndex];
        _x params ["_inputEditbox", "_outputBackground", "_outputEditBox", "_lastSent"];
        private _editText = ctrlText _inputEditbox;
        (missionNamespace getVariable [_varName, []]) params [["_responseStatement", "", [""]], ["_responseReturn", "", [""]], ["_duration", 0, [0]]];

        if (_editText == "") then {
            missionNamespace setVariable [_varName, nil];
        } else {
            if ((_editText isEqualTo _responseStatement) && {_duration > 0.1}) exitWith {}; // don't re-run if statement that took a long time
            if ((diag_tickTime - _lastSent) > random [0.1, 0.2, 0.3]) then {
                _x set [3, diag_tickTime]; // set last run to now
                [QGVAR(serverWatchVariable), [CBA_clientID, _varIndex, _editText]] call CBA_fnc_serverEvent; // send statement to server
            };
        };

        private _bgColor = switch (true) do {
        case (_duration < 0.0015): {[linearConversion [0.0001, 0.0015, _duration, 0, 0.4, true], linearConversion [0.0005, 0.0015, _duration, 0, 0.4, true], 0, 0.4]};
        case (_duration < 0.003): {[linearConversion [0.0015, 0.003, _duration, 0.4, 0.8, true], linearConversion [0.0015, 0.003, _duration, 0.4, 0.5, true], 0, 0.5]};
        case (_duration < 0.1): {[linearConversion [0.003, 0.05, _duration, 0.8, 1, true], linearConversion [0.003, 0.05, _duration, 0.5, 0.1, true], 0, 0.8]};
            default {[1,0,0,1]};
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
        private _varName = format ["CBA_serverWatchVar_%1_%2", CBA_clientID, _varIndex];
        private _editText = ctrlText _inputEditbox;
        (missionNamespace getVariable [_varName, []]) params [["_responseStatement", "", [""]], ["_responseReturn", "", [""]], ["_duration", 0, [0]]];

        if ((_editText isEqualTo _responseStatement) && {_duration < 0.1}) then {
            private _profileVarName = format ["CBA_serverWatch_%1", _varIndex];
            profileNamespace setVariable [_profileVarName, _responseStatement];
        };
    } forEach _watchVars;
};
_display displayAddEventHandler ["Unload", _fnc_onUnload];
