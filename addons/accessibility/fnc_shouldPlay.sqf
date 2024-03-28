#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_accessibility_fnc_shouldPlay

Description:
    Checks if a sound should be played based on the categories it is in.

Parameters:
    _categories - Categories the sound is in <ARRAY>
        - "BREATH"
        - "BODILY"
        - "PAIN"
        - "SCREAM"
        - "FOOD"
        - "EQUIPMENT"
        - "REPETITIVE"

Returns:
    if the sound should be played <BOOL>

Examples:
    (begin example)
        [["SCREAM", "BREATH"]] call CBA_accessibility_fnc_shouldPlay;
    (end)

Author:
    Brett Mayson
---------------------------------------------------------------------------- */

params [
    ["_categories", [], [[]]]
];

(_categories findIf {
    switch (toUpper _x) do {
        case "BREATH":      {GVAR(soundsBreath)};
        case "BODILY":      {GVAR(soundsBodily)};
        case "PAIN":        {GVAR(soundsPain)};
        case "SCREAM":      {GVAR(soundsScream)};
        case "FOOD":        {GVAR(soundsFood)};
        case "EQUIPMENT":   {GVAR(soundsEquipment)};
        case "REPETITIVE":  {GVAR(soundsRepetitive)};
        default {
            WARNING_1("Unknown sound category: %1", _x);
            false
        };
    } == 2
}) == -1
