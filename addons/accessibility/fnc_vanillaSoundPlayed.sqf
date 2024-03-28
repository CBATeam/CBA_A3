#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_accessibility_fnc_vanillaSoundPlayed

Description:
    Handles muting and hinting of vanilla sounds

Parameters:
    _unit - unit that played the sound <OBJECT>
    _sound - sound that was played <NUMBER>

Returns:
    0 if the sound should be muted <NUMBER>

Author:
    Brett Mayson
---------------------------------------------------------------------------- */

params [
    ["_unit", objNull, [objNull]],
    ["_sound", 0, [0]]
];

if (_unit == objNull) exitWith {false};
if (_sound == 0) exitWith {false};

switch (_sound) do {
    // Breath
    case 1: {["breath", ["REPETITIVE", "BREATH"]]};
    // Breath Injured
    case 2: {["breath_injured", ["REPETITIVE", "BREATH", "PAIN"]]};
    // Breath Scuba
    case 3: {["breath_scube", ["REPETITIVE", "BREATH"]]};
    // Injured
    case 4: {["injured", ["PAIN"]]};
    // Pulsation
    case 5: {["pulsation", ["REPETITIVE", "BODILY"]]};
    // Hit Scream
    case 6: {["hit_scream", ["PAIN", "SCREAM"]]};
    // Burning
    case 7: {["burning", ["PAIN"]]};
    // Drowning
    case 8: {["drowning", ["PAIN", "BREATH"]]};
    // Drown
    case 9: {["drown", ["PAIN", "BREATH"]]};
    // Gasping
    case 10: {["gasping", ["PAIN", "BREATH"]]};
    // Stabilizing
    case 11: {["stabilizing", []]}; // Not sure what this sounds like, may need to be added
    // Healing
    case 12: {["healing", ["EQUIPMENT"]]};
    // Healing with Medkit
    case 13: {["healing_with_medkit", ["EQUIPMENT"]]};
    // Recovered
    case 14: {["recovered", []]}; // Not sure what this sounds like, may need to be added
    // Breath Held
    case 15: {["breath_held", ["BREATH"]]};
    default {["", []]};
} params ["_hint", "_categories"];

if (_hint == "") exitWith {
    WARNING_1("Unknown sound played type: %1", _sound);
};

private _shouldPlay = [_categories] call CBA_accessibility_fnc_shouldPlay;
private _shouldHint = [_categories] call CBA_accessibility_fnc_shouldHint;

if (_shouldHint) then {
    [_hint, _unit] call FUNC(hint);
};

if (!_shouldPlay) exitWith {
    0
};
