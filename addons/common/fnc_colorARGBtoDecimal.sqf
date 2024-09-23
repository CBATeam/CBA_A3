#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_colorARGBtoDecimal

Description:
    Converts an ARGB coded color with transparency to the ingame decimal color format.

Parameters:
    _alpha - The alpha/transparency channel, 0-255 <NUMBER>
    _red - The red channel, 0-255 <NUMBER>
    _green - The green channel, 0-255 <NUMBER>
    _blue - The blue channel, 0-255 <NUMBER>

Returns:
    Ingame color format <ARRAY>

Examples:
    (begin example)
        [255,186,38,25] call CBA_fnc_colorARGBtoDecimal
    (end)

Author:
    drofseh & Lambda.Tiger
---------------------------------------------------------------------------- */
SCRIPT(colorARGBtoDecimal);

params [["_alpha", 0, [0]],["_red", 0, [0]],["_green", 0, [0]],["_blue", 0, [0]]];
[_red,_green,_blue,_alpha] apply {(0 max _x min 255)/255}
