#define THIS_FILE CBA\main\join
scriptName 'THIS_FILE';
// ----------------------------------------------------------------------------
// @description Joins an array of strings into a single string, joining each fragment around a separator string. Inverse of CBA_fnc_split.
//
// Example:
//   _result = [["Fish", "Cheese", "frog.sqf"], "\"] call CBA_fnc_join;
//   _result is "FISH\Cheese\frog.sqf"
//
// Parameters:
//   0: _strings - Array of strings to join together [String]
//   1: _separator - String to put between each element of _strings
//     [String, defaults to ""]
//
// Returns:
//   The joined string [String]
//
// ----------------------------------------------------------------------------

#include "script_component.hpp"

// ----------------------------------------------------------------------------

PARAMS_1(_strings);
DEFAULT_PARAM(1,_separator,"");

private ["_joined"];

if ((count _strings) > 0) then
{
	_joined = _strings select 0;

	for "_i" from 1 to ((count _strings) - 1) do
	{
		_joined = _joined + _separator + str (_strings select _i);
	};
}
else
{
	_joined = "";
};

_joined; // Return.
