#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_playSound

Description:
    Plays a sound for the player if allowed.
    Displays a hint if requested.

Parameters:
    _sound - Sound to play <STRING>
    _categories - Categories the sound is in <ARRAY>
        - "BREATH"
        - "BODILY"
        - "PAIN"
        - "SCREAM"
        - "FOOD"
        - "EQUIPMENT"
        - "REPETITIVE"
    _args - Arguments passed to playSound3D <ARRAY>
    _hint - Hint to display <STRING> or <ARRAY>
        0: Hint text <STRING>
        1: Hint duration <NUMBER>

    See <https://community.bistudio.com/wiki/playSound> for more information on _args.

Returns:
    If the sound was played <BOOL>

Examples:
    (begin example)
        ["sound", ["SCREAM", "BREATH"]] call CBA_fnc_playSound;
        ["sound", ["FOOD"], [], "hint"] call CBA_fnc_playSound;
        ["sound", ["EQUIPMENT"], [1, 0.5]] call CBA_fnc_playSound;
    (end)

Author:
    Brett Mayson
---------------------------------------------------------------------------- */

params [
    ["_sound", "", [""]],
    ["_categories", [], [[]]],
    ["_args", [], [[]]],
    ["_hint", "", ["", []]]
];

if (_sound isEqualTo "") exitWith {false};

private _shouldPlay = [_categories] call CBA_accessibility_fnc_shouldPlay;
private _shouldHint = [_categories] call CBA_accessibility_fnc_shouldHint;

if (_shouldPlay) then {
    if (count _args == 0) then {
        _args = [false];
    };
    _args = [_sound] + _args;
    playSound _args;
};

if (_shouldHint) then {
    if (_hint isEqualTo "") then {
        _hint = getText (configFile >> "CfgSounds" >> _sound >> "cba_accessibility_hint");
    };
    if (_hint isEqualTo "") then {
        _hint = _sound;
    };
    [_hint] call FUNC(hint);
};
