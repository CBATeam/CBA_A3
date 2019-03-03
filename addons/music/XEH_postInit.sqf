#include "script_component.hpp"

if (!hasInterface) exitWith {};

private _name = toLower ([missionName, worldName] joinString ".");

if (_name in ["introexp.stratis", "introorange.altis", "introexp.vr", "malden_intro.malden", "tanoa_intro1.tanoa"]) then {
    GVAR(MainMenuMusic) = ["AmbientTrack01_F_Tank"
        //"RadioAmbient1", "RadioAmbient2", "RadioAmbient3", "RadioAmbient4", "RadioAmbient5",
        //"RadioAmbient6", "RadioAmbient7", "RadioAmbient8", "RadioAmbient9", "RadioAmbient10",
        //"RadioAmbient11", "RadioAmbient12", "RadioAmbient13", "RadioAmbient14", "RadioAmbient15",
        //"RadioAmbient16", "RadioAmbient17", "RadioAmbient18", "RadioAmbient19", "RadioAmbient20",
        //"RadioAmbient21", "RadioAmbient22", "RadioAmbient23", "RadioAmbient24", "RadioAmbient25",
        //"RadioAmbient26", "RadioAmbient27", "RadioAmbient28", "RadioAmbient29", "RadioAmbient30"
    ];

    addMusicEventHandler ["MusicStart", {
        params ["_music"];

        if !(_music in GVAR(MainMenuMusic)) then {
            playMusic selectRandom GVAR(MainMenuMusic);
        };
    }];

    addMusicEventHandler ["MusicStop", {
        playMusic selectRandom GVAR(MainMenuMusic);
    }];

    playMusic selectRandom GVAR(MainMenuMusic);
};
