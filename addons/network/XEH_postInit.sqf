#include "script_component.hpp"

if (hasInterface) then {
    [QGVAR(say3D), {
        params ["_object", "_params", "_attach", "_instant", "_parallel"];

        // Delete previously attached sounds so the new sound can be played instantly
        if (_instant) then {
            [QGVAR(stopSounds), _object] call CBA_fnc_localEvent;
        };

        private _source = _object;

        // create helper to allow for multiple sounds be played from one object at once
        if (_parallel) then {
            private _helper = "Helper_Base_F" createVehicleLocal (getPos _object);
            _helper attachTo [_object, [0,0,0]];
            _source = _helper;
        };

        // Attaching is mainly meant for vehicles in motion
        private _sound = _source say3D _params;
        if (_attach) then {
            _sound attachTo [_source];
        };

        // Removes Helper when the sound is done or the object is dead.
        if (_parallel) then {
            [
                { ! alive (_this#0) || { ! alive (_this#1) } },
                { deleteVehicle (_this#2) },
                [_sound, _source, _helper]
            ] call CBA_fnc_waitUntilAndExecute;
        };


    }] call CBA_fnc_addEventHandler;

    [QGVAR(stopSounds), {
        params ["_object"];
        { deleteVehicle _x } forEach (attachedObjects _object select { typeOf _x isEqualTo "#soundonvehicle" });
    }] call CBA_fnc_addEventHandler;

    [QGVAR(say), {
        params ["_object", "_params"];
        _object say _params;
    }] call CBA_fnc_addEventHandler;
};
