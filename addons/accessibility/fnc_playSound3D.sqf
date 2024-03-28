#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_playSound3D

Description:
    Plays a sound from an object if allowed.
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
    _source - Sound source <OBJECT>
    _args - Arguments passed to playSound3D <ARRAY>
    _hint - Hint to display <STRING> or <ARRAY>
        0: Hint text <STRING>
        1: Hint duration <NUMBER>

    See <https://community.bistudio.com/wiki/playSound3D> for more information on _source and _args.

Returns:
    If the sound was played <BOOL>

Examples:
    (begin example)
        ["MySound", ["FOOD"], _unit] call CBA_fnc_playSound3D;
        ["MySound", ["SCREAM", "BREATH"], [_unit, player], [], "hint"] call CBA_fnc_playSound3D;
        ["MySound", ["SCREAM", "BREATH"], _unit, [false, [0,1,0]]] call CBA_fnc_playSound3D;
    (end)

Author:
    Brett Mayson
---------------------------------------------------------------------------- */

params [
    ["_sound", "", [""]],
    ["_categories", [], [[]]],
    ["_source", objNull, [objNull]],
    ["_args", [], [[]]],
    ["_hint", "", ["", []]]
];

if (_source isEqualTo objNull) exitWith {false};
if (_sound isEqualTo "") exitWith {false};

private _shouldPlay = [_categories] call CBA_accessibility_fnc_shouldPlay;
private _shouldHint = [_categories] call CBA_accessibility_fnc_shouldHint;

if (_shouldPlay) then {
    _args = [_sound, _source] + _args;
    playSound3D _args;
};

if (_shouldHint) then {
    if (_hint isEqualTo "") then {
        _hint = getText (configFile >> "CfgSounds" >> _sound >> "cba_accessibility_hint");
    };
    if (_hint isEqualTo "") then {
        _hint = _sound;
    };
    if (_source isEqualType []) then {
        _source = _source select 0;
    };
    [_hint, _source] call FUNC(hint);
};
