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

// A full-screen scripted camera (e.g. a mission cutscene camera) is the primary camera and is not a unit or vehicle.
#define FULLSCREEN_CAMERA_ACTIVE ((allCameras findIf {(_x select 2) && {!((_x select 0) isKindOf "AllVehicles")}}) != -1)

if (
    !GVAR(usePipOptics)
    || {configProperties [configFile >> "CBA_PIPItems"] isEqualTo []}
    || {isNull (uiNamespace getVariable ["RscDisplayMission", displayNull])}
    || {!isNull (uiNamespace getVariable ["RscDisplayCurator", displayNull])}
) exitWith {};

params ["_unit", ["_reset", true]];

if (_reset) then {
    // Render-to-texture cameras can't be combined with a full-screen camera: starting ours would end it.
    // Restart once that camera is gone instead.
    if (FULLSCREEN_CAMERA_ACTIVE) exitWith {
        if (isNil QGVAR(restartPending)) then {
            GVAR(restartPending) = true;
            [{!FULLSCREEN_CAMERA_ACTIVE}, {
                GVAR(restartPending) = nil;
                _this call FUNC(restartCamera);
            }, [_unit, true]] call CBA_fnc_waitUntilAndExecute;
        };
    };

    GVAR(camera) cameraEffect ["TERMINATE", "BACK", QGVAR(rendertarget0)];
    camDestroy GVAR(camera);

    // PIP technique by BadBenson
    GVAR(camera) = "camera" camCreate positionCameraToWorld [0,0,0];
    GVAR(camera) camSetFov 0.75;
    GVAR(camera) camSetTarget _unit;
    GVAR(camera) camCommit 1;

    GVAR(camera) cameraEffect ["INTERNAL", "BACK", QGVAR(rendertarget0)];
    QGVAR(rendertarget0) setPiPEffect [0];

    INFO("Scripted camera restarted.");
};
