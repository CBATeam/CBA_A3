/* ----------------------------------------------------------------------------
Function: CBA_fnc_hashEachPair

Description:
	Iterate through all keys and values in a Hash.

Example:
(begin code)
  _dumpHash = {
    private ["_key", "_value"];
    _key = _this select 0;
    _value = _this select 1;

    diag_log format ["Key: %1, Value: %2", _key, _value];
  };

  [_hash, _dumpHash] call CBA_fnc_hashEachPair;
(end code)

Parameters:
	_hash - Hash to iterate [Array which is a Hash structure]
	_code - Function to call with each pair [Any]

Returns:
	nil
---------------------------------------------------------------------------- */

#include "script_component.hpp"
#include "hash.inc.sqf"

SCRIPT(hashEachPair);

// -----------------------------------------------------------------------------

PARAMS_2(_hash,_code);

private ["_x", "_keys", "_values"];

_keys = _hash select HASH_KEYS;
_values = _hash select HASH_VALUES;

for "_i" from 0 to ((count _keys) - 1) do
{
	[_keys select _i, _values select _i] call _code;
};

nil; // Return.