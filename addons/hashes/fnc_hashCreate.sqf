/* ----------------------------------------------------------------------------
Function: CBA_fnc_hashCreate

Description:
    Check if a Hash has a value defined for a key.

Parameters:
    _array - Array of key-value pairs to create Hash from [Array, defaults to []]
    _defaultValue - Default value. Used when key doesn't exist. A key is also removed from the hash if the value is set to this default [Any, defaults to nil]

Returns:
    Newly created Hash [Hash]

Examples:
(begin code)
    _emptyHash = [] call CBA_fnc_hashCreate;
    [_emptyHash, "frog"] call CBA_fnc_hashGet; // => nil

    _pairs = [["frog", 12], ["fish", 9]];
    _animalCounts = [_pairs, 0] call CBA_fnc_hashCreate;
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
params [["_array", [], [[]]], "_defaultValue"];

private _keys = [];
private _values = [];

_keys resize (count _array);
_values resize (count _array);

{
    _keys set [_forEachIndex, _x select 0];
    _values set [_forEachIndex, _x select 1];
} forEach _array;

/* //1.55 dev
private _keys = _array apply {_x select 0};
private _values = _array apply {_x select 1};
*/

// Return.
[TYPE_HASH, _keys, _values, _defaultValue];
