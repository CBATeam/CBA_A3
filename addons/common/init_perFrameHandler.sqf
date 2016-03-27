//init_perFrameHandler.sqf
//#define DEBUG_MODE_FULL

#include "script_component.hpp"

GVAR(perFrameHandlerArray) = [];
GVAR(lastTickTime) = diag_tickTime;

GVAR(waitAndExecArray) = [];
GVAR(waitAndExecArrayIsSorted) = false;
GVAR(nextFrameNo) = diag_frameno;
GVAR(nextFrameBufferA) = [];
GVAR(nextFrameBufferB) = [];
GVAR(waitUntilAndExecArray) = [];

PREP(perFrameEngine);

// per frame handler system
FUNC(onFrame) = {
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

};

if (isNil {canSuspend}) then {
    // pre 1.58
    ["CBA_PFH", "onEachFrame", FUNC(onFrame)] call BIS_fnc_addStackedEventHandler;
} else {
    // 1.58 and later
    addMissionEventHandler ["EachFrame", FUNC(onFrame)];
};

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
        FUNC(missionTimePFH) = {
            if (time != GVAR(lastTime)) then {
                CBA_missionTime = CBA_missionTime + (_tickTime - GVAR(lastTickTime));
                GVAR(lastTime) = time; // used to detect paused game
            };

            GVAR(lastTickTime) = _tickTime;
        };

        ["CBA_SynchMissionTime", "onPlayerConnected", {
            _owner publicVariableClient "CBA_missionTime";
        }] call BIS_fnc_addStackedEventHandler;
    } else {
        CBA_missionTime = -1;

        // multiplayer client
        0 spawn {
            "CBA_missionTime" addPublicVariableEventHandler {
                CBA_missionTime = _this select 1;

                GVAR(lastTickTime) = diag_tickTime; // prevent time skip on clients

                FUNC(missionTimePFH) = {
                    if (time != GVAR(lastTime)) then {
                        CBA_missionTime = CBA_missionTime + (_tickTime - GVAR(lastTickTime));
                        GVAR(lastTime) = time; // used to detect paused game
                    };

                    GVAR(lastTickTime) = _tickTime;
                };
            };
        };
    };
} else {
    // single player
    FUNC(missionTimePFH) = {
        if (time != GVAR(lastTime)) then {
            CBA_missionTime = CBA_missionTime + (_tickTime - GVAR(lastTickTime)) * accTime;
            GVAR(lastTime) = time; // used to detect paused game
        };

        GVAR(lastTickTime) = _tickTime;
    };
};
