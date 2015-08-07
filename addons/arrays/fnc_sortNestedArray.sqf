/* ----------------------------------------------------------------------------
Function: CBA_fnc_sortNestedArray

Description:
    Used to sort a nested array from lowest to highest using quick sort based on the specified column, which must have numerical data.

Parameters:
    _array: array - Nested array to be sorted
    _index: integer - sub array item index to be sorted on

Example:
    (begin example)
    _array = [_array,1] call CBA_fnc_sortNestedArray
    (end)

Returns:
    Passed in array

Author:
    Standard algorithm

---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(sortNestedArray);

/*
    Modified BIS function to sort nested arrays.
    Added 2nd parameter to indicate which column (index in nested array) to sort on.
    Sorts an array of numbers from lowest (left) to highest (right).
    The passed array is modified by reference.
    This function uses the quick sort algorithm.
*/

//set up a function for recursion
private "_sort";
_sort = {
    private ["_h","_i","_j","_x"];
    params ["_a","_id","_lo","_hi"];
     // _a, array to be sorted
     // _id, array item index to be compared
     // _lo, lower index to sort from
     // _hi, upper index to sort to

    _h = nil; //used to make a do-while loop below
    _i = _lo;
    _j = _hi;
    if (count _a == 0) exitWith {};
    _x = (_a select ((_lo + _hi) / 2)) select _id;

    //  partition
    while {isnil "_h" || {_i <= _j}} do {
        //find first and last elements within bound that are greater / lower than _x
        while {(_a select _i) select _id < _x} do {INC(_i)};
        while {(_a select _j) select _id > _x} do {DEC(_j)};

        if (_i <= _j) then {
            //swap elements _i and _j
            _h = _a select _i;
            _a set [_i, _a select _j];
            _a set [_j, _h];

            INC(_i);
            DEC(_j);
        };
    };

    // recursion
    if (_lo < _j) then {[_a, _id, _lo, _j] call _sort};
    if (_i < _hi) then {[_a, _id, _i, _hi] call _sort};
};

// and start it off
[_this select 0, _this select 1, 0, 0 max ((count (_this select 0))-1)] call _sort;

// array is already modified by reference, but return the modified array anyway
_this select 0
