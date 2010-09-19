/* ----------------------------------------------------------------------------
Function: CBA_fnc_hashCreate

Description:
	Check if a Hash has a value defined for a key.

Parameters:
	_array - Array of key-value pairs to create Hash from [Array, defaults to []]
	_defaultValue - Hash to look for key in [Any, defaults to nil]

Returns:
	Newly created Hash [Hash]

Examples:
(begin code)
	_emptyHash = [] call hashCreate;
	[_emptyHash, "frog"] call CBA_fnc_hashGet; // => nil

	_pairs = [["frog", 12], ["fish", 9]];
	_animalCounts = [_pairs, 0] call hashCreate;
	[_animalCounts, "frog"] call CBA_fnc_hashGet; // => 12
	[_animalCounts, "monkey"] call CBA_fnc_hashGet; // => 0
(end code)

Author:
	Spooner
---------------------------------------------------------------------------- */

#include "script_component.hpp"
#include "script_hashes.hpp"

SCRIPT(hashCreate);

// -----------------------------------------------------------------------------

DEFAULT_PARAM(0,_array,[]);
DEFAULT_PARAM(1,_defaultValue,nil);
private ["_keys", "_values"];

_keys = [];
_values = [];

_keys resize (count _array);
_values resize (count _array);

for "_i" from 0 to ((count _array) - 1) do
{
	_keys set [_i, (_array select _i) select 0];
	_values set [_i, (_array select _i) select 1];
};

// Return.
[TYPE_HASH, _keys, _values,
	if (isNil "_defaultValue") then { nil } else { _defaultValue }];
