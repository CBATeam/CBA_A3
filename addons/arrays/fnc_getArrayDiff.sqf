/* ----------------------------------------------------------------------------
Function: CBA_fnc_getArrayDiff

Description:
	A function used to return the differences between two arrays.

Parameters:
	Two Arrays of strings (must not contain scalars)

Example:
    (begin example)
	_distance = [[0,0,1], [0,0,0]] call CBA_fnc_getArrayDiff
    (end

Returns:
	Array Differences (for above example, return is [[1],[0]])

Author:
	Rommel

---------------------------------------------------------------------------- */

#include "script_component.hpp"

#define NULL "$null$"

PARAMS_2(_arrayA,_arrayB);

private ["_elmsA", "_elmsB", "_return", "_item", "_idx", "_cA", "_cB", "_case", "_cT"];

// Simplify the arrays to save on processing power
_elmsA = _arrayA call CBA_fnc_getArrayElements;
_elmsB = _arrayB call CBA_fnc_getArrayElements;
_return = [[], []];

for "_i" from 1 to (count _elmsA) step 2 do {
	// Pick the first item
	_item = _elmsA select 0;
	_idx = _elmsB find _item; // O(n^2), TODO: Find a way to differentiate counts
	_cA = _elmsA select 1;
	if (_idx > -1) then {
		// Differential code
		_cB = _elmsB select (_idx + 1);

		_case = -1;
		_cT = _cA - _cB;
		if (_cT < 0) then {
			_case = 1; //Missing from B
			_cT = abs(_cT);
		} else {
			if (_cT > 0) then {
				_case = 0; //Missing from A
			};
		};
		// We have the difference, now put it in the right array
		for "_j" from 1 to _cT do {
			(_return select _case) pushBack _item; // Fills array
		};
		// Remove the item from B, it was in both arrays
		_elmsB set [_idx, NULL];
		_elmsB set [_idx + 1, NULL];
		_elmsB = _elmsB - [NULL];
	} else {
		// Missing from B
		for "_j" from 0 to _cA do {
			(_return select 0) pushBack _item; // Fills array
		};
	};
	// Remove the item from A
	_elmsA set [0, NULL];
	_elmsA set [1, NULL];
	_elmsA = _elmsA - [NULL];
};
// Now add all those missing from A
for "_i" from 0 to (count _elmsB - 1) step 2 do {
	_item = _elmsB select _i;
	_cB = _elmsB select (_i + 1);
	for "_j" from 0 to (_cB - 1) do {
		(_return select 1) set [count (_return select 1), _item]; // Fills array
	};
};
// Now we're done, return the work done
_return
