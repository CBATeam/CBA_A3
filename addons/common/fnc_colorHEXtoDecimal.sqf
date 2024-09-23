#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_colorHEXtoDecimal

Description:
    Converts a hexidecimal coded color without transparency to the ingame decimal color format.

Parameters:
    _hexString - A hexidecimal color code, "RRGGBB" with or without a leading # <STRING>

Returns:
    Ingame color format <ARRAY>

Examples:
    (begin example)
        "BA2619" call CBA_fnc_colorHEXtoDecimal
    (end)

Author:
    Lambda.Tiger & drofseh
---------------------------------------------------------------------------- */
SCRIPT(colorHEXtoDecimal);

params [["_hexString", "000000", [""]]];

_hexString = ((toUpperANSI _hexString) trim ["#", 0]) regexReplace ["[^0-9A-F]", "0"];

private _values = _hexString splitString "";

[
    call compile ("0x"+_values#0+_values#1),
    call compile ("0x"+_values#2+_values#3),
    call compile ("0x"+_values#4+_values#5)
] call CBA_fnc_colorRGBtoDecimal;
