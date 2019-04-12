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

// store zeroing
private _unit = call CBA_fnc_currentUnit;
private _optic = _unit call FUNC(currentOptic);

private "_discreteZeroingDistances";

configProperties [configFile >> "CfgWeapons" >> _optic >> "ItemInfo" >> "OpticsModes"] findIf {
    _discreteZeroingDistances = _x >> "discreteDistance";
    !isNil "_discreteZeroingDistances"
};

private _zeroing = getArray ([_discreteZeroingDistances] param [0, configNull]) find currentZeroing _unit;

if (_zeroing isEqualTo -1) then {
    _zeroing = nil;
};

parsingNamespace setVariable [QGVAR(magnification), _magnification];
_unit addPrimaryWeaponItem _optic;
parsingNamespace setVariable [QGVAR(zeroing), _zeroing];

[{
    params ["_unit", "_optic"];

    parsingNamespace setVariable [QGVAR(magnification), nil];
    _unit addPrimaryWeaponItem _optic;
    parsingNamespace setVariable [QGVAR(zeroing), nil];
}, [_unit, _optic]] call CBA_fnc_execNextFrame;

// @todo, rifle, pistol, launcher, plus optics
