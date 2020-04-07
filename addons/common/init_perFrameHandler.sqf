//init_perFrameHandler.sqf
//#define DEBUG_MODE_FULL

#include "script_component.hpp"

GVAR(perFrameHandlerArray) = [];
GVAR(perFrameHandlersToRemove) = [];

GVAR(waitAndExecArray) = [];
GVAR(waitAndExecArrayIsSorted) = false;
GVAR(nextFrameNo) = diag_frameno + 1;
GVAR(nextFrameBufferA) = [];
GVAR(nextFrameBufferB) = [];
GVAR(waitUntilAndExecArray) = [];

GVAR(missionTimeSynchronized) = false;
GVAR(missionTimePrecise) = 0;
GVAR(missionTimeThousands) = 0;
CBA_missionTime = 0;
CBA_missionTimeStr = "0";

// per frame handler system
[QFUNC(onFrame), {
    SCRIPT(onFrame);
    private _tickTime = diag_tickTime;

    // Update CBA_missionTime when synchronized, time has started, and game is not paused.
    if ([GVAR(missionTimeSynchronized), time > 0, isGamePaused] isEqualTo [true, true, false]) then {
        GVAR(missionTimePrecise) = GVAR(missionTimePrecise) + diag_deltaTime * accTime;

        while {GVAR(missionTimePrecise) >= 1000} do {
            GVAR(missionTimePrecise) = GVAR(missionTimePrecise) - 1000;
            GVAR(missionTimeThousands) = GVAR(missionTimeThousands) + 1;
        };

        CBA_missionTimeStr = format [
            "%1%2",
            GVAR(missionTimeThousands) toFixed 0,
            (1000 + GVAR(missionTimePrecise)) toFixed 6 select [1],
        ];

        CBA_missionTime = parseNumber CBA_missionTimeStr;
    };

    // frame number does not match expected; can happen between pre and postInit, save-game load and on closing map
    // need to manually set nextFrameNo, so new items get added to buffer B and are not executed this frame
    if (diag_frameno != GVAR(nextFrameNo)) then {
        TRACE_2("frame mismatch",diag_frameno,GVAR(nextFrameNo));
        GVAR(nextFrameNo) = diag_frameno;
    };

    // Execute per frame handlers
    {
        _x params ["_function", "_delay", "_delta", "", "_args", "_handle"];

        if (diag_tickTime > _delta) then {
            _x set [2, _delta + _delay];
            [_args, _handle] call _function;
        };
    } forEach GVAR(perFrameHandlerArray);


    // Execute wait and execute functions
    // Sort the queue if necessary
    if (!GVAR(waitAndExecArrayIsSorted)) then {
        GVAR(waitAndExecArray) sort true;
        GVAR(waitAndExecArrayIsSorted) = true;
    };
    private _delete = false;
    {
        if (_x select 0 > CBA_missionTime) exitWith {};

        (_x select 2) call (_x select 1);

        // Mark the element for deletion so it's not executed ever again
        GVAR(waitAndExecArray) set [_forEachIndex, objNull];
        _delete = true;
    } forEach GVAR(waitAndExecArray);
    if (_delete) then {
        GVAR(waitAndExecArray) = GVAR(waitAndExecArray) - [objNull];
        _delete = false;
    };


    // Execute the exec next frame functions
    {
        (_x select 0) call (_x select 1);
    } forEach GVAR(nextFrameBufferA);
    // Swap double-buffer:
    GVAR(nextFrameBufferA) = GVAR(nextFrameBufferB);
    GVAR(nextFrameBufferB) = [];
    GVAR(nextFrameNo) = diag_frameno + 1;


    // Execute the waitUntilAndExec functions:
    {
        // if condition is satisfied call statement
        if ((_x select 2) call (_x select 0)) then {
            (_x select 2) call (_x select 1);

            // Mark the element for deletion so it's not executed ever again
            GVAR(waitUntilAndExecArray) set [_forEachIndex, objNull];
            _delete = true;
        };
    } forEach GVAR(waitUntilAndExecArray);
    if (_delete) then {
        GVAR(waitUntilAndExecArray) = GVAR(waitUntilAndExecArray) - [objNull];
    };
}] call CBA_fnc_compileFinal;

// increase CBA_missionTime variable every frame
if (isMultiplayer) then {
    // multiplayer - no accTime in MP
    if (isServer) then {
        // multiplayer server
        GVAR(missionTimeSynchronized) = true;

        addMissionEventHandler ["PlayerConnected", {
            (_this select 4) publicVariableClient "CBA_missionTime";
        }];
    } else {
        CBA_missionTime = -1;

        // multiplayer client
        0 spawn {
            isNil {
                private _fnc_init = {
                    CBA_missionTime = _this select 1;
                    GVAR(missionTimeSynchronized) = true;
                };

                "CBA_missionTime" addPublicVariableEventHandler _fnc_init;

                if (CBA_missionTime != -1) then {
                    WARNING_1("CBA_missionTime packet arrived prematurely. Installing update handler manually. Transferred value was %1.",CBA_missionTime);
                    [nil, CBA_missionTime] call _fnc_init;
                };
            };
        };
    };
} else {
    // single player
    GVAR(missionTimeSynchronized) = true;
};
