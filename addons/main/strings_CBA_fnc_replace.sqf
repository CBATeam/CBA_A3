#define THIS_FILE CBA\main\replace
scriptName 'THIS_FILE';
// ----------------------------------------------------------------------------
// @description Replaces substrings within a string. Case-dependent.
//
// Example:
//   _str = ["Fish frog cheese fromage", "fro", "pi"] call CBA_fnc_replace;
//   // => "Fish pig cheese pimage"
//
// Parameters:
//   0: _string - String to trim [String]
//   1: _pattern - Substring to replace [String]
//   2: _replacement - String to replace with [String]
//
// Returns:
//   String with replacements made [String]
//
// ----------------------------------------------------------------------------

#include "script_component.hpp"

// ----------------------------------------------------------------------------

PARAMS_3(_string,_pattern,_replacement);

// Return.
[[_string, _pattern] call CBA_fnc_split], _replacement] call CBA_fnc_join;