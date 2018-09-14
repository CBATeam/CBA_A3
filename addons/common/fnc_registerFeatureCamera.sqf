#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_registerFeatureCamera

Description:
    Registers a feature camera for use with CBA_fnc_getActiveFeatureCamera.

Parameters:
    _name     - Name (unique/tagged) <STRING>
    _callback - Activity check (should return true if active, false otherwise) <CODE>

Returns:
    None

Examples:
    (begin example)
        _result = [
            "ace_spectator",
            {!isNull (missionNamespace getVariable ["ace_spectator_isSet", objNull])}
        ] call CBA_fnc_registerFeatureCamera
    (end)

Author:
    Sniperwolf572, Jonpas
---------------------------------------------------------------------------- */
SCRIPT(registerFeatureCamera);

GVAR(featureCameras) pushBackUnique _this;
