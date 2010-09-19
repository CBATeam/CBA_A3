/* ----------------------------------------------------------------------------
Function: CBA_fnc_leftTrim

Description:
	Trims white-space (space, tab, newline) from the left end of a string.

	See <CBA_fnc_rightTrim> and <CBA_fnc_trim>.

Parameters:
	_string - String to trim [String]

Returns:
	Trimmed string [String]

Example:
	(begin example)
		_result = [" frogs are fishy   "] call CBA_fnc_leftTrim;
		// _result => "frogs are fishy   "
	(end)

Author:
	Spooner
---------------------------------------------------------------------------- */

#include "script_component.hpp"
#include "script_strings.hpp"

SCRIPT(leftTrim);

// ----------------------------------------------------------------------------

PARAMS_1(_string);

private ["_chars", "_whiteSpace"];

_chars = toArray _string;
_whiteSpace = WHITE_SPACE;

// Left trim.
if ((count _chars) > 0) then
{
	private "_numWhiteSpaces";
	_numWhiteSpaces = count _chars;

	for "_i" from 0 to ((count _chars) - 1) do
	{
		if (not ((_chars select _i) in _whiteSpace)) exitWith { _numWhiteSpaces = _i };
	};

	if (_numWhiteSpaces > 0) then
	{
		private "_newChars";

		_newChars = [];
		_newChars resize ((count _chars) - _numWhiteSpaces);

		for "_i" from 0 to ((count _newChars) - 1) do
		{
			_newChars set [_i, _chars select (_i + _numWhiteSpaces)];
		};

		_chars = _newChars;
	};
};

toString _chars; // Return.
