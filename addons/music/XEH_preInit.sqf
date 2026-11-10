#include "script_component.hpp"

// Class name of the music that is currently playing, "" if none.
// Tracked with music event handlers, so it also covers plain playMusic and tracks that ended.
GVAR(playing) = "";

addMusicEventHandler ["MusicStart", {
    params ["_className"];
    GVAR(playing) = _className;
}];

addMusicEventHandler ["MusicStop", {
    params ["_className"];

    if (_className == GVAR(playing)) then {
        GVAR(playing) = "";
    };

    if (!isNil QGVAR(track) && {GVAR(track) select 0 == _className}) then {
        GVAR(track) = nil;
    };
}];
