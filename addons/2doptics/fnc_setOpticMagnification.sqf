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
private _weapon = currentWeapon _unit;
private _optic = _unit call FUNC(currentOptic);

// store zeroing
private "_discreteZeroingDistances";

configProperties [configFile >> "CfgWeapons" >> _optic >> "ItemInfo" >> "OpticsModes"] findIf {
    _discreteZeroingDistances = _x >> "discreteDistance";
    !isNil "_discreteZeroingDistances"
};

private _zeroing = GVAR(ZeroingDistances) find currentZeroing _unit;

if (_zeroing isEqualTo -1) then {
    _zeroing = nil;
};

parsingNamespace setVariable [QGVAR(magnification), _magnification];
parsingNamespace setVariable [QGVAR(zeroing), _zeroing];
_unit addWeaponItem [_weapon, _optic];

[{
    params ["_unit", "_weapon", "_optic"];

    parsingNamespace setVariable [QGVAR(magnification), nil];
    _unit addWeaponItem [_weapon, _optic];
    parsingNamespace setVariable [QGVAR(zeroing), nil];
}, [_unit, _weapon, _optic]] call CBA_fnc_execNextFrame;

// @todo, rifle, pistol, launcher, plus optics
