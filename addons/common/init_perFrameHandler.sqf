//init_perFrameHandler.sqf
//#define DEBUG_MODE_FULL

#include "script_component.hpp"

#define DELAY_MONITOR_THRESHOLD 1 // Frames

GVAR(perFrameHandlerArray) = [];
GVAR(lastTickTime) = diag_tickTime;

GVAR(waitAndExecArray) = [];
GVAR(waitAndExecArrayIsSorted) = false;
GVAR(nextFrameNo) = diag_frameno + 1;
// PostInit can be 2 frames after preInit, need to manually set nextFrameNo, so new items get added to buffer B while processing A for the first time:
GVAR(nextFrameBufferA) = [[[], {GVAR(nextFrameNo) = diag_frameno;}]];
GVAR(nextFrameBufferB) = [];
GVAR(waitUntilAndExecArray) = [];

// per frame handler system
[QFUNC(onFrame), {
    private _tickTime = diag_tickTime;
    call FUNC(missionTimePFH);

    // Execute per frame handlers
    {
        _x params ["_function", "_delay", "_delta", "", "_args", "_handle"];

        if (diag_tickTime > _delta) then {
            _x set [2, _delta + _delay];
            [_args, _handle] call _function;
            false
        };
    } count GVAR(perFrameHandlerArray);


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
    };


    // Execute the exec next frame functions
    {
        (_x select 0) call (_x select 1);
        false
    } count GVAR(nextFrameBufferA);
    // Swap double-buffer:
    GVAR(nextFrameBufferA) = GVAR(nextFrameBufferB);
    GVAR(nextFrameBufferB) = [];
    GVAR(nextFrameNo) = diag_frameno + 1;


    // Execute the waitUntilAndExec functions:
    _delete = false;
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

// fix for save games. subtract last tickTime from ETA of all PFHs after mission was loaded
addMissionEventHandler ["Loaded", {
    private _tickTime = diag_tickTime;

    {
        _x set [2, (_x select 2) - GVAR(lastTickTime) + _tickTime];
    } forEach GVAR(perFrameHandlerArray);

    GVAR(lastTickTime) = _tickTime;
}];

CBA_missionTime = 0;
GVAR(lastTime) = time;

// increase CBA_missionTime variable every frame
if (isMultiplayer) then {
    // multiplayer - no accTime in MP
    if (isServer) then {
        // multiplayer server
        [QFUNC(missionTimePFH), {
            if (time != GVAR(lastTime)) then {
                CBA_missionTime = CBA_missionTime + (_tickTime - GVAR(lastTickTime));
                GVAR(lastTime) = time; // used to detect paused game
            };

            GVAR(lastTickTime) = _tickTime;
        }] call CBA_fnc_compileFinal;

        addMissionEventHandler ["PlayerConnected", {
            (_this select 4) publicVariableClient "CBA_missionTime";
        }];
    } else {
        CBA_missionTime = -1;

        // multiplayer client
        0 spawn {
            "CBA_missionTime" addPublicVariableEventHandler {
                CBA_missionTime = _this select 1;

                GVAR(lastTickTime) = diag_tickTime; // prevent time skip on clients

                [QFUNC(missionTimePFH), {
                    if (time != GVAR(lastTime)) then {
                        CBA_missionTime = CBA_missionTime + (_tickTime - GVAR(lastTickTime));
                        GVAR(lastTime) = time; // used to detect paused game
                    };

                    GVAR(lastTickTime) = _tickTime;
                }] call CBA_fnc_compileFinal;
            };
        };
    };
} else {
    // single player
    [QFUNC(missionTimePFH), {
        if (time != GVAR(lastTime)) then {
            CBA_missionTime = CBA_missionTime + (_tickTime - GVAR(lastTickTime)) * accTime;
            GVAR(lastTime) = time; // used to detect paused game
        };

        GVAR(lastTickTime) = _tickTime;
    }] call CBA_fnc_compileFinal;
};
