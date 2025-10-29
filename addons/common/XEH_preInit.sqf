//#define DEBUG_MODE_FULL
#include "script_component.hpp"
SCRIPT(XEH_preInit);

LOG(MSG_INIT);

ADDON = false;

CBA_logic = objNull;

[QFUNC(log), {
    diag_log text _this;
    _this spawn {
        sleep 1;
        systemChat _this;
        hintC _this;
    };
}] call CBA_fnc_compileFinal;

// FSM
GVAR(delayless) = QUOTE(PATHTOF(delayless.fsm));
GVAR(delayless_loop) = QUOTE(PATHTOF(delayless_loop.fsm));

// Initialize Components
GVAR(groups) = [grpNull, grpNull, grpNull, grpNull, grpNull];
GVAR(featureCamerasCode) = [
    {!isNull curatorCamera}, // Curator
    {!isNull (missionNamespace getVariable ["BIS_EGSpectatorCamera_camera", objNull])}, // BIS Nexus Spectator
    {!isNull (uiNamespace getVariable ["BIS_fnc_arsenal_cam", objNull])}, // Arsenal camera
    {!isNull (missionNamespace getVariable ["BIS_fnc_establishingShot_fakeUAV", objNull])}, // Establishing shot camera
    {!isNull (missionNamespace getVariable ["BIS_fnc_camera_cam", objNull])}, // Splendid camera
    {!isNull (uiNamespace getVariable ["BIS_fnc_animViewer_cam", objNull])}, // Animation viewer camera
    {!isNull (missionNamespace getVariable ["BIS_DEBUG_CAM", objNull])} // Classic camera
];
GVAR(featureCamerasNames) = [
    "curator", // Curator
    "nexus", // BIS Nexus Spectator
    "arsenal", // Arsenal camera
    "establishing", // Establishing shot camera
    "splendid", // Splendid camera
    "animViewer", // Animation viewer camera
    "classic" // Classic camera
];
if (isClass (configFile >> "CfgPatches" >> "missions_f_vietnam")) then { // Add SOG Cinematic module camera if CDLC loaded
    ["vn_cinematic", {missionNamespace getVariable ["vn_cinematic_running", false]}] call CBA_fnc_registerFeatureCamera;
};

call COMPILE_FILE(init_gauss);
call COMPILE_FILE(init_perFrameHandler);
call COMPILE_FILE(init_delayLess);

// Due to activateAddons being overwritten by eachother (only the last executed command will be active), we apply this bandaid
GVAR(addons) = call (uiNamespace getVariable [QGVAR(addons), {[]}]);
activateAddons GVAR(addons);

// BWC
#include "backwards_comp.inc.sqf"

// fix changing direction of remote units not working with zeus
["ModuleCurator_F", "init", {
    params ["_logic"];

    _logic addEventHandler ["CuratorObjectEdited", {
        params ["", "_unit"];

        if (!local _unit) then {
            private _dir = getDir _unit;
            [_unit, _dir] remoteExec ["setDir", _unit];

            if (_unit == formLeader _unit) then {
                [_unit, _dir] remoteExec ["setFormDir", _unit];
            };
        };
    }];
}] call CBA_fnc_addClassEventHandler;

// Loadout randomization
GVAR(randomLoadoutUnits) = createHashMap;
["CAManBase", "InitPost", CBA_fnc_addRandomizedMagazines] call CBA_fnc_addClassEventHandler;

// Load preStart css color array
GVAR(cssColorNames) = uiNamespace getVariable QGVAR(cssColorNames);

ADDON = true;
