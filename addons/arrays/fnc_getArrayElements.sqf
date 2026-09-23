/* ----------------------------------------------------------------------------
Function: CBA_fnc_getArrayElements

Description:
    A function used to return the element counts in an array.

Parameters:
    _input: <ARRAY>

Returns:
    Array element counts <ARRAY>
    flat pairs of [elementX, countX, elementY, countY, ...]

Example:
    (begin example)
    _types = [0, 0, 1, 1, 1, 1] call CBA_fnc_getArrayElements // return would be [0, 2, 1, 4])
    (end)

Author:
    Rommel && sbsmac

---------------------------------------------------------------------------- */

private _array = +_this;
private _return = [];
private _countA = count _array;

while {_countA > 0} do {
     private _var = _array select 0;
     _array = _array - [_var];
     private _countB = count _array;
     _return append [_var, _countA - _countB];
     _countA = _countB;
};

_return
