/* ----------------------------------------------------------------------------
Function: CBA_fnc_strLen

Description:
	Counts the number of characters in a string.

Parameters:
	_string - String to measure [String]

Returns:
	Number of characters in string [Number]

Examples:
	(begin example)
		_length = [""] call CBA_fnc_strLen;
		// _result => 0

		_length = ["frogs are fishy"] call CBA_fnc_strLen;
		// _result => 15
	(end)

Author:
	Spooner
---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(strLen);

// ----------------------------------------------------------------------------

count (toArray (_this select 0)); // Return.
