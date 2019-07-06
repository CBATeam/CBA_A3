#include "script_component.hpp"
/* ----------------------------------------------------------------------------
    Function: CBA_fnc_executeWhenSoundWaveArrived

    Description:
        Executes code snippet if sound from an origin has arrived at the camera.

    Parameters:
        _origin    - Object or position from where sound emits <OBJECT, PosASL>
        _code      - Code to execute <CODE>
        _arguments - Additional arguments to pass to code, default [] <ANY>

    Returns:
        Nothing.

    Passed Arguments:
        _origin    - Same as above OR null object <OBJECT>
        _position  - Current position of origin OR initial position <PosASL>
        _arguments - Same as above <NUMBER>

    Examples:
    (begin example)
        [cursorTarget, {playSound (_this select 2)}, "Alarm"] call CBA_fnc_executeWhenSoundWaveArrived;
    (end)

    Author:
        commy2
---------------------------------------------------------------------------- */

if (!hasInterface) exitWith {};

params [
    ["_origin", cameraOn, [objNull, []], [3]],
    ["_code", {}, [{}]],
    ["_arguments", []]
];

[{
    params ["_code", "_origin", "_arguments", "_startTime"];

    // Abort if origin of sound was deleted.
    if (_origin isEqualTo objNull) exitWith {
        true // quit
    };

    private _position = _origin;
    if (_position isEqualType objNull) then {
        _position = getPosASL _position;
    } else {
        _origin = objNull;
    };

    private _distanceToCamera = _position vectorDistance AGLToASL positionCameraToWorld [0,0,0];
    private _travelledDistance = (CBA_missionTime - _startTime) * SPEED_OF_SOUND;

    if (_distanceToCamera < _travelledDistance) exitWith {
        [_origin, _position, _arguments] call _code;

        true // quit
    };

    false // continue
}, {}, [_code, _origin, _arguments, CBA_missionTime]] call CBA_fnc_waitUntilAndExecute;

nil
