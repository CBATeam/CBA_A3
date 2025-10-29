#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_fixAnimation3DEN
Description:
    Fixes a unit's animation when placing it in Eden.

Parameters:
    _unit  - Unit <OBJECT>

Returns:
    None

Examples
    (begin example)
        _unit call CBA_fnc_fixAnimation3DEN
    (end)

Author:
    DartRuffian
---------------------------------------------------------------------------- */

params ["_unit"];
TRACE_1("fnc_fixAnimation",_unit);

if (!is3DEN) exitWith {};

// Sometimes units have the wrong animation when placed, not sure why
_unit spawn {
    sleep 0.1;
    private _animation = switch (false) do {
        case (primaryWeapon _this == ""): { "amovpercmstpsraswrfldnon" };
        case (handgunWeapon _this == ""): { "amovpercmstpsraswpstdnon" };
        default { "amovpercmstpsnonwnondnon" };
    };
    _this switchMove _animation;
};
