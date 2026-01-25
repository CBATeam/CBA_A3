#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_objectRandom

Description:
    Creates a "random" number 0-9 based on an object's velocity

Parameters:
    _o - an object to base the random number on. <OBJECT>

Returns:
    A number between 0 and 9.

Examples:
    (begin example)
        _random = _helicopter call CBA_fnc_objectRandom;
    (end)

Author:

---------------------------------------------------------------------------- */
SCRIPT(objectRandom);

params ["_o"];

private _r = 0;

if !(isNull _o) then {
    private _v = velocity (vehicle _o);
    private _s = vectorMagnitude _v;
    if (_s > 0) then {
        private _a = acos ((_v select 0) / _s);
        private _b = acos ((_v select 1) / _s);
        private _c = acos ((_v select 2) / _s);

        _r = (_a + _b + _c) % 10;
        _r = floor _r;
    } else {
        _r = (getDir _o) % 10;
        _r = floor _r;
    };
};

_r
