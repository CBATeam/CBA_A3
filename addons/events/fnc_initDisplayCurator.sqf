#include "script_component.hpp"

params ["_display"];

_display displayAddEventHandler ["KeyDown", {call FUNC(keyHandlerDown)}];
_display displayAddEventHandler ["KeyUp", {call FUNC(keyHandlerUp)}];
_display displayAddEventHandler ["MouseButtonDown", {}];
_display displayAddEventHandler ["MouseButtonUp", {}];
