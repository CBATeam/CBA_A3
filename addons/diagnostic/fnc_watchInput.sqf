#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_diagnostic_fnc_watchInput

Description:
    Handle events on the watch input controls

Parameters:
    _event - The event that triggered the function
    _args - The arguments passed to the event

Returns:
    nil

Examples:
    (begin example)
        [1] call CBA_diagnostic_fnc_watchInput;
    (end)

Author:
    Brett Mayson
---------------------------------------------------------------------------- */

params ["_event", "_args"];

if (_event == "start") exitWith {
    if (isNil QGVAR(watchControls)) then {
        GVAR(watchControls) = [controlNull, controlNull, controlNull, controlNull];
        GVAR(watchStatements) = ["","", "", ""];
        addMissionEventHandler ["Draw2D", {call FUNC(watchUpdate)}];
    };
};

_args params ["_ctrl"];

private _ctrlCheckbox = _ctrl;

private _idc = ctrlIDC _ctrl;
if (_idc < 100000) then {
    _idc = _idc + 100000;
} else {
    _ctrl = (ctrlParent _ctrl) displayCtrl (_idc - 100000);
};
private _index = switch (_idc) do {
    case IDC_DEBUGCONSOLE_WATCHINPUT_1: {
        0
    };
    case IDC_DEBUGCONSOLE_WATCHINPUT_2: {
        1
    };
    case IDC_DEBUGCONSOLE_WATCHINPUT_3: {
        2
    };
    case IDC_DEBUGCONSOLE_WATCHINPUT_4: {
        3
    };
    default {
        -1
    }
};

if (_index < 0) exitWith {
    ERROR_1("Invalid control ID for watch toggle, control ID: %1",ctrlIDC _ctrl);
};

if (_event == "loadCheckbox") exitWith {
    _ctrlCheckbox cbSetChecked (!isNull (GVAR(watchControls) select _index));
};

if (_event != "load") then {
    private _statement = ctrlText _ctrl;
    GVAR(watchStatements) set [_index, [_statement, compile _statement]];
};

switch (_event) do {
    case "killFocus": {
        _ctrl setVariable ['RscDebugConsole_watchPaused', false];
    };
    case "checked": {
        if ((_args select 1) == 1) then {
            [_index] call CBA_diagnostic_fnc_watchStart;
        } else {
            [_index] call CBA_diagnostic_fnc_watchStop;
        };
    }
};
