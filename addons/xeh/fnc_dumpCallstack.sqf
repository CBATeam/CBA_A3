/* ----------------------------------------------------------------------------
Function: CBA_fnc_dumpCallstack

Description:
    Dumps the current callstack to the RPT.

Parameters:
    None

Returns:
    None

Examples:
    (begin example)
        [] call CBA_fnc_dumpCallstack;
    (end)

Author:
    BaerMitUmlaut
---------------------------------------------------------------------------- */
#include "script_component.hpp"
if (isNil "CBA_callstack") exitWith {};

private _tab = "    ";
private _nl = toString [13, 10];
private _indentation = "";
private _indentationMemory = [];
_indentationMemory resize count CBA_callstack;
private _lastHandle = -1;

private _output = "Dumping callstack:" + _nl;
{
    _x params ["_currentHandle", "_parent", "_parentHandle"];
    private _current = CBA_functionHandles select _currentHandle;

    if (_parentHandle != _lastHandle) then {
        _indentation = _indentationMemory select _parentHandle;
    };

    if (_parent == (CBA_functionHandles param [_parentHandle, ""])) then {
        _output = _output + _indentation + format ["-> %1", _current] + _nl;
    } else {
        if (_current == _parent) then {
            _parent = "unknown function";
        };
        _output = _output + _indentation + format ["-> %1 (via %2)", _current, _parent] + _nl;
    };

    _indentation = _indentation + _tab;
    _indentationMemory set [_currentHandle, _indentation];
} forEach CBA_callstack;

diag_log text _output;
