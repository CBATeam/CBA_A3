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

#ifndef LINUX_BUILD
    private _keys = _array apply {_x select 0};
    private _values = _array apply {_x select 1};
#else
    private _keys = [_array, {_x select 0}] call CBA_fnc_filter;
    private _values = [_array, {_x select 1}] call CBA_fnc_filter;
#endif

// Return.
[TYPE_HASH, _keys, _values, if (isNil "_defaultValue") then {nil} else {_defaultValue}];
