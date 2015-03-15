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
	jaynus
--------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(replace);

// ----------------------------------------------------------------------------

PARAMS_3(_string,_pattern,_replacement);
private["_i", "_findIndex", "_stringArray", "_replaceArray", "_returnArray"];

_findIndex = _string find _pattern;
while { _findIndex != -1 } do {

	_stringArray = toArray _string;
	_replaceArray = toArray _replacement;

	_returnArray = [];

	_i = 0;
	while { _i < _findIndex } do {
		_returnArray pushBack (_stringArray select _i);
		_i = _i + 1;
	};
	_returnArray append _replaceArray;

	_i = _i + (count _pattern);
	while { _i < (count _string) } do { 
		_returnArray pushBack (_stringArray select _i);
		_i = _i + 1;
	};

	_string = toString _returnArray;
	_findIndex = _string find _pattern;
};

_string