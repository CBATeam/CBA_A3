/* ----------------------------------------------------------------------------
Function: CBA_fnc_isHash

Description:
	Check if a value is a Hash data structure.

	See <CBA_fnc_hashCreate>.

Parameters:
	_value - Data structure to check [Any]

Returns:
	True if it is a Hash, otherwise false [Boolean]

Author:
	Spooner
---------------------------------------------------------------------------- */

#include "script_component.hpp"
#include "script_hashes.hpp"

SCRIPT(isHash);

// -----------------------------------------------------------------------------

PARAMS_1(_value);

private "_result";

_result = false;

if ((typeName _value) == "ARRAY" && {(count _value) == 4} && {(typeName (_value select HASH_ID)) == (typeName TYPE_HASH)}) then {
	_result = ((_value select HASH_ID) == TYPE_HASH);
};

_result;
