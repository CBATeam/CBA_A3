/* ----------------------------------------------------------------------------
Function: CBA_fnc_getUnitAnim

Description:
    Get information about a unit's stance and speed.

Parameters:
    _unit - get stance and movement mode for this unit

Returns:
    An array containing two strings, [ stance, speed ] where

    - stance is one of "prone", "kneel" or "stand"
    - speed is one of "stop", "slow", "normal" or "fast"

Examples:
    (begin example)
    _result = player call CBA_fnc_getUnitAnim;

    _stance = _result select 0;
    _speed = _result select 1;
    (end)

Author:

---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(getUnitAnim);

private _unit = _this;
private _anim = toArray(toLower(animationState _unit));
private _upos = "unknown";
private _umov = "stop";

if (vehicle _unit!= _unit) then {
    _upos = "vehicle";
} else {
    if (count _anim < 12) exitWith {};
    private _dthstr = toString [_anim select 0, _anim select 1, _anim select 2, _anim select 3];
    private _posstr = toString [_anim select 4, _anim select 5, _anim select 6, _anim select 7];
    private _movstr = toString [_anim select 8, _anim select 9, _anim select 10, _anim select 11];
    if (_dthstr == "adth" || {_dthstr == "slx_"}) then {
        _upos = "prone";
    } else {
        _upos = switch (_posstr) do {
            case "ppne": { "prone" };
            case "pknl": { "kneel" };
            case "perc": { "stand" };
            default { "kneel" };
        };
    };
    _umov = switch (_movstr) do {
        case "mstp": { "stop" };
        case "mwlk": { "slow" };
        case "mrun": { "normal" };
        case "meva": { "fast" };
        default { "stop" };
    };
};

[_upos,_umov]
