#include "script_component.hpp"
/*RANDOM INTEGER FUNCTION
  By General Barron

	   Returns a random integer between two endpoints given in an array. Example:
	 [4, 1] call randomInt    OR    [1, 4] call randomInt
	 returns 1, 2, 3 or 4
*/

private ["_upperL", "_lowerL", "_result"];

_lowerL = _this select 0;
_upperL = _this select 1;

if (_lowerL > _upperL) then { _lowerL = _this select 1; _upperL = _this select 0 };

_result = ((random 1) * (1 + _upperL - _lowerL)) + _lowerL;
_result = _result - (_result mod 1);
_result