/* ----------------------------------------------------------------------------
Function: CBA_fnc_objectRandom

Description:
	Creates a "random" number 0-9 based on an object's velocity
	
Parameters:

Returns:

Examples:
	(begin example)

	(end)

Author:

---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(objectRandom);

private["_o", "_r", "_v", "_s", "_a", "_b", "_c"];
PARAMS_1(_o);
_r = 0;
if!(isNull _o) then
{
	_v = velocity(vehicle _o);
	_s = sqrt((_v select 0)^2+(_v select 1)^2+(_v select 2)^2);
	if (_s>0) then
	{
		_a = acos((_v select 0)/_s); _b = acos((_v select 1)/_s); _c = acos((_v select 2)/_s);
		_r = (_a+_b+_c)%10;
		_r = _r-(_r%1);
	} else {
		_r = (getDir _o)%10;
		_r = _r-(_r%1);
	};
};
_r
