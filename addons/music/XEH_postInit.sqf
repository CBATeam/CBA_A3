#include "script_component.hpp"

if (!hasInterface) exitWith {};

private _name = toLower ([missionName, worldName] joinString ".");

if (_name in ["introexp.stratis", "introorange.altis", "introexp.vr", "malden_intro.malden", "tanoa_intro1.tanoa"]) then {
    GVAR(MainMenuMusic) = "Defcon";

    addMusicEventHandler ["MusicStart", {
        params ["_music"];

        if (_music != GVAR(MainMenuMusic)) then {
            playMusic GVAR(MainMenuMusic);
        };
    }];

    addMusicEventHandler ["MusicStop", {
        playMusic GVAR(MainMenuMusic);
    }];

    //playMusic GVAR(MainMenuMusic);
};
