#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_convertStringCode

Description:
    Converts a String into Code - Also checks for existing Functions with that name.

Parameters:
    _str - Code as String <STRING>

Returns:
    Code as Code <CODE>

Examples:
    (begin example)
        getText (_cfg >> "statement") call CBA_fnc_convertStringCode
    (end)

Author:
    OverlordZorn
---------------------------------------------------------------------------- */
params [["_stringCode", "", [""]]];

switch (true) do {
    case (_stringCode isEqualTo ""): {{}};
    case (!(missionNamespace isNil _stringCode)): {missionNamespace getVariable _stringCode};
    case (!(uiNamespace isNil _stringCode)): {uiNamespace getVariable _stringCode};
    default {compile _stringCode};
}
