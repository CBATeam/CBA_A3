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
PARAMS_2(_hash,_key);

private ["_defaultValue"];

_defaultValue = _hash select HASH_DEFAULT_VALUE;
[_hash, _key, if (isNil "_defaultValue") then { nil } else { _defaultValue }] call CBA_fnc_hashSet;

_hash; // Return.
