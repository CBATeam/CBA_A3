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

[_display, MOUSE_OFFSET + _inputButton, GVAR(shift), GVAR(control), GVAR(alt)] call FUNC(keyHandlerUp);
