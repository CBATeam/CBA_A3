#include "\a3\ui_f\hpp\defineResinclDesign.inc"
#include "script_component.hpp"

#define MAX_STATEMENTS 50
#define INDENT_SPACES "    "

params ["_display"];

// adjust position of the controls group
private _debugConsole = _display displayCtrl IDC_RSCDEBUGCONSOLE_RSCDEBUGCONSOLE;

_debugConsole ctrlSetPosition [
    ctrlPosition _debugConsole select 0, // keep X
    safezoneY + 1 * GUI_GRID_H, // top edge of the screen
    22 * GUI_GRID_W, // slightly wider
    1 - 2 * safezoneY // full screen height
];
_debugConsole ctrlCommit 0;

// --- adjust positions of all but a few controls
#define EXCLUDE [0, IDC_RSCDEBUGCONSOLE_LINK, IDC_RSCDEBUGCONSOLE_TITLE, IDC_RSCDEBUGCONSOLE_EXPRESSIONBACKGROUND, IDC_RSCDEBUGCONSOLE_EXPRESSIONTEXT, IDC_RSCDEBUGCONSOLE_EXPRESSION, IDC_RSCDEBUGCONSOLE_EXPRESSIONOUTPUT, IDC_RSCDEBUGCONSOLE_EXPRESSIONOUTPUTBACKGROUND]

{
    if (ctrlParentControlsGroup _x == _debugConsole && {!(ctrlIDC _x in EXCLUDE)}) then {
        private _position = ctrlPosition _x;
        _position set [1, (_position select 1) + safezoneH - 25 * GUI_GRID_H];

        _x ctrlSetPosition _position;
        _x ctrlCommit 0;
    };
} forEach allControls _display;

// flavor title
private _title = _display displayCtrl IDC_RSCDEBUGCONSOLE_TITLE;
_title ctrlSetText LLSTRING(ExtendedDebugConsole);

// --- EXPRESSION edit box
private _expression = _display displayCtrl IDC_RSCDEBUGCONSOLE_EXPRESSION;

private _position = ctrlPosition _expression;
_position set [3, safezoneH - 20.25 * GUI_GRID_H];

_expression ctrlSetPosition _position;
_expression ctrlCommit 0;

// Save expression when hitting enter key inside expression text field
_expression ctrlAddEventHandler ["KeyDown", {
    params ["_expression", "_key", "_shift"];

    if (_key in [DIK_RETURN, DIK_NUMPADENTER] && {!_shift}) then { // shift + enter is newline
        // fix for enter key not working in MP
        private _buttonLocalExec = ctrlParentControlsGroup _expression controlsGroupCtrl IDC_RSCDEBUGCONSOLE_BUTTONEXECUTELOCAL;

        if (isMultiplayer && {ctrlEnabled _buttonLocalExec}) then {
            [
                "executeButton",
                [ctrlParent _buttonLocalExec, _buttonLocalExec],
                "RscDisplayDebugPublic",
                0
            ] call compile preprocessFileLineNumbers "\A3\Ui_f\scripts\GUI\RscDebugConsole.sqf";

            playSound "SoundClick";
        };

        _this call FUNC(logStatement);
    };

    if (_key isEqualTo DIK_TAB) then {
        _expression setVariable [QGVAR(tabKey), [true, _shift]];
    };

    false
}];

// Reset Tab status on autocomplete
_expression ctrlAddEventHandler ["KeyUp", {
    params ["_expression", "_key"];

    if (_key isEqualTo DIK_TAB) then {
        _expression setVariable [QGVAR(tabKey), nil];
    };
}];

// Tab without autocomplete will move focus to another control, add whitespace
_expression ctrlAddEventHandler ["KillFocus", {
    params ["_expression"];

    if (GVAR(ConsoleIndentType) == -1) exitWith {};

    private _tabKey = _expression getVariable [QGVAR(tabKey), [false, false]];
    if (_tabKey isEqualTo [true, false]) then {
        (ctrlTextSelection _expression) params ["_selStart", "_selLength"];
        private _text = ctrlText _expression;

        // replace selection with whitespace
        private _indentType = [INDENT_SPACES, INDENT_TAB] select GVAR(ConsoleIndentType);
        _expression ctrlSetText ([_text select [0, _selStart], _text select [_selStart + _selLength, count _text - 1]] joinString _indentType);
        _expression ctrlSetTextSelection [_selStart + count _indentType, 0];

        // change focus on next frame, using spawn as CBA_fnc_execNextFrame will not work in editor
        _expression spawn {
            ctrlSetFocus _this;
        };
    };

    if (_tabKey isEqualTo [true, true]) then {
        (ctrlTextSelection _expression) params ["_selStart"];
        private _text = ctrlText _expression;

        [_expression, _text, _selStart] call FUNC(removeIndentation);

        // change focus on next frame, using spawn as CBA_fnc_execNextFrame will not work in editor
        _expression spawn {
            ctrlSetFocus _this;
        };

    };

    _expression setVariable [QGVAR(tabDown), nil];
}];

