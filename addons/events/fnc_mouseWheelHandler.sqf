/* ----------------------------------------------------------------------------
Internal Function: CBA_events_fnc_mouseWheelHandler

Description:
    Executes the mouse wheel's handler

Author:
    commy2
---------------------------------------------------------------------------- */
// #define DEBUG_MODE_FULL
#include "script_component.hpp"
SCRIPT(mouseWheelHandler);

params ["_display", "_inputDirection"];

private _inputDirection = [0, 1] select (_inputDirection < 0);

[_display, MOUSE_WHEEL_OFFSET + _inputDirection, GVAR(shift), GVAR(control), GVAR(alt)] call FUNC(keyHandlerDown);
[_display, MOUSE_WHEEL_OFFSET + _inputDirection, GVAR(shift), GVAR(control), GVAR(alt)] call FUNC(keyHandlerUp);
