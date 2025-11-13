#include "script_component.hpp"

addMusicEventHandler ["MusicStart", {
    params ["_class", "_eventId"];

    private _startPos = getMusicPlayedTime;
    private _startTime = time;
    private _duration = [_class, "duration"] call CBA_fnc_getMusicData;

    GVAR(track) = [_class, _startTime, _startPos, _duration];
}];

addMusicEventHandler ["MusicStop", {
    params ["_class", "_eventId"];

    GVAR(track) = nil;
}];
