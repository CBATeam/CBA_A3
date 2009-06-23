/* ----------------------------------------------------------------------------
Function: CBA_fnc_shuffle

Description:
	Shuffles an array's contents into random order, returning a new array.
	
Parameters:
	Array of values.
	
Returns:
	New array containing shuffled values from original array [Array]

Examples:
	(begin example)
		[1, 2, 3, 4, 5] call CBA_fnc_shuffle;
	(end)
	
Bugs:
	* This will sort any array, unless it contains an element which is "".
	* Expects the array to be sent *as* the parameter list, not as a parameter.

Author:
	toadlife (version 1.01) http://toadlife.net
---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(shuffle);

private ["_newarray", "_temparray", "_acount", "_rand", "_moveitem"];
_newarray = [];
_temparray = [] + _this;
while { count _temparray > 0 } do
{
	_acount = (count _temparray);
	_rand = random _acount;
	_rand = _rand - (_rand mod 1);
	_moveitem = _temparray select _rand;
	_newarray = _newarray + [_moveitem];
	_temparray set [_rand, ""];
	_temparray = _temparray - [""];
};
_newarray