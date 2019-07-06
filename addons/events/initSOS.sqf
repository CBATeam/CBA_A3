if (hasInterface) then {
    ["CBA_playSoundSOS", {
        params ["_origin", "_sound", "_handler"];

        GVAR(publicSounds) setVariable [_handler, [objNull, _origin]];

        [_origin, {
            params ["_origin", "", "_args"];
            _args params ["_sound", "_handler"];

            private _source = allMissionObjects "#soundonvehicle";
            _origin say3D _sound;
            _source = (allMissionObjects "#soundonvehicle" - _source) param [0, objNull];

            GVAR(publicSounds) setVariable [_handler, [_source, _origin]];
        }, [_sound, _handler]] call CBA_fnc_executeWhenSoundWaveArrived;
    }] call CBA_fnc_addEventHandler;

    ["CBA_stopSoundSOS", {
        params ["_handler"];

        (GVAR(publicSounds) getVariable [_handler, [nil, objNull]]) params ["", "_origin"];

        [_origin, {
            params ["", "", "_handler"];
            (GVAR(publicSounds) getVariable _handler) params ["_source"];

            deleteVehicle _source;
        }, _handler] call CBA_fnc_executeWhenSoundWaveArrived;
    }] call CBA_fnc_addEventHandler;

    ["CBA_playSoundSOS_createDummy", {
        params ["_origin", "_sound", "_handler"];

        GVAR(publicSounds) setVariable [_handler, [objNull, _origin]];

        [_origin, {
            params ["_origin", "_position", "_args"];
            _args params ["_sound", "_handler"];

            private _dummy = "#particlesource" createVehicleLocal ASLToAGL _position;

            if (!isNull _origin) then {
                _dummy attachTo [_origin, [0,0,0]];
            };

            private _source = allMissionObjects "#soundonvehicle";
            _dummy say3D _sound;
            _source = (allMissionObjects "#soundonvehicle" - _source) param [0, objNull];

            GVAR(publicSounds) setVariable [_handler, [_source, _origin]];

            // Source is deleted by game if sound finished, manually delete dummy.
            [{
                params ["_source"];
                isNull _source // return
            }, {
                params ["", "_dummy"];
                detach _dummy;
                deleteVehicle _dummy;
            }, [_source, _dummy]] call CBA_fnc_waitUntilAndExecute;
        }, [_sound, _handler]] call CBA_fnc_executeWhenSoundWaveArrived;
    }] call CBA_fnc_addEventHandler;

    ["CBA_playSoundSOSLooped", {
    }] call CBA_fnc_addEventHandler;

    ["CBA_stopSoundSOSLooped", {
        params ["_handler"];

        (GVAR(publicSounds) getVariable [_handler, [nil, objNull]]) params ["", "_origin"];

        [_origin, {
            params ["", "", "_handler"];
            (GVAR(publicSounds) getVariable _handler) params ["_source", "_dummy"];

            deleteVehicle _source;
            deleteVehicle _dummy;
        }, _handler] call CBA_fnc_executeWhenSoundWaveArrived;
    }] call CBA_fnc_addEventHandler;
};
