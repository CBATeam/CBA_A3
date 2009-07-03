/* ----------------------------------------------------------------------------
Function: CBA_fnc_hashEachPair

Description:
	Iterate through all keys and values in a Hash.
	
	Data passed to the function on each iteration,
	* _key - Key from the Hash.
	* _value - The value from the Hash corresponding to _key.
	
	See <CBA_fnc_hashCreate>.

Parameters:
	_hash - Hash to iterate [Array which is a Hash structure]
	_code - Function to call with each pair [Any]
	
Returns:
	nil
	
Example:
	(begin example)
	  _dumpHash = {
		diag_log format ["Key: %1, Value: %2", _key, _value];
	  };

	  [_hash, _dumpHash] call CBA_fnc_hashEachPair;
	(end)
	
Author:
	Spooner
---------------------------------------------------------------------------- */

#include "script_component.hpp"
#include "hashes.inc.sqf"

SCRIPT(hashEachPair);

// -----------------------------------------------------------------------------

PARAMS_2(_hash,_code);

private ["_keys", "_values"];

_keys = _hash select HASH_KEYS;
_values = _hash select HASH_VALUES;

for "_i" from 0 to ((count _keys) - 1) do
{
	private ["_key", "_value"];
	
	_key = _keys select _i;
	_value = _values select _i;
	
	call _code;
};

nil; // Return.