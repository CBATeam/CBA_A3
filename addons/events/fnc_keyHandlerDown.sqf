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

if (_inputKey == 0) exitWith {};

private _inputSettings = _this select [2,3];

private _handled = false; // If true, suppress the default handling of the key.
private _result = false;

{
    private _hash = GVAR(keyHandlersDown) getVariable _x;

    _hash params ["", "_settings", "_code", "_holdKey", "_holdDelay"];

    // Verify if the required modifier keys are present
    if !(
        !((_settings select 0) isEqualTo (_inputSettings select 0)) || {
        !((_settings select 1) isEqualTo (_inputSettings select 1)) || {
        !((_settings select 2) isEqualTo (_inputSettings select 2))}}
    ) then {
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

        if (_execute) then {
            if !(_holdKey) then {
                if (_xUp in GVAR(keyUpActiveList)) then {
                    _execute = false;
                } else {
                    GVAR(keyUpActiveList) pushBack _xUp;
                };
            };

            if (_execute) then {
                private _params = + _this;
                _params pushBack + _hash;
                _params pushBack _x;

                _result = _params call _code;
            };
        };

        if (_result isEqualTo true) exitWith {
            _handled = true;
        };
    };
} forEach (GVAR(keyDownStates) param [_inputKey, []]);

// To have a valid key up we first need to have a valid key down of the same combo!
// If we do, we add it to a list of pressed key up combos, then on key up we check that list to see if we have a valid key up.
{
    if !(_x in GVAR(keyDownActiveList)) then {
        private _hash = GVAR(keyHandlersUp) getVariable _x;

        _hash params ["", "_settings"];

        // Verify if the required modifier keys are present
        if !(
            !((_settings select 0) isEqualTo (_inputSettings select 0)) || {
            !((_settings select 1) isEqualTo (_inputSettings select 1)) || {
            !((_settings select 2) isEqualTo (_inputSettings select 2))}}
        ) then {
            GVAR(keyDownActiveList) pushBack _x;
        };
    };
} forEach (GVAR(keyUpStates) param [_inputKey, []]);

_handled
