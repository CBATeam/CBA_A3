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
private ["_index", "_isDefault"];
// ----------------------------------------------------------------------------
params ["_hash","_key","_value"];

if (isNil "_value") then { _value = nil};
if (isNil "_key") exitWith {_hash};
if (isNil "_hash") exitWith {_hash;};

if (isNil "BIS_fnc_areEqual") then { LOG( "WARNING: BIS_fnc_areEqual is Nil") };

// Work out whether the new value is the default value for this assoc.
_isDefault = [if (isNil "_value") then { nil } else { _value },
    _hash select HASH_DEFAULT_VALUE] call (uiNamespace getVariable "BIS_fnc_areEqual");

_index = (_hash select HASH_KEYS) find _key;
if (_index >= 0) then
{
    if (_isDefault) then
    {
        // Remove the key, if the new value is the default value.
        // Do this by copying the key and value of the last element
        // in the hash to the position of the element to be removed.
        // Then, shrink the key and value arrays by one. (#2407)
        private ["_keys", "_values", "_last"];

        _keys = _hash select HASH_KEYS;
        _values = _hash select HASH_VALUES;
        _last = (count _keys) - 1;

        _keys set [_index, _keys select _last];
        _keys resize _last;

        _values set [_index, _values select _last];
        _values resize _last;
    } else {
        // Replace the original value for this key.
        TRACE_2("VM CHECK SET",_index,_value);
        (_hash select HASH_VALUES) set [_index, if (isNil "_value") then { nil } else { _value }];
    };
} else {
    // Ignore values that are the same as the default.
    if (not _isDefault) then
    {
        _hash select HASH_KEYS pushBack _key;
        _hash select HASH_VALUES pushBack _value;
    };
};
TRACE_1("",_hash);
_hash; // Return.
