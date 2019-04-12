#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cba_2doptics_fnc_setOpticMagnification

Description:
    Set magnification of the current optic of the unit.

Parameters:
    _unit          - The unit with a weapon <OBJECT>
    _magnification - Magnification to apply <NUMBER>

Returns:
    Nothing.

Examples:
    (begin example)
        [player, 3] call cba_2doptics_fnc_setOpticMagnification;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

if (!isNil {parsingNamespace getVariable QGVAR(magnification)}) exitWith {};

params ["_unit", "_magnification"];
private _optic = _unit call FUNC(currentOptic);

parsingNamespace setVariable [QGVAR(magnification), _magnification];
_unit addPrimaryWeaponItem _optic;

[{
    params ["_unit", "_optic"];

    parsingNamespace setVariable [QGVAR(magnification), nil];
    _unit addPrimaryWeaponItem _optic;
}, [_unit, _optic]] call CBA_fnc_execNextFrame;

// @todo, rifle, pistol, launcher, plus optics
