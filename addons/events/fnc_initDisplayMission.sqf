#include "script_component.hpp"

params ["_display"];

// set up CBA_fnc_addDisplayHandler
uiNamespace setVariable ["CBA_missionDisplay", _display];

// re apply missions display event handlers when display is loaded (save game)
if (!isNil QGVAR(handlerHash)) then {
    [GVAR(handlerHash), {
        {
            private _code = _x param [1];

            if (!isNil "_code") then {
                private _handler = _display displayAddEventHandler [_key, _code];
                _x set [0, _handler];
            };
        } forEach _value;
    }] call CBA_fnc_hashEachPair;

    // copy hash reference to display namespace again, because it's not serialized in save games
    uiNamespace setVariable [QGVAR(handlerHash), GVAR(handlerHash)];
};

// set up CBA_fnc_addKeyHandler
_display displayAddEventHandler ["KeyDown",         {if (!visibleMap) then {call FUNC(keyHandlerDown)};}];
_display displayAddEventHandler ["KeyUp",           {if (!visibleMap) then {call FUNC(keyHandlerUp)};}];
_display displayAddEventHandler ["MouseButtonDown", {if (!visibleMap) then {call FUNC(mouseHandlerDown)};}];
_display displayAddEventHandler ["MouseButtonUp",   {if (!visibleMap) then {call FUNC(mouseHandlerUp)};}];
_display displayAddEventHandler ["MouseZChanged",   {if (!visibleMap) then {call FUNC(mouseWheelHandler)};}];
_display displayAddEventHandler ["MouseMoving",     {if (!visibleMap) then {call FUNC(userKeyHandler)};}];
_display displayAddEventHandler ["MouseHolding",    {if (!visibleMap) then {call FUNC(userKeyHandler)};}];
