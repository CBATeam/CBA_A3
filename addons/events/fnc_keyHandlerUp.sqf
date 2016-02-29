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

private _ignoredUpKeys = [];
private _removeHandlers = [];

{
    private _hash = GVAR(keyHandlersUp) getVariable _x;

    _hash params ["_key", "_settings", "_code"];

    // Verify if the required modifier keys are present
    if (_inputKey in [_key, DIK_LSHIFT, DIK_RSHIFT, DIK_LCONTROL, DIK_RCONTROL, DIK_LMENU, DIK_RMENU]) then {
        if !(_key in _ignoredUpKeys) then {
            if (
                _inputKey == _key
                || {(_settings select 0 && {_inputKey in [DIK_LSHIFT, DIK_RSHIFT]})
                || {(_settings select 1 && {_inputKey in [DIK_LCONTROL, DIK_RCONTROL]})
                || {(_settings select 2 && {_inputKey in [DIK_LMENU, DIK_RMENU]})}}}
            ) then {
                private _params = + _this;
                _params pushBack + _hash;
                _params pushBack _x;

                private _result = _params call _code;

                if (_result isEqualTo true) then {
                    _ignoredUpKeys pushBack _key
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
