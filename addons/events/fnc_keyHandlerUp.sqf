/* ----------------------------------------------------------------------------
Internal Function: CBA_events_fnc_keyHandlerUp

Description:
    Executes the key's handler

Author:
    Sickboy, commy2
---------------------------------------------------------------------------- */
// #define DEBUG_MODE_FULL
#include "script_component.hpp"
SCRIPT(keyHandlerUp);

params ["", "_inputKey"];

if (_inputKey isEqualTo 0) exitWith {};

// handle modifiers
switch (true) do {
    case (_inputKey in [DIK_LSHIFT, DIK_RSHIFT]): {
        GVAR(shift) = false;
    };
    case (_inputKey in [DIK_LCONTROL, DIK_RCONTROL]): {
        GVAR(control) = false;
    };
    case (_inputKey in [DIK_LMENU, DIK_RMENU]): {
        GVAR(alt) = false;
    };
};

private _removeHandlers = [];

{
    private _keybindParams = GVAR(keyHandlersUp) getVariable _x;

    _keybindParams params ["_keybind", "_keybindModifiers", "_code"];

    // Verify if the required modifier keys are present
    if (
        _inputKey isEqualTo _keybind
        || {(_keybindModifiers select 0 && {_inputKey in [DIK_LSHIFT, DIK_RSHIFT]})
        || {(_keybindModifiers select 1 && {_inputKey in [DIK_LCONTROL, DIK_RCONTROL]})
        || {(_keybindModifiers select 2 && {_inputKey in [DIK_LMENU, DIK_RMENU]})}}}
    ) then {
        private _params = + _this;
        _params pushBack + _keybindParams;
        _params pushBack _x;

        _params call _code;

        _removeHandlers pushBack _x;
    };
} forEach GVAR(keyDownActiveList);

GVAR(keyDownActiveList) = GVAR(keyDownActiveList) - _removeHandlers; 

false
