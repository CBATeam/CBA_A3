/* ----------------------------------------------------------------------------
Function: CBA_fnc_trim

Description:
	Trims white-space (space, tab, newline) from the both ends of a string.

Parameters:
	_string - String to trim [String]

Returns:
	Trimmed string [String]

---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(trim);

// ----------------------------------------------------------------------------

PARAMS_1(_string);

// Rtrim first for efficiency.
_string = [_string] call CBA_fnc_rightTrim;

[_string] call CBA_fnc_leftTrim; // Return.
