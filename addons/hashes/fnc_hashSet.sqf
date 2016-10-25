/* ----------------------------------------------------------------------------
Function: CBA_fnc_hashSet

Description:
    Sets a value for a given key in a Hash.

    See <CBA_fnc_hashCreate>.

Parameters:
    _hash - Hash to use [Hash]
    _key - Key to set in Hash [Any]
    _value - Value to set [Any]

Returns:
    The hash [Hash]

Author:
    Spooner
---------------------------------------------------------------------------- */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
#include "script_hashes.hpp"

SCRIPT(hashSet);

// ----------------------------------------------------------------------------
params [["_hash", [], [[]]], "_key", "_value"];

if (isNil "_key") exitWith {_hash};
if (isNil "_hash") exitWith {_hash};

// Work out whether the new value is the default value for this assoc.
private _isDefault = false;

private _default = _hash select HASH_DEFAULT_VALUE;

if (isNil "_default") then {
    _isDefault = isNil "_value";
} else {
    if (!isNil "_value") then {
        _isDefault = _value isEqualTo _default;
    };
};

private _index = (_hash select HASH_KEYS) find _key;

if (_index >= 0) then {
    if (_isDefault) then {
        // Remove the key and value, if the new value is the default value or nil

        private _keys = _hash select HASH_KEYS;
        private _values = _hash select HASH_VALUES;

        _keys deleteAt _index;
        _values deleteAt _index;
    } else {
        // Replace the original value for this key.
        TRACE_2("VM CHECK SET",_index,_value);
        (_hash select HASH_VALUES) set [_index, if (isNil "_value") then {nil} else {_value}];
    };
} else {
    // Ignore values that are the same as the default.
    if !(_isDefault) then {
        _hash select HASH_KEYS pushBack _key;
        _hash select HASH_VALUES pushBack _value;
    };
};
TRACE_1("",_hash);
_hash // Return.
