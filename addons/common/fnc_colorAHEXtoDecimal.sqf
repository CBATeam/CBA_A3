#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_colorAHEXtoDecimal

Description:
    Converts a hexidecimal coded color with transparency to the ingame decimal color format.

Parameters:
    _hexString - A hexidecimal color code, "AARRGGBB" with or without a leading # <STRING>

Returns:
    Ingame color format <ARRAY>

Examples:
    (begin example)
        "AABA2619" call CBA_fnc_colorAHEXtoDecimal
    (end)

Author:
    Lambda.Tiger & drofseh
---------------------------------------------------------------------------- */
SCRIPT(colorAHEXtoDecimal);

params [["_hexString", "FF000000", [""]]];

_hexString = ((toUpperANSI _hexString) trim ["#", 0]) regexReplace ["[^0-9A-F]", "0"];

private _values = _hexString splitString "";

[
    call compile ("0x"+_values#2+_values#3),
    call compile ("0x"+_values#4+_values#5),
    call compile ("0x"+_values#6+_values#7),
    call compile ("0x"+_values#0+_values#1)
] call CBA_fnc_colorRGBAtoDecimal;
