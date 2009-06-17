/* ----------------------------------------------------------------------------
@description Trims white-space (space, tab, newline) from the right end of a string.

Parameters:
  0: _string - String to trim [String]

Returns:
  Trimmed string [String]

---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(rightTrim);

// ----------------------------------------------------------------------------

SPON_GET_PARAMS_1(_string);

private ["_chars", "_whiteSpace", "_pos"];

_chars = toArray _string;
_whiteSpace = WHITE_SPACE;

// Right trim.
for [{ _pos = (count _chars) - 1 }, { _pos > 0 }, { _pos = _pos - 1 }] do
{
	if (_pos < 0) exitWith {};
	
	if (not ((_chars select _pos) in _whiteSpace)) exitWith {};
};

_chars resize (_pos + 1);

toString _chars; // Return.