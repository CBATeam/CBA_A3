/* ----------------------------------------------------------------------------
Function: CBA_fnc_replace

Description:
	Replaces substrings within a string. Case-dependent.

Parameters:
	_string - String to make replacement in [String]
	_pattern - Substring to replace [String]
	_replacement - String to replace the _pattern with [String]

Returns:
	String with replacements made [String]

Example:
	(begin example)
		_str = ["Fish frog cheese fromage", "fro", "pi"] call CBA_fnc_replace;
		// => "Fish pig cheese pimage"
	(end)

Author:
	Spooner
--------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(replace);

// ----------------------------------------------------------------------------

PARAMS_3(_string,_pattern,_replacement);

// Return.
[[_string, _pattern] call CBA_fnc_split, _replacement] call CBA_fnc_join;
