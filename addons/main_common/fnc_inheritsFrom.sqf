/* ----------------------------------------------------------------------------
Function: CBA_fnc_inheritsFrom

Description:
	Checks whether a config entry inherits, directly or indirectly, from another one.

	Unlike the standard *inheritsFrom* command, this checks the entire ancestry.

Parameters:

Returns:

Examples:
	(begin example)

	(end)

Author:

---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(inheritsFrom);

private ["_class", "_baseClass", "_entry", "_valid"];
_class = _this select 0;
_baseClass = _this select 1;
_valid = false;

_entry = inheritsFrom _entry;
while { _entry != "" } do
{
	if (_entry == _baseClass) exitWith { _valid = true };
	_entry = inheritsFrom _entry;
};

_valid