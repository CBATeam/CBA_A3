#include "script_component.hpp"
/* ----------------------------------------------------------------------------
    Function: CBA_fnc_playSoundSOS

    Description:
        Plays sound from object or position with speed of sound delay.

    Parameters:
        _origin - Object that emitted sound <OBJECT, PosASL>
        _sound  - CfgSounds class to play, rhs argument of say3D <STRING, ARRAY>

    Returns:
        Sound handler, used to stop the sound. <STRING>

    Examples:
    (begin example)
        _handler = [cursorTarget, "Alarm"] call CBA_fnc_playSoundSOS;

        private _dummy = "#particlesource" createVehicleLocal [0,0,0];
        _dummy attachTo [tank1, [0,0,0], "memory_point"];
        [_dummy, "Alarm"] call CBA_fnc_playSoundSOS;
    (end)

    Author:
        commy2
---------------------------------------------------------------------------- */

params [["_origin", objNull], ["_sound", "", ["", []]]];

if (!isNil QGVAR(publicSounds)) then {
    GVAR(publicSounds) = [] call CBA_fnc_createNamespace;
};

private _id = (GVAR(publicSounds) getVariable ["#id", -1]) + 1;

if (_id > 1E7) exitWith {
    ERROR_1("Maximum amount of sound ids reached. Sound was %1.", _sound);
    nil
};

GVAR(publicSounds) setVariable ["#id", _id];

private _handler = format ["%1:%2", CBA_clientID, _id];

if (_origin isEqualType objNull && {typeOf _origin isEqualTo ""}) then {
    // Origin is dummy.
    ["CBA_playSoundSOS", [_origin, _sound, _handler]] call CBA_fnc_globalEvent;
} else {
    // Origin is position or proper object, @todo CfgAmmo?
    ["CBA_playSoundSOS_createDummy", [_origin, _sound, _handler]] call CBA_fnc_globalEvent;
};

_handler
