#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_cssColorToDecimal
Description:
    Converts a CSS extended color keyword to the ingame decimal color format.
    Reference for colors: https://www.w3.org/TR/css-color-3/#svg-color
Parameters:
    _colorKeyword - A color keyword as defined as part of W3c's CSS color module level 3. <STRING>
Returns:
    Ingame RGB color format <ARRAY>
Examples:
    (begin example)
        "chartreuse" call CBA_fnc_colorAHEXtoDecimal
    (end)
Author:
    Lambda.Tiger & drofseh
---------------------------------------------------------------------------- */
SCRIPT(cssColorToDecimal);

params [["_colorKeyword", "orchid", [""]]];

(GVAR(cssColorNames) getOrDefault [toLowerANSI _colorKeyword,  [[0.6, 0.196, 0.8], "#9932CC", "#(rgb,8,8,3)color(0.6,0.196,0.8,1)"]]) select 0
