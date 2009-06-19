/* ----------------------------------------------------------------------------
Function: CBA_fnc_capitalize

Description:
	Upper case the first letter of the string, lower case the rest.

Parameters:
	_string - String to capitalize [String]

Returns:
	Capitalized string.

---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(capitalize);

// ----------------------------------------------------------------------------

PARAMS_1(_string);
	
// Make the whole string into a lower case character array.
_string = toArray (toLower _string);

// If there is a first letter, capitalise it.
if ((count _string) > 0) then
{
	_string set [0, (toArray (toUpper (toString [_string select 0]))) select 0];
};

toString _string; // Return.
