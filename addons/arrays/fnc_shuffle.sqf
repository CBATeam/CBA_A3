/* ----------------------------------------------------------------------------
Function: CBA_fnc_shuffle

Description:
	Shuffles an array's contents into random order, returning a new array.

Parameters:
	_array - Array of values to shuffle [Array, containing anything except nil]

Returns:
	New array containing shuffled values from original array [Array]

Example:
	(begin example)
		_result = [[1, 2, 3, 4, 5]] call CBA_fnc_shuffle;
		// _result could be [4, 2, 5, 1, 3]
	(end)

TODO:
	Allow shuffling of elements in-place, using the original array.

Author:
	toadlife (version 1.01) http://toadlife.net
	(rewritten by Spooner)
---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(shuffle);

private ["_shuffledArray", "_tempArray", "_indexToRemove"];
_shuffledArray = [];

// Support the deprecated parameter style: [1, 2, 3, 4, 5] call CBA_fnc_shuffle.
_tempArray = if ((count _this) != 1) then
{
	WARNING("CBA_fnc_shuffle requires an array as first parameter, not just a direct array: " + str _this);
	[] + _this;
}
else{if (IS_ARRAY(_this select 0)) then
{
	[] + (_this select 0); // Correct params passed.
}
else
{
	WARNING("CBA_fnc_shuffle requires an array as first parameter, not just a direct array: " + str _this);
	[] + _this;
}; };

for "_size" from (count _tempArray) to 1 step -1 do
{
	_indexToRemove = floor random _size;
	PUSH(_shuffledArray,_tempArray select _indexToRemove);
	_tempArray = [_tempArray, _indexToRemove] call BIS_fnc_removeIndex;
};

_shuffledArray
