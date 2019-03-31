#include "script_component.hpp"

params ["_unit", ["_reset", true]];

if (_reset) then {
    BWA3_optics_camera cameraEffect ["TERMINATE", "BACK"];
    camDestroy BWA3_optics_camera;

    // PiP technique by BadBenson
    BWA3_optics_camera = "camera" camCreate positioncameratoworld [0,0,0];
    BWA3_optics_camera camSetFov 0.7;
    BWA3_optics_camera camSetTarget _unit;
    BWA3_optics_camera camCommit 1;

    "bwa3_optics_rendertarget0" setPiPEffect [2, 1.0, 1.0, 1.0, 0.0, [0.0, 1.0, 0.0, 0.25], [1.0, 0.0, 1.0, 1.0], [0.199, 0.587, 0.114, 0.0]];
    BWA3_optics_camera cameraEffect ["INTERNAL", "BACK", "bwa3_optics_rendertarget0"];

    BWA3_LOGINFO("Scripted camera restarted");
};
