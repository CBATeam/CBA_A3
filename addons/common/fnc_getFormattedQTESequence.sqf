#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getFormattedQTESequence

Description:
	Formats Quick-Time sequence into a displayable string.

Parameters:
    _code - Quick-Time sequence <ARRAY>


Example:
    [["↑", "↓", "→", "←"]] call CBA_fnc_getFormattedQTESequence;

Returns:
    Formatted Quick-Time sequence <STRING>

Author:
    john681611
---------------------------------------------------------------------------- */

params ["_code"];

_code joinString "     " // Arma doesn't know how to space ↑ so we need loads of spaces between
