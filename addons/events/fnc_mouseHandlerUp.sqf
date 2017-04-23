/* ----------------------------------------------------------------------------
Internal Function: CBA_events_fnc_mouseHandlerUp

Description:
    Executes the mouse's handler

Author:
    commy2
---------------------------------------------------------------------------- */
// #define DEBUG_MODE_FULL
#include "script_component.hpp"
SCRIPT(mouseHandlerUp);

params ["_display", "_inputButton"];

private _inputModifiers = _this select [4,3];

([_display, MOUSE_OFFSET + _inputButton] + _inputModifiers) call FUNC(keyHandlerUp);
