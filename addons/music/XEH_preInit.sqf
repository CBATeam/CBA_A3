#include "script_component.hpp"

addMusicEventHandler ["MusicStart", {
    params ["_className", "_eventId"];

    private _playPos = getMusicPlayedTime;
    private _duration = [_className, "duration"] call CBA_fnc_getMusicData;

    GVAR(track) = [_className, CBA_missionTime, _playPos, _duration];
}];

addMusicEventHandler ["MusicStop", {
    params ["_className", "_eventId"];

    GVAR(track) = nil;
}];
