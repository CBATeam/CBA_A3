/* ----------------------------------------------------------------------------
Function: CBA_fnc_getArrayElements

Description:
    A function used to return the element counts in an array.

Parameters:
    Array

Example:
    (begin example)
    _types = [0, 0, 1, 1, 1, 1] call CBA_fnc_getArrayElements
    (end)

Returns:
    Array element counts (for above example, return would be [0, 2, 1, 4])

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
     _return = _return + [_var, _countA - _countB];
     _countA = _countB;
};

_return
