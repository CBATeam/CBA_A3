// Any registered functions used in the PreINIT phase must use the uiNamespace copies of the variable.
// So uiNamespace getVariable "CBA_fnc_hashCreate" instead of just CBA_fnc_hashCreate -VM
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
/*
    Custom events
*/
LOG(MSG_INIT);
if (isNil "CBA_fnc_localEvent") then { diag_log "CBA_fnc_localEvent is nil!!";};
// Initialisation required by CBA events.
CBA_eventHandlers = "Logic" createVehicleLocal [0, 0];
CBA_eventHandlersLocal = "Logic" createVehicleLocal [0, 0];
CBA_EVENTS_DONE = false;

PREP(NetRunEventTOR);

GVAR(event_holderToR) = "Logic" createVehicleLocal [0, 0];

"CBA_ntor" addPublicVariableEventHandler {
    (_this select 1) call FUNC(NetRunEventTOR);
};

if (isServer) then {
    GVAR(event_holderCTS) = "Logic" createVehicleLocal [0, 0];

    PREP(NetRunEventCTS);

    "CBA_ncts" addPublicVariableEventHandler {
        (_this select 1) call FUNC(NetRunEventCTS);
    };
};

// TODO: Verify if this code is okay; there can be no player object ready at PreInit, thus it's not very useful
if (isServer || {alive player}) then {
    // We want all events, as soon as they start arriving.
    "CBA_e" addPublicVariableEventHandler { (_this select 1) call (uiNamespace getVariable "CBA_fnc_localEvent") };
    "CBA_l" addPublicVariableEventHandler { (_this select 1) call FUNC(remoteLocalEvent) };
} else {
    // Ignore the last event that was sent out before we joined.
    SLX_XEH_STR spawn {
        waitUntil { alive player };
        "CBA_e" addPublicVariableEventHandler { (_this select 1) call (uiNamespace getVariable "CBA_fnc_localEvent") };
        "CBA_l" addPublicVariableEventHandler { (_this select 1) call FUNC(remoteLocalEvent) };
    };
};

// Display Eventhandlers - Abstraction layer
GVAR(handler_hash) = [[], ""] call (uiNamespace getVariable "CBA_fnc_hashCreate");

// Display Eventhandlers - Higher level API specially for keyDown/Up and Action events
/*
    Example:
    class CfgSettings { class CBA { class Keys { class sys_attachments { cqb = 33 }; }; }; };

    - Script (in sys_attachments addon (it has COMPONENT defined as sys_attachments)):
    [QUOTE(COMPONENT), "cqb", { _this call GVAR(keyPressed) }] call cba_fnc_AddKeyHandlerFromConfig;
*/
private ["_arUp", "_arDown"];
GVAR(keyhandler_hash) = [[], []] call (uiNamespace getVariable "CBA_fnc_hashCreate");
GVAR(keyhandlers_down) = [[], []] call (uiNamespace getVariable "CBA_fnc_hashCreate");
GVAR(keyhandlers_up) = [[], []] call (uiNamespace getVariable "CBA_fnc_hashCreate");
_arUp = [GVAR(keyhandler_hash), "keyup"] call (uiNamespace getVariable "CBA_fnc_hashGet");
_arDown = [GVAR(keyhandler_hash), "keydown"] call (uiNamespace getVariable "CBA_fnc_hashGet");
for "_i" from 0 to 250 do {
    _arUp set [_i, []];
    _arDown set [_i, []];
};

// Due to limitation, have to actually set the first time
[GVAR(keyhandler_hash), "keyup", _arUp] call (uiNamespace getVariable "CBA_fnc_hashSet");
[GVAR(keyhandler_hash), "keydown", _arDown] call (uiNamespace getVariable "CBA_fnc_hashSet");

GVAR(keyUpDownList) = [];
GVAR(keyDownList) = [];

GVAR(keyHoldTimers) = [[], ""] call (uiNamespace getVariable "CBA_fnc_hashCreate");

PREP(keyHandler);
PREP(remoteLocalEvent);

FUNC(handleKeyDownUp) = {
    private ["_hash"];
    _hash = _this select ((count _this)-1);
    if(_hash in GVAR(keyDownList)) then {
        GVAR(keyDownList) = GVAR(keyDownList) - [_hash];
    };
    if(([GVAR(keyHoldTimers), _hash] call cba_fnc_hashHasKey)) then {
        [GVAR(keyHoldTimers), _hash] call cba_fnc_hashRem;
    };
    false
};

CBA_fnc_remoteLocalEvent = FUNC(remoteLocalEvent); // BWC

// Awaits XEH PostInit sequence completed
CBA_MISSION_START = false;
objNull spawn {
    waitUntil {time > 0 && {(SLX_XEH_MACHINE select 8)}};
    CBA_MISSION_START = true;
    TRACE_1("CBA_MISSION_START",nil);
};

nil;
