/* ----------------------------------------------------------------------------
Function: CBA_fnc_join

Description:
	Joins an array of values into a single string, joining each fragment around
	a separator string. Inverse of <CBA_fnc_split>.

Parameters:
	_array - Array to join together as a string [Array]
	_separator - String to put between each element of _array
		[String, defaults to ""]

Returns:
	The joined string [String]

Example:
	(begin example)
		_result = [["FISH", "Cheese", "frog.sqf"], "\"] call CBA_fnc_join;
		// _result ==> "FISH\Cheese\frog.sqf"

		_result = [[3, 2, 1, "blast-off!"], "..."] call CBA_fnc_join;
		// _result ==> "3...2...1...blast-off!"
	(end)

Author:
	Spooner
---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(join);

// ----------------------------------------------------------------------------

PARAMS_1(_array);
DEFAULT_PARAM(1,_separator,"");

private ["_joined", "_element"];

if ((count _array) > 0) then
{
	_element = _array select 0;
	_joined = if (IS_STRING(_element)) then { _element } else { str _element };

	for "_i" from 1 to ((count _array) - 1) do
	{
		_element = _array select _i;
		_element = if (IS_STRING(_element)) then { _element } else { str _element };
		_joined = _joined + _separator + _element;
	};
} else {
	_joined = "";
};

_joined; // Return.
