#define THIS_FILE CBA\main\hashCreate
scriptName 'THIS_FILE';
// -----------------------------------------------------------------------------
// @description Check if a Hash has a value defined for a key.
//
// Examples:
//   _emptyHash = [] call hashCreate;
//   [_emptyHash, "frog"] call CBA_fnc_hashGet; // => nil
//
//   _pairs = [["frog", 12], ["fish", 9]];
//   _animalCounts = [_pairs, 0] call hashCreate;
//   [_animalCounts, "frog"] call CBA_fnc_hashGet; // => 12
//   [_animalCounts, "monkey"] call CBA_fnc_hashGet; // => 0
//  
// Params:
//   0: _array - Array of key-value pairs to create Hash from [Array, defaults to []]
//   1: _defaultValue - Hash to look for key in [Any, defaults to nil]
//
// Returns:
//   Newly created Hash [Hash]
// -----------------------------------------------------------------------------

#include "script_component.hpp"
#include "hash.inc.sqf"

// -----------------------------------------------------------------------------

DEFAULT_PARAM(0,_array,[]);
DEFAULT_PARAM(1,_defaultValue,nil);

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