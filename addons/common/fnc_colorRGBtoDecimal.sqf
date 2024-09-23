#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_colorRGBtoDecimal

Description:
    Converts an RGB coded color without transparency to the ingame decimal color format.

Parameters:
    _red - The red channel, 0-255 <NUMBER>
    _green - The green channel, 0-255 <NUMBER>
    _blue - The blue channel, 0-255 <NUMBER>

Returns:
    Ingame color format <ARRAY>

Examples:
    (begin example)
        [186,38,25] call test_fnc_colorRGBtoDecimal
    (end)

Author:
    drofseh & Lambda.Tiger
---------------------------------------------------------------------------- */
SCRIPT(colorRGBtoDecimal);

params [["_red", 0, [0]],["_green", 0, [0]],["_blue", 0, [0]]];
[_red,_green,_blue] apply {(0 max _x min 255)/255}