private _expressionBackground = _display displayCtrl IDC_RSCDEBUGCONSOLE_EXPRESSIONBACKGROUND;

_position = ctrlPosition _expressionBackground;
_position set [3, safezoneH - 18.25 * GUI_GRID_H];

_expressionBackground ctrlSetPosition _position;
_expressionBackground ctrlCommit 0;

// --- EXPRESSION box output
{
    private _expressionOutput = _display displayCtrl _x;

    _position = ctrlPosition _expressionOutput;
    _position set [1, (_position select 1) + safezoneH - 26.05 * GUI_GRID_H];

    _expressionOutput ctrlSetPosition _position;
    _expressionOutput ctrlCommit 0;
} forEach [IDC_RSCDEBUGCONSOLE_EXPRESSIONOUTPUT, IDC_RSCDEBUGCONSOLE_EXPRESSIONOUTPUTBACKGROUND];

// --- PREV button
private _prevButton = _display ctrlCreate ["RscButtonMenu", IDC_DEBUGCONSOLE_PREV, _debugConsole];

_prevButton ctrlSetPosition [
    0 * GUI_GRID_W,
    9.25 * GUI_GRID_H + safezoneH - 26.25 * GUI_GRID_H,
    10.875 * GUI_GRID_W,
    1 * GUI_GRID_H
];
_prevButton ctrlCommit 0;

_prevButton ctrlSetText LLSTRING(PrevStatement);
_prevButton ctrlAddEventHandler ["MouseButtonUp", {_this call FUNC(prevStatement); true}];

// --- NEXT button
private _nextButton = _display ctrlCreate ["RscButtonMenu", IDC_DEBUGCONSOLE_NEXT, _debugConsole];

_nextButton ctrlSetPosition [
    11.125 * GUI_GRID_W,
    9.25 * GUI_GRID_H + safezoneH - 26.25 * GUI_GRID_H,
    10.875 * GUI_GRID_W,
    1 * GUI_GRID_H
];
_nextButton ctrlCommit 0;

_nextButton ctrlSetText LLSTRING(NextStatement);
_nextButton ctrlAddEventHandler ["MouseButtonUp", {_this call FUNC(nextStatement); true}];

// disable PREV and/or NEXT button if needed
private _statementIndex = profileNamespace getVariable [QGVAR(statementIndex), 0];
private _prevStatements = profileNamespace getVariable [QGVAR(statements), []];

_prevButton ctrlEnable (_statementIndex < count _prevStatements - 1);
_nextButton ctrlEnable (_statementIndex > 0);

// --- EXEC buttons
private _execButtonLocal = _display displayCtrl IDC_RSCDEBUGCONSOLE_BUTTONEXECUTELOCAL;
_execButtonLocal ctrlAddEventHandler ["MouseButtonUp", {
    _this call FUNC(logStatement);
    false
}];

private _execButtonGlobal = _display displayCtrl IDC_RSCDEBUGCONSOLE_BUTTONEXECUTEALL;
_execButtonGlobal ctrlAddEventHandler ["MouseButtonUp", {
    _this call FUNC(logStatement);
    false
}];

private _execButtonServer = _display displayCtrl IDC_RSCDEBUGCONSOLE_BUTTONEXECUTESERVER;
_execButtonServer ctrlAddEventHandler ["MouseButtonUp", {
    _this call FUNC(logStatement);
    false
}];

private _codePerformance = _display displayCtrl IDC_RSCDEBUGCONSOLE_BUTTONCODEPERFORMANCE;
_codePerformance ctrlAddEventHandler ["MouseButtonUp", {
    _this call FUNC(logStatement);
    false
}];

