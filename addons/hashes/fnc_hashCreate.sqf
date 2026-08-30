#include "script_component.hpp"
#include "script_hashes.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_hashCreate

Description:
    Creates a new Hash

Parameters:
    _array - Array of key-value pairs to create Hash from [Array, defaults to []]
    _defaultValue - Default value. Used when key doesn't exist. A key is also removed from the hash if the value is set to this default [Any, defaults to nil]
    _clearOnDefault - Setting default value behaves like a remove

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
    [_animalCounts, "monkey", 25] call CBA_fnc_hashGet; // => 25
(end code)

Author:
    Spooner
---------------------------------------------------------------------------- */

SCRIPT(hashCreate);

// -----------------------------------------------------------------------------
params [["_array", [], [[]]], "_defaultValue", ["_clearOnDefault", true]];

private _keys = _array apply {_x select 0};
private _values = _array apply {_x select 1};

// Return.
[TYPE_HASH, _keys, _values, if (isNil "_defaultValue") then {nil} else {_defaultValue}, _clearOnDefault];
