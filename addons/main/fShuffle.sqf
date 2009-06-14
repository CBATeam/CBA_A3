#include "script_component.hpp"
//****************************************************
//
// Shuffle array function by toadlife (version 1.01)
//
// http://toadlife.net
//
// Function: Shuffles an array's contents into random order
//
// Returns: array
//
// Initialize this fuction in your init.sqs file with this line: shuffle = preProcessFileLineNumbers "shuffle.sqf"
//
// Call this function like so:  myarray call shuffle -- (Example: [1, 2, 3, 4, 5] call shuffle)
//
//***************************************

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