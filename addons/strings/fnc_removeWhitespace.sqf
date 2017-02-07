/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeWhitespace

Description:
    Removes whitespace (space, tab, newline) from string.

Parameters:
    _string   - Any String <STRING>
    _seperate - Seperate leftovers with spaces? (optional, default: false) <BOOLEAN>

Returns:
    String without whitespace <STRING>

Example:
    (begin example)
        " foo  bar   " call CBA_fnc_removeWhitespace;
        // "foobar"

        [" foo  bar   ", true] call CBA_fnc_removeWhitespace;
        // "foo bar"
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
#include "script_strings.hpp"
SCRIPT(removeWhitespace);

params [["_string", "", [""]], ["_seperate", false, [true]]];

(_string splitString toString WHITE_SPACE) joinString (["", " "] select _seperate) // return
