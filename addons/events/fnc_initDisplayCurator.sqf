#include "script_component.hpp"

params ["_display"];

_display displayAddEventHandler ["KeyDown", {call FUNC(keyHandlerDown)}];
_display displayAddEventHandler ["KeyUp", {call FUNC(keyHandlerUp)}];
_display displayAddEventHandler ["MouseButtonDown", {call FUNC(mouseHandlerDown)}];
_display displayAddEventHandler ["MouseButtonUp", {call FUNC(mouseHandlerUp)}];
_display displayAddEventHandler ["MouseZChanged", {call FUNC(mouseWheelHandler)}];
