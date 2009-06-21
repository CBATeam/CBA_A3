/* ----------------------------------------------------------------------------
Function: CBA_fnc_isHash

Description:
	Check if a value is a Hash data structure.
 
Parameters:
	_value - Data structure to check [Any]

Returns:
	True if it is a Hash, otherwise false [Boolean]
---------------------------------------------------------------------------- */

#include "script_component.hpp"
#include "hashes.inc.sqf"

SCRIPT(isHash);

// -----------------------------------------------------------------------------

PARAMS_1(_value);

_result = false;

if ((typeName _value) == "ARRAY") then
{
	if ((count _value) == 4) then
	{
		if ((typeName (_value select HASH_ID)) == (typeName TYPE_HASH)) then
		{
			_result = ((_value select HASH_ID) == TYPE_HASH);
		};
	};
};

_result;