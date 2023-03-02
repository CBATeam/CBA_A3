#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_accessibility_fnc_shouldHint

Description:
    Checks if a sound should have a hint displayed.

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
    if the sound should have a hint displayed <BOOL>

Examples:
    (begin example)
        [["SCREAM", "BREATH"]] call CBA_accessibility_fnc_shouldHint;
    (end)

Author:
    Brett Mayson
---------------------------------------------------------------------------- */

if (GVAR(soundsHintAll)) exitWith {true};

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
    } != 0
}) != -1
