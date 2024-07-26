#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_optics_fnc_setOpticMagnification

Description:
    Set magnification of the current optic of the unit.

Parameters:
    _unit          - The unit with a weapon <OBJECT>
    _magnification - Magnification to apply <NUMBER>

Returns:
    Nothing.

Examples:
    (begin example)
        [player, 3] call cba_optics_fnc_setOpticMagnification;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

if (!isNil {parsingNamespace getVariable QGVAR(magnification)}) exitWith {};

params ["_unit", "_magnification"];

// store zeroing
private _zeroing = GVAR(ZeroingDistances) find currentZeroing _unit;

if (_zeroing isEqualTo -1) then {
    _zeroing = nil;
};

parsingNamespace setVariable [QGVAR(magnification), _magnification];
parsingNamespace setVariable [QGVAR(zeroing), _zeroing];
_unit setOpticsMode GVAR(scriptedOpticsIndex);

[{
    params ["_unit", "_opticsMode"];

    parsingNamespace setVariable [QGVAR(magnification), nil];
    _unit setOpticsMode _opticsMode;
    parsingNamespace setVariable [QGVAR(zeroing), nil];
}, [_unit, GVAR(scriptedOpticsIndex)]] call CBA_fnc_execNextFrame;

// @todo, rifle, pistol, launcher, plus optics
