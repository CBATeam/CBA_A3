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

if (_inputKey == 0) exitWith {};

private _blockedUpKeys = [];
private _removeHandlers = [];

{
    private _keybindParams = GVAR(keyHandlersUp) getVariable _x;

    _keybindParams params ["_keybind", "_keybindSettings", "_code"];

    // Verify if the required modifier keys are present
    if (_inputKey in [_keybind, DIK_LSHIFT, DIK_RSHIFT, DIK_LCONTROL, DIK_RCONTROL, DIK_LMENU, DIK_RMENU]) then {
        if !(_keybind in _blockedUpKeys) then {
            if (
                _inputKey == _keybind
                || {(_keybindSettings select 0 && {_inputKey in [DIK_LSHIFT, DIK_RSHIFT]})
                || {(_keybindSettings select 1 && {_inputKey in [DIK_LCONTROL, DIK_RCONTROL]})
                || {(_keybindSettings select 2 && {_inputKey in [DIK_LMENU, DIK_RMENU]})}}}
            ) then {
                private _params = + _this;
                _params pushBack + _keybindParams;
                _params pushBack _x;

                private _blockInput = _params call _code;

                if (_blockInput isEqualTo true) then {
                    _blockedUpKeys pushBack _keybind;
                };

                _removeHandlers pushBack _x;
            };
        } else {
            _removeHandlers pushBack _x;
        };
    };
} forEach GVAR(keyDownActiveList);

GVAR(keyDownActiveList) = GVAR(keyDownActiveList) - _removeHandlers; 

false
