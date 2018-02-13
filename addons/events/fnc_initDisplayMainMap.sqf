#include "script_component.hpp"

params ["_display"];

// set up CBA_fnc_addKeyHandler
_display displayAddEventHandler ["KeyDown",         {if (visibleMap) then {call FUNC(keyHandlerDown)};}];
_display displayAddEventHandler ["KeyUp",           {if (visibleMap) then {call FUNC(keyHandlerUp)};}];
_display displayAddEventHandler ["MouseButtonDown", {if (visibleMap) then {call FUNC(mouseHandlerDown)};}];
_display displayAddEventHandler ["MouseButtonUp",   {if (visibleMap) then {call FUNC(mouseHandlerUp)};}];
_display displayAddEventHandler ["MouseZChanged",   {if (visibleMap) then {call FUNC(mouseWheelHandler)};}];
_display displayAddEventHandler ["MouseMoving",     {if (visibleMap) then {call FUNC(userKeyHandler)};}];
_display displayAddEventHandler ["MouseHolding",    {if (visibleMap) then {call FUNC(userKeyHandler)};}];
