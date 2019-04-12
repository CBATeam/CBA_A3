#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cba_2doptics_fnc_setOpticMagnificationHelper

Description:
    Helper function used in config to set the magnification of a zooming optic.

Parameters:
    _value - Min, max or init optic zoom <NUMBER>

Returns:
    Nothing.

Examples:
    (begin example)
        2 call (uiNamespace getVariable 'cba_2doptics_fnc_setOpticMagnificationHelper')
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

if (!isNil QGVAR(magnification)) exitWith {0.25/GVAR(magnification)};

0.25/_this
