#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_events_fnc_mouseHandlerDown

Description:
    Executes the mouse's handler

Author:
    commy2
---------------------------------------------------------------------------- */
SCRIPT(mouseHandlerDown);

params ["_display", "_inputButton", "", "", "_shift", "_control", "_alt"];

// use the modifier key states reported by the event itself
GVAR(shift) = _shift;
GVAR(control) = _control;
GVAR(alt) = _alt;

[_display, MOUSE_OFFSET + _inputButton, _shift, _control, _alt] call FUNC(keyHandlerDown);
