#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_replace

Description:
    Replaces substrings within a string. Case-dependent.

Parameters:
    _string      - String to make replacement in <STRING>
    _pattern     - Substring to replace <STRING>
    _replacement - String to replace the _pattern with <STRING>

Returns:
    String with replacements made <STRING>

Example:
    (begin example)
        _str = ["Fish frog cheese fromage", "fro", "pi"] call CBA_fnc_replace;
        // => "Fish pig cheese pimage"
    (end)

Author:
    BaerMitUmlaut
--------------------------------------------------------------------------- */
SCRIPT(replace);

params [["_string", "", [""]], ["_find", "", [""]], ["_replace", "", [""]]];

// "1" find "" -> 0
if (_find == "") exitWith {_string};

// building the pattern costs more than this check, and most calls don't match
if (_string find _find == -1) exitWith {_string};

// what is searched for is a literal, regexReplace wants a pattern
private _pattern = _find call CBA_fnc_escapeRegex;

// and what it is replaced with is a literal too, but the replacement is not a
// pattern - it is Perl format, where "$" starts a substitution ($&, $1) and "\"
// starts an escape (\U, \L). Doubling both is what writes them out as themselves.
private _format = _replace;

if (_format find "\" != -1) then {
    _format = _format regexReplace ["\\", "\\\\"];
};

if (_format find "$" != -1) then {
    _format = _format regexReplace ["\$", "$$$$"];
};

// with no flags the engine defaults to "gi", and this function is case-dependent,
// so global has to be asked for explicitly to get case-sensitive with it
_string regexReplace [_pattern + "/g", _format] // return
