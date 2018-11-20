#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getActiveFeatureCamera

Description:
    Returns active feature camera.

    Checks for the following feature cameras:
    - Curator
    - Arsenal camera (BIS_fnc_arsenal)
    - Nexus Spectator (BIS_fnc_EGSpectator)
    - Establishing shot (BIS_fnc_establishingShot)
    - Splendid camera (BIS_fnc_camera)
    - Animation viewer (BIS_fnc_animViewer)
    - Classic camera (BIS_fnc_cameraOld)

    And cameras registered via CBA_fnc_registerFeatureCamera.

Parameters:
    None

Returns:
    Active feature camera ("" if none) <STRING>

Examples:
    (begin example)
        _result = [] call CBA_fnc_getActiveFeatureCamera
    (end)

Author:
    Sniperwolf572, Jonpas
---------------------------------------------------------------------------- */
SCRIPT(getActiveFeatureCamera);

GVAR(featureCamerasNames) param [GVAR(featureCamerasCode) findIf {call _x}, ""]
