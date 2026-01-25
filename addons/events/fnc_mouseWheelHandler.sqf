#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_events_fnc_mouseWheelHandler

Description:
    Executes the mouse wheel's handler

Author:
    commy2
---------------------------------------------------------------------------- */
SCRIPT(mouseWheelHandler);

params ["_display", "_inputDirection"];

private _inputDirection = parseNumber (_inputDirection < 0);

[_display, MOUSE_WHEEL_OFFSET + _inputDirection, GVAR(shift), GVAR(control), GVAR(alt)] call FUNC(keyHandlerDown);
[_display, MOUSE_WHEEL_OFFSET + _inputDirection, GVAR(shift), GVAR(control), GVAR(alt)] call FUNC(keyHandlerUp);
