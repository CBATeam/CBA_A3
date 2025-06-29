#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_createUUID

Description:
    Creates a version 4 UUID (universally unique identifier).

Parameters:
    None

Returns:
    UUID [String]

Example:
    (begin example)
        private _uuid = call CBA_fnc_createUUID;
    (end)

Author:
    BaerMitUmlaut
--------------------------------------------------------------------------- */
SCRIPT(createUUID);

private _hexDigits = [
    "0", "1", "2", "3", "4", "5", "6", "7",
    "8", "9", "a", "b", "c", "d", "e", "f"
];
private _versionByte = "4";
private _variantByte = selectRandom ["8", "9", "a", "b"];

private _uuid = [];
for "_i" from 0 to 29 do {
    _uuid pushBack selectRandom _hexDigits;
};

_uuid insert [8, ["-"]];
_uuid insert [13, ["-", _versionByte]];
_uuid insert [18, ["-", _variantByte]];
_uuid insert [23, ["-"]];
_uuid joinString ""
