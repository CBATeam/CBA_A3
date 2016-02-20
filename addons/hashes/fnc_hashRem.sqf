/* ----------------------------------------------------------------------------
Function: CBA_fnc_hashRem

Description:
    Removes given key from given Hash.

    See <CBA_fnc_hashCreate>.

Parameters:
    _hash - Hash to use [Hash]
    _key - Key to remove from Hash [Any]

Returns:
    The hash [Hash]

Author:
    Sickboy
---------------------------------------------------------------------------- */

#include "script_component.hpp"
#include "script_hashes.hpp"

SCRIPT(hashRem);

// ----------------------------------------------------------------------------
params ["_hash","_key"];

private _defaultValue = _hash select HASH_DEFAULT_VALUE;
[_hash, _key, _defaultValue] call CBA_fnc_hashSet;

_hash; // Return.
