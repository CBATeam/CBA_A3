/* ----------------------------------------------------------------------------
Function: CBA_fnc_targetEvent

Description:
    Raises a CBA event on all machines where this object or at least one of these objects are local.

Parameters:
    _eventName - Type of event to publish. <STRING>
    _params    - Parameters to pass to the event handlers. <ANY>
    _targets   - Where to execute events. <OBJECT, GROUP, ARRAY>

Returns:
    None

Examples:
    (begin example)
        ["test", ["target"], cursorTarget] call CBA_fnc_targetEvent;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(targetEvent);

params [["_eventName", "", [""]], ["_params", []], ["_targets", objNull, [objNull, grpNull, []]]];

if !(_targets isEqualType []) then {
    _targets = [_targets];
};

#ifndef LINUX_BUILD
    private _remoteTargets = _targets select {!local GETOBJ(_x)};
#else
    private _remoteTargets = [_targets, {!local GETOBJ(_x)}] call BIS_fnc_conditionalSelect;
#endif

// do local events if there is a local target
if (count _targets > count _remoteTargets) then {
    CALL_EVENT(_params,_eventName);
};

// no networking when no targets are remote
if (_remoteTargets isEqualTo []) exitWith {};

if (isServer) then {
    private _sentOwners = [];

    {
        private _owner = owner GETOBJ(_x);

        // only send event once each time this function is called, even if multipe targets are local to the same machine
        if !(_owner in _sentOwners) then {
            _sentOwners pushBack _owner;
            SEND_EVENT_TO_CLIENT(_params,_eventName,_owner);
        };
    } forEach _remoteTargets;
} else {
    // only server knows object owners. let server handle the event.
    SEND_TEVENT_TO_SERVER(_params,_eventName,_remoteTargets);
};

nil