// --- ui functions
FUNC(logStatement) = {
    params ["_control"];
    private _display = ctrlParent _control;
    private _prevButton = _display displayCtrl IDC_DEBUGCONSOLE_PREV;
    private _nextButton = _display displayCtrl IDC_DEBUGCONSOLE_NEXT;
    private _expression = _display displayCtrl IDC_RSCDEBUGCONSOLE_EXPRESSION;

    private _statement = ctrlText _expression;

    private _statementIndex = profileNamespace getVariable [QGVAR(statementIndex), 0];
    private _prevStatements = profileNamespace getVariable [QGVAR(statements), []];

    if !((_prevStatements param [0, ""]) isEqualTo _statement) then {
        _prevStatements deleteAt (_prevStatements find _statement);

        // pushFront
        reverse _prevStatements;
        _prevStatements pushBack _statement;
        reverse _prevStatements;

        if (count _prevStatements > MAX_STATEMENTS) then {
            _prevStatements resize MAX_STATEMENTS;
        };

        profileNamespace setVariable [QGVAR(statementIndex), 0];
        profileNamespace setVariable [QGVAR(statements), _prevStatements];

        // enable PREV, disable NEXT button
        _prevButton ctrlEnable (count _prevStatements > 1);
        _nextButton ctrlEnable false;
    };
};

FUNC(prevStatement) = {
    params ["_prevButton"];
    private _display = ctrlParent _prevButton;
    private _nextButton = _display displayCtrl IDC_DEBUGCONSOLE_NEXT;
    private _expression = _display displayCtrl IDC_RSCDEBUGCONSOLE_EXPRESSION;

    private _statementIndex = profileNamespace getVariable [QGVAR(statementIndex), 0];
    private _prevStatements = profileNamespace getVariable [QGVAR(statements), []];

    _statementIndex = (_statementIndex + 1) min ((count _prevStatements - 1) max 0);
    profileNamespace setVariable [QGVAR(statementIndex), _statementIndex];

    private _prevStatement = _prevStatements select _statementIndex;
    _expression ctrlSetText _prevStatement;

    // enable or disable PREV and NEXT button if needed
    _prevButton ctrlEnable (_statementIndex < count _prevStatements - 1);
    _nextButton ctrlEnable (_statementIndex > 0);
};

FUNC(nextStatement) = {
    params ["_nextButton"];
    private _display = ctrlParent _nextButton;
    private _prevButton = _display displayCtrl IDC_DEBUGCONSOLE_PREV;
    private _expression = _display displayCtrl IDC_RSCDEBUGCONSOLE_EXPRESSION;

    private _statementIndex = profileNamespace getVariable [QGVAR(statementIndex), 0];
    private _prevStatements = profileNamespace getVariable [QGVAR(statements), []];

    _statementIndex = (_statementIndex - 1) max 0;
    profileNamespace setVariable [QGVAR(statementIndex), _statementIndex];

    private _nextStatement = _prevStatements select _statementIndex;
    _expression ctrlSetText _nextStatement;

    // enable or disable PREV and NEXT button if needed
    _prevButton ctrlEnable (_statementIndex < count _prevStatements - 1);
    _nextButton ctrlEnable (_statementIndex > 0);
};

FUNC(removeIndentation) = {
    params ["_control", "_text", "_index"];

    private _chars = toArray _text;
    private _indexRev = count _chars - _index;

    reverse _chars;

    private _stepBack = 0;
    // whitespace type to remove
    private _whitespace = [ASCII_SPACE, ASCII_TAB];
    {
        if !(_x in _whitespace) exitWith {};
        // do not remove mixed whitespace types
        _whitespace = [_x];

        _chars set [_indexRev + _forEachIndex, -1];
        INC(_stepBack);

        // remove only one Tab
        if (_x == ASCII_TAB) exitWith {};
    } forEach (_chars select [_indexRev, count INDENT_SPACES]);

    _chars = _chars - [-1];

    reverse _chars;

    _expression ctrlSetText toString _chars;
    _expression ctrlSetTextSelection [_index - _stepBack, 0];
};

// remove forced pause for watch fields
{
    (_display displayCtrl _x) ctrlAddEventHandler ["SetFocus", {
        _this spawn {
            isNil {
                (_this select 0) setVariable ["RscDebugConsole_watchPaused", false];
            };
        };
    }];
} forEach [IDC_RSCDEBUGCONSOLE_WATCHINPUT1, IDC_RSCDEBUGCONSOLE_WATCHINPUT2, IDC_RSCDEBUGCONSOLE_WATCHINPUT3, IDC_RSCDEBUGCONSOLE_WATCHINPUT4];
