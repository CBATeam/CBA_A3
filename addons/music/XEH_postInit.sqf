#include "script_component.hpp"

// Track the playing music with music event handlers, so plain playMusic and tracks that ended are covered too.
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
