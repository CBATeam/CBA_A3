/* ----------------------------------------------------------------------------
@description Trims white-space (space, tab, newline) from the right end of a string.

Parameters:
  0: _string - String to trim [String]

Returns:
  Trimmed string [String]

---------------------------------------------------------------------------- */

#include "script_component.hpp"
#include "strings.inc.sqf"

SCRIPT(rightTrim);

// ----------------------------------------------------------------------------

PARAMS_1(_string);

private ["_chars", "_whiteSpace", "_pos"];

_chars = toArray _string;
_whiteSpace = WHITE_SPACE;

// Right trim.

_numWhiteSpaces = count _chars;

for "_pos" from ((count _chars) - 1) to 0 step -1 do
{
	if (not ((_chars select _pos) in _whiteSpace)) exitWith { _numWhiteSpaces = (count _chars) - _pos - 1 };
};

_chars resize ((count _chars) - _numWhiteSpaces);

toString _chars; // Return.