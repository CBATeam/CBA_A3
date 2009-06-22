#include "script_component.hpp"
comment 'return the sum of two 3D vectors

_sum = [_vector1, _vector2] call CBA_fVectorSum3D;
';

private ["_a", "_b"];

_a = _this select 0;
_b = _this select 1;

[
	(_a select 0)+(_b select 0),
	(_a select 1)+(_b select 1),
	(_a select 2)+(_b select 2)
]