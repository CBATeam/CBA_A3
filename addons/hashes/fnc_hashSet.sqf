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

#include "script_component.hpp"
#include "script_hashes.hpp"

SCRIPT(hashSet);

// ----------------------------------------------------------------------------
PARAMS_3(_hash,_key,_value);

private ["_index", "_isDefault"];

// Work out whether the new value is the default value for this assoc.
_isDefault = [if (isNil "_value") then { nil } else { _value },
	_hash select HASH_DEFAULT_VALUE] call BIS_fnc_areEqual;

_index = (_hash select HASH_KEYS) find _key;
if (_index >= 0) then
{
	if (_isDefault) then
	{
		// Remove the key, if the new value is the default value.
		_hash set [HASH_KEYS, (_hash select HASH_KEYS) - [_key]];

		// Copy all the values, after the one we want to remove, down by
		// one place, then cut off the last value.
		private "_values";
		_values = _hash select HASH_VALUES;

		for "_i" from _index to ((count _values) - 2) do
		{
			_values set [_i, _values select (_i + 1)];
		};

		_values resize ((count _values) - 1);
	}
	else
	{
		// Replace the original value for this key.
		(_hash select HASH_VALUES) set [_index, _value];
	};
}
else
{
	// Ignore values that are the same as the default.
	if (not _isDefault) then
	{
		PUSH(_hash select HASH_KEYS,_key);
		PUSH(_hash select HASH_VALUES,_value);
	};
};

_hash; // Return.
