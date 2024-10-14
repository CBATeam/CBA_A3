#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_colorRGBAtoDecimal

Description:
    Converts an RGBA coded color with transparency to the ingame decimal color format.

Parameters:
    _red - The red channel, 0-255 <NUMBER>
    _green - The green channel, 0-255 <NUMBER>
    _blue - The blue channel, 0-255 <NUMBER>
    _alpha - The alpha/transparency channel, 0-255 <NUMBER>

Returns:
    Ingame color format <ARRAY>

Examples:
    (begin example)
        [186,38,25,255] call CBA_fnc_colorRGBAtoDecimal
    (end)

Author:
    drofseh & Lambda.Tiger
---------------------------------------------------------------------------- */
SCRIPT(colorRGBAtoDecimal);

params [["_red", 0, [0]],["_green", 0, [0]],["_blue", 0, [0]],["_alpha", 255, [0]]];
[_red,_green,_blue,_alpha] apply {(0 max _x min 255)/255}
