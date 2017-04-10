/* ----------------------------------------------------------------------------
Function: CBA_fnc_shuffle

Description:
    Shuffles an array's contents into random order.

Parameters:
    _array - Array of values to shuffle <Array, containing anything except nil>
    _inPlace - true: alter array, false: copy array (optional, default: false) <BOOLEAN>

Returns:
    Array containing shuffled values <Array>

Example:
    (begin example)
        _result = [[1, 2, 3, 4, 5]] call CBA_fnc_shuffle;
        // _result could be [4, 2, 5, 1, 3]

        _array = [1, 2, 3, 4, 5];
        [_array,true] call CBA_fnc_shuffle;
        // _array could now be [4, 2, 5, 1, 3]
    (end)

Author:
    toadlife (version 1.01) http://toadlife.net
    rewritten by Spooner, Dorbedo
---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(shuffle);

params [["_array",[],[[]]],["_inPlace",false,[false]]];

private _tempArray =+ _array;

If (_inPlace) then {
    for "_size" from (count _tempArray) to 1 step -1 do {
        _array set [_size-1,(_tempArray deleteAt (floor random _size))];
    };
    _array
}else{
    private _shuffledArray = [];
    for "_size" from (count _tempArray) to 1 step -1 do {
        _shuffledArray pushBack (_tempArray deleteAt (floor random _size));
    };
    _shuffledArray
};
