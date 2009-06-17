/* ----------------------------------------------------------------------------
@description Splits a string into substrings using a separator. Inverse of CBA_fnc_join.

Examples:
  _result = ["FISH\Cheese\frog.sqf", "\"] call CBA_fnc_split;
  _result is ["Fish", "Cheese", "frog.sqf"]

  _result = ["Peas", ""] call CBA_fnc_split;
  _result is ["P", "e", "a", "s"]

Parameters:
  0: _string - String to split up [String]
  1: _separator - String to split around. If an empty string, "", then split
    every character into a separate string [String, defaults to ""]

Returns:
  The split string [Array of Strings]

---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(split);

// ----------------------------------------------------------------------------

PARAMS_1(_string);
DEFAULT_PARAM(1,_separator,"");

private ["_stringArray", "_split"];
_stringArray = toArray _string;
_split = [];

if (_separator == "") then
{
	// Special case, split into single character strings.
	{
		PUSH(_split,toString [_x]);
	} forEach _stringArray;
}
else
{
	private [ "_separatorArray", "_fragment",
	"_currentIndex", "_foundIndex"];

	_separatorArray = toArray _separator;
	
	_currentIndex = 0;
	
	while { _currentIndex < (count _stringArray) } do
	{
		_foundIndex = [_stringArray, _separatorArray, _currentIndex] call CBA_fnc_stringFind;
		
		// Not found, so use rest of string as final fragment.
		if (_foundIndex < 0) exitWith
		{
			_fragment = [];
			
			for "_i" from _currentIndex to ((count _stringArray) - 1) do
			{
				PUSH(_fragment,_stringArray select _i);
			};
			
			PUSH(_split,toString _fragment);
		};

		// Found, so use all string before found position as next fragment.
		_fragment = [];
		
		for "_i" from _currentIndex to (_foundIndex - 1) do
		{
			PUSH(_fragment,_stringArray select _i);
		};
		
		PUSH(_split,toString _fragment);
		
		_currentIndex = _foundIndex + (count _separatorArray);
		
		// If the separator is present at the end of the string, then
		// add an empty string.
		if (_currentIndex == (count _stringArray)) then
		{
			PUSH(_split,"");
		};
	};
};

_split ; // Return.