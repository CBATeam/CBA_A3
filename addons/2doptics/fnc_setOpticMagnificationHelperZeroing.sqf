#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cba_2doptics_fnc_setOpticMagnificationHelperZeroing

Description:
    Helper function used in config to remember the zeroing of a zooming optic.

Parameters:
    _value - "discreteDistanceInitIndex" <NUMBER>

Returns:
    Nothing.

Examples:
    (begin example)
        2 call (uiNamespace getVariable 'cba_2doptics_fnc_setOpticMagnificationHelperZeroing')
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

if (!isNil QGVAR(zeroing)) exitWith {GVAR(zeroing)};

_this
