// inline function, don't include script_component.hpp

0 = 0 spawn {
    {
        // --- read previous setting values from mission
        private _settingsHash = getMissionConfigValue QGVAR(hash);

        if (isNil "_settingsHash") then {
            _settingsHash = NULL_HASH;
        };

        [_settingsHash, {
            _value params ["_value", "_forced"];

            GVAR(missionSettings) setVariable [_key, [_value, _forced]];
        }] call CBA_fnc_hashEachPair;

        // --- refresh all settings now
        QGVAR(refreshAllSettings) call CBA_fnc_localEvent;
    } call CBA_fnc_directCall;
};
