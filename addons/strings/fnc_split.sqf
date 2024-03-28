#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_split

Description:
    Splits a string into substrings using a separator. Inverse of <CBA_fnc_join>.

Parameters:
    _string    - String to split up <STRING>
    _separator - String to split around. If an empty string, "", then split
        every character into a separate string (optional, default: "") <STRING>

Returns:
    The split string <ARRAY of STRINGS>

Examples:
    (begin example)
        _result = ["FISH\Cheese\frog.sqf", "\"] call CBA_fnc_split;
        _result is ["Fish", "Cheese", "frog.sqf"]

        _result = ["Peas", ""] call CBA_fnc_split;
        _result is ["P", "e", "a", "s"]
    (end)

Author:
    PabstMirror
---------------------------------------------------------------------------- */
SCRIPT(split);

params [["_input", ""], ["_separator", ""]];

private _split = [];
private _index = 0;
private _inputCount = count _input;
private _separatorCount = count _separator;

// Corner cases
if (_separatorCount == 0 && {_inputCount == 0}) exitWith {[]};
if (_separatorCount == 0) exitWith {_input splitString ""};
if (_inputCount > 0 && {_separatorCount > _inputCount}) exitWith {[_input]};
if (_input == _separator) exitWith {["", ""]};

private _lastWasSeperator = true;

while {_index < _inputCount} do {
    private _find = (_input select [_index]) find _separator;

    if (_find == 0) then {
        _index = _index + _separatorCount;

        if (_lastWasSeperator) then {
            _split pushBack "";
        };

        _lastWasSeperator = true;
    } else {
        _lastWasSeperator = false;

        if (_find == -1) then {
            _split pushBack (_input select [_index]);
            _index = _inputCount;
        } else {
            _split pushBack (_input select [_index, _find]);
            _index = _index + _find;
        };
    };
};

// Handle split at end
if ((_inputCount >= _separatorCount) && _lastWasSeperator && {(_input select [(_inputCount - _separatorCount)]) isEqualTo _separator}) then {
    _split pushBack "";
};

_split // return
