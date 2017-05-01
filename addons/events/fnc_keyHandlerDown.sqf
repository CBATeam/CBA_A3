/* ----------------------------------------------------------------------------
Internal Function: CBA_events_fnc_keyHandlerDown

Description:
    Executes the key's handler

Author:
    Sickboy, commy2
---------------------------------------------------------------------------- */
// #define DEBUG_MODE_FULL
#include "script_component.hpp"
SCRIPT(keyHandlerDown);

params ["", "_inputKey"];

if (_inputKey isEqualTo 0) exitWith {};

// handle modifiers
switch (true) do {
    case (_inputKey in [DIK_LSHIFT, DIK_RSHIFT]): {
        GVAR(shift) = true;
    };
    case (_inputKey in [DIK_LCONTROL, DIK_RCONTROL]): {
        GVAR(control) = true;
    };
    case (_inputKey in [DIK_LMENU, DIK_RMENU]): {
        GVAR(alt) = true;
    };
};

if !(_this select 2) then {
    GVAR(shift) = false;
};

if !(_this select 3) then {
    GVAR(control) = false;
};

if !(_this select 4) then {
    GVAR(alt) = false;
};

private _inputModifiers = [GVAR(shift), GVAR(control), GVAR(alt)];

private _blockInput = false;

{
    private _keybindParams = GVAR(keyHandlersDown) getVariable _x;

    _keybindParams params ["", "_keybindModifiers", "_code", "_allowHold", "_holdDelay"];

    // Verify if the required modifier keys are present
    if (_keybindModifiers isEqualTo _inputModifiers) then {
        private _xUp = _x + "_cbadefaultuphandler";
        private _execute = true;
        private _holdTime = 0;

        if (_holdDelay > 0) then {
            _holdTime = GVAR(keyHoldTimers) getVariable _xUp;

            if (isNil "_holdTime") then {
                _holdTime = diag_tickTime + _holdDelay;
                GVAR(keyHoldTimers) setVariable [_xUp, _holdTime];
            };

            if (diag_tickTime < _holdTime) then {
                _execute = false;
            };
        };

        // check if either holding down a key is enabled or if the key wasn't already held down
        if (_execute && {_allowHold || {GVAR(keyUpActiveList) pushBackUnique _xUp != -1}}) then {
            private _params = + _this;
            _params pushBack + _keybindParams;
            _params pushBack _x;

            _blockInput = [_params call _code] param [0, false] || {_blockInput};
        };
    };
} forEach (GVAR(keyDownStates) param [_inputKey, []]);

// To have a valid key up we first need to have a valid key down of the same combo!
// If we do, we add it to a list of pressed key up combos, then on key up we check that list to see if we have a valid key up.
{
    private _keybindParams = GVAR(keyHandlersUp) getVariable _x;

    _keybindParams params ["", "_keybindModifiers"];

    // Verify if the required modifier keys are present
    if (_keybindModifiers isEqualTo _inputModifiers) then {
        GVAR(keyDownActiveList) pushBackUnique _x;
    };
} forEach (GVAR(keyUpStates) param [_inputKey, []]);

_blockInput
