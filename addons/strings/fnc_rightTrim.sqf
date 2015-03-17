/* ----------------------------------------------------------------------------
Function: CBA_fnc_rightTrim

Description:
	Trims white-space (space, tab, newline) from the right end of a string.

	See <CBA_fnc_leftTrim> and <CBA_fnc_trim>.

Parameters:
	_string - String to trim [String]

Returns:
	Trimmed string [String]

Example:
	(begin example)
		_result = [" frogs are fishy   "] call CBA_fnc_rightTrim;
		// _result => " frogs are fishy"
	(end)

Author:
	Spooner
---------------------------------------------------------------------------- */

#include "script_component.hpp"
#include "script_strings.hpp"

SCRIPT(rightTrim);

// ----------------------------------------------------------------------------

PARAMS_1(_string);

private ["_chars", "_whiteSpace", "_pos","_numWhiteSpaces"];

_chars = toArray _string;
_whiteSpace = WHITE_SPACE;

// Right trim.

_numWhiteSpaces = count _chars;

for "_pos" from ((count _chars) - 1) to 0 step -1 do {
	if !((_chars select _pos) in _whiteSpace) exitWith { _numWhiteSpaces = (count _chars) - _pos - 1 };
};

_chars resize ((count _chars) - _numWhiteSpaces);

toString _chars; // Return.
