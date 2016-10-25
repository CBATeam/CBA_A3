#include "script_component.hpp"

params ["_display"];

_display displayAddEventHandler ["KeyDown", {_this call FUNC(keyHandlerDown)}];
_display displayAddEventHandler ["KeyUp", {_this call FUNC(keyHandlerUp)}];
