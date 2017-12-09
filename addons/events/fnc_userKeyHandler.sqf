/* ----------------------------------------------------------------------------
Internal Function: CBA_events_fnc_userKeyHandler

Description:
    Check state of user keys if enabled

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params ["_display"];

private _userKeyStates = [
    inputAction "User1" > 0.1, inputAction "User2" > 0.1, inputAction "User3" > 0.1, inputAction "User4" > 0.1, inputAction "User5" > 0.1,
    inputAction "User6" > 0.1, inputAction "User7" > 0.1, inputAction "User8" > 0.1, inputAction "User9" > 0.1, inputAction "User10" > 0.1,
    inputAction "User11" > 0.1, inputAction "User12" > 0.1, inputAction "User13" > 0.1, inputAction "User14" > 0.1, inputAction "User15" > 0.1,
    inputAction "User16" > 0.1, inputAction "User17" > 0.1, inputAction "User18" > 0.1, inputAction "User19" > 0.1, inputAction "User20" > 0.1
];

if !(_userKeyStates isEqualTo GVAR(userKeyStates)) then {
    {
        if !(_x isEqualTo (GVAR(userKeyStates) select _forEachIndex)) then {
            GVAR(userKeyStates) set [_forEachIndex, _x];
            [_display, 0xFA + _forEachIndex, false, false, false] call ([FUNC(keyHandlerUp), FUNC(keyHandlerDown)] select _x);
        };
    } forEach _userKeyStates;
};
