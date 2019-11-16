#include "script_component.hpp"

ADDON = false;

//ClientOwner command is unreliable in saved games
//CBA_clientID will hold the correct value for the client's owner (needed for publicVariableClient and remoteExec)
CBA_clientID = -1; //Will be -1 until real value recieved from server

// Initialisation required by CBA events.
GVAR(eventNamespace) = call CBA_fnc_createNamespace;
GVAR(eventHashes) = call CBA_fnc_createNamespace;

if (isServer) then {
    GVAR(eventNamespaceJIP) = true call CBA_fnc_createNamespace;
    publicVariable QGVAR(eventNamespaceJIP);

    [QGVAR(removeGlobalEventJIP), CBA_fnc_removeGlobalEventJIP] call CBA_fnc_addEventHandler;
};

// can't add at preInit
0 spawn {
    EVENT_PVAR_STR addPublicVariableEventHandler {(_this select 1) call CBA_fnc_localEvent};

    if (isServer) then {
        TEVENT_PVAR_STR addPublicVariableEventHandler {(_this select 1) call CBA_fnc_targetEvent};
        TUEVENT_PVAR_STR addPublicVariableEventHandler {(_this select 1) call CBA_fnc_turretEvent};
    };
};

#include "backwards_comp.sqf"
#include "initSettings.sqf"

ADDON = true;

if (!hasInterface) exitWith {};

GVAR(skipCheckingUserActions) = true;

// Display Event Handlers
// Pressing "Restart" in the editor starts a completely new mission (preInit etc. are executed). The main display is never deleted though!
// This would cause douplicate display events to be added, because the old ones carry over while the new ones are added again.
// If we detect an already existing main display we remove all display events that were previously defined.
if (!isNull (uiNamespace getVariable ["CBA_missionDisplay", displayNull])) then {
    GVAR(handlerHash) = uiNamespace getVariable QGVAR(handlerHash);
    [GVAR(handlerHash), {
        {
            (uiNamespace getVariable "CBA_missionDisplay") displayRemoveEventHandler [_key, _x param [0, -1]];
        } forEach _value;
    }] call CBA_fnc_hashEachPair;

    // to carry the hash over into a restarted game, we store the hashes array reference in the mission display namespace.
    GVAR(handlerHash) = [[], []] call CBA_fnc_hashCreate;
    uiNamespace setVariable [QGVAR(handlerHash), GVAR(handlerHash)];
} else {
    GVAR(handlerHash) = [[], []] call CBA_fnc_hashCreate;
};

// Key Handlers
PREP(keyHandler);
PREP(keyHandlerDown);
PREP(keyHandlerUp);
PREP(mouseHandlerDown);
PREP(mouseHandlerUp);
PREP(mouseWheelHandler);
PREP(userKeyHandler);

private _keyHandlers = [];
_keyHandlers resize 270;

GVAR(keyDownStates) = _keyHandlers apply {[]};
GVAR(keyUpStates) = + GVAR(keyDownStates);

GVAR(keyHandlersDown) = call CBA_fnc_createNamespace;
GVAR(keyHandlersUp) = call CBA_fnc_createNamespace;

GVAR(keyDownActiveList) = [];
GVAR(keyUpActiveList) = [];

GVAR(keyHoldTimers) = call CBA_fnc_createNamespace;

[QFUNC(handleKeyDownUp), {
    private _xUp = _this select (count _this - 1);

    GVAR(keyUpActiveList) deleteAt (GVAR(keyUpActiveList) find _xUp);
    GVAR(keyHoldTimers) setVariable [_xUp, nil];

    false
}] call CBA_fnc_compileFinal;

GVAR(shift) = false;
GVAR(control) = false;
GVAR(alt) = false;

private _states = [];
_states resize 20;
GVAR(userKeyStates) = _states apply {false};
