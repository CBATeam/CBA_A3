[
    ELSTRING(common,WeaponsCategory),
    QGVAR(ManualReticleNightSwitch),
    [LSTRING(manual_reticle_switch), LSTRING(manual_reticle_switch_tooltip)],
    {
        if (GVAR(manualReticleNightSwitch)) then {
            GVAR(useReticleNight) = !GVAR(useReticleNight);

            // play sound
            private _unit = call CBA_fnc_currentUnit;
            private _position = _unit modelToWorldVisualWorld (_unit selectionPosition "RightHand");

            SOUND_RETICLE_SWITCH params ["_filename", ["_volume", 1], ["_soundPitch", 1], ["_distance", 0]];

            // add file extension .wss as default
            if !(toLower (_filename select [count _filename - 4]) in [".wav", ".ogg", ".wss"]) then {
                _filename = format ["%1.wss", _filename];
            };

            playSound3D [_filename, objNull, false, _position, _volume, _soundPitch, _distance];

            true
        } else {false};
    },
    {},
    [DIK_NUMPAD0, [false, false, false]]
] call CBA_fnc_addKeybind;
