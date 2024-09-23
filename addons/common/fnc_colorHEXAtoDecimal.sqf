#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_colorHEXAtoDecimal

Description:
    Converts a hexidecimal coded color with transparency to the ingame decimal color format.

Parameters:
    _hexString - A hexidecimal color code, "RRGGBBAA" with or without a leading # <STRING>

Returns:
    Ingame color format <ARRAY>

Examples:
    (begin example)
        "BA2619AA" call CBA_fnc_colorHEXAtoDecimal
    (end)

Author:
    Lambda.Tiger & drofseh
---------------------------------------------------------------------------- */
SCRIPT(colorHEXAtoDecimal);

params [["_hexString", "000000FF", [""]]];

_hexString = ((toUpperANSI _hexString) trim ["#", 0]) regexReplace ["[^0-9A-F]", "0"];

private _values = _hexString splitString "";

[
    call compile ("0x"+_values#0+_values#1),
    call compile ("0x"+_values#2+_values#3),
    call compile ("0x"+_values#4+_values#5),
    call compile ("0x"+_values#6+_values#7)
] call CBA_fnc_colorRGBAtoDecimal;
