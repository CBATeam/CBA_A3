#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: cba_optics_fnc_restartCamera

Description:
    Restarts the PIP camera for scripted optics.

Parameters:
    _unit  - The avatar <OBJECT>
    _reset - Restart PIP camera if true (optional, default: true) <BOOL>

Returns:
    Nothing.

Examples:
    (begin example)
        player call cba_optics_fnc_restartCamera;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

if (!GVAR(usePipOptics)) exitWith {};
if (configProperties [configFile >> "CBA_PIPItems"] isEqualTo []) exitWith {};
if (isNull (uiNamespace getVariable ["RscDisplayMission", displayNull])) exitWith {};

params ["_unit", ["_reset", true]];

if (_reset) then {
    GVAR(camera) cameraEffect ["TERMINATE", "BACK"];
    camDestroy GVAR(camera);

    // PIP technique by BadBenson
    GVAR(camera) = "camera" camCreate positionCameraToWorld [0,0,0];
    GVAR(camera) camSetFov 0.7;
    GVAR(camera) camSetTarget _unit;
    GVAR(camera) camCommit 1;

    QGVAR(rendertarget0) setPiPEffect [2, 1.0, 1.0, 1.0, 0.0, [0.0, 1.0, 0.0, 0.25], [1.0, 0.0, 1.0, 1.0], [0.199, 0.587, 0.114, 0.0]];
    GVAR(camera) cameraEffect ["INTERNAL", "BACK", QGVAR(rendertarget0)];

    INFO("Scripted camera restarted.");
};
