//init_perFrameHandler.sqf
//#define DEBUG_MODE_FULL

#include "script_component.hpp"

GVAR(perFrameHandlerArray) = [];
GVAR(perFrameHandlersToRemove) = [];
GVAR(lastTickTime) = diag_tickTime;

GVAR(waitAndExecArray) = [];
GVAR(waitAndExecArrayIsSorted) = false;
GVAR(nextFrameNo) = diag_frameno + 1;
GVAR(nextFrameBufferA) = [];
GVAR(nextFrameBufferB) = [];
GVAR(waitUntilAndExecArray) = [];

// per frame handler system
[QFUNC(onFrame), {
    SCRIPT(onFrame);
    private _tickTime = diag_tickTime;
    call FUNC(missionTimePFH);

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
        private _timeDiff = [_x select [0, 3], CBA_missionTimeTriple];
        _timeDiff sort true;
        if (_timeDiff#0 isEqualTo CBA_missionTimeTriple) exitWith {};

        (_x select 4) call (_x select 3);

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

// fix for save games. subtract last tickTime from ETA of all PFHs after mission was loaded
addMissionEventHandler ["Loaded", {
    private _tickTime = diag_tickTime;

    {
        _x set [2, (_x select 2) - GVAR(lastTickTime) + _tickTime];
    } forEach GVAR(perFrameHandlerArray);

    GVAR(lastTickTime) = _tickTime;
}];

CBA_missionTimeTriple = [0, 0, 0]; // [999,999,999.99] = 999999999.99
GVAR(lastTime) = time;

// increase CBA_missionTimeTriple variable every frame
if (isMultiplayer) then {
    // multiplayer - no accTime in MP
    if (isServer) then {
        // multiplayer server
        [QFUNC(missionTimePFH), {
            SCRIPT(missionTimePFH_server);
            if (time != GVAR(lastTime)) then {
                CBA_missionTimeTriple = CBA_missionTimeTriple vectorAdd [0, 0, _tickTime - GVAR(lastTickTime)];
                if (selectMax CBA_missionTimeTriple > 1e3) then {
                    private _limitReach = CBA_missionTimeTriple findIf {_x > 1e3};
                    private _diff = [0, 0, 0];
                    _diff set [_limitReach, -1e3];
                    _diff set [_limitReach - 1, 1];
                    CBA_missionTimeTriple = CBA_missionTimeTriple vectorAdd _diff;
                };
                CBA_missionTime = CBA_missionTimeTriple vectorDotProduct [1e6 , 1e3, 1];
                GVAR(lastTime) = time; // used to detect paused game
            };

            GVAR(lastTickTime) = _tickTime;
        }] call CBA_fnc_compileFinal;

        addMissionEventHandler ["PlayerConnected", {
            (_this select 4) publicVariableClient "CBA_missionTimeTriple";
        }];
    } else {
        CBA_missionTimeTriple = [];

        // multiplayer client
        0 spawn {
            isNil {
                private _fnc_init = {
                    CBA_missionTimeTriple = _this select 1;

                    GVAR(lastTickTime) = diag_tickTime; // prevent time skip on clients

                    [QFUNC(missionTimePFH), {
                        SCRIPT(missionTimePFH_client);
                        if (time != GVAR(lastTime)) then {
                            CBA_missionTimeTriple = CBA_missionTimeTriple vectorAdd [0, 0, _tickTime - GVAR(lastTickTime)];
                            if (selectMax CBA_missionTimeTriple > 1e3) then {
                                private _limitReach = CBA_missionTimeTriple findIf {_x > 1e3};
                                private _diff = [0, 0, 0];
                                _diff set [_limitReach, -1e3];
                                _diff set [_limitReach - 1, 1];
                                CBA_missionTimeTriple = CBA_missionTimeTriple vectorAdd _diff;
                            };
                            CBA_missionTime = CBA_missionTimeTriple vectorDotProduct [1e6 , 1e3, 1];
                            GVAR(lastTime) = time; // used to detect paused game
                        };

                        GVAR(lastTickTime) = _tickTime;
                    }] call CBA_fnc_compileFinal;

                };

                "CBA_missionTimeTriple" addPublicVariableEventHandler _fnc_init;

                if !(CBA_missionTimeTriple isEqualTo []) then {
                    WARNING_1("CBA_missionTimeTriple packet arrived prematurely. Installing update handler manually. Transferred value was %1.",CBA_missionTimeTriple);
                    [nil, CBA_missionTimeTriple] call _fnc_init;
                };
            };
        };
    };
} else {
    // single player
    [QFUNC(missionTimePFH), {
        SCRIPT(missionTimePFH_sp);
        if (time != GVAR(lastTime)) then {
            CBA_missionTimeTriple = CBA_missionTimeTriple vectorAdd [0, 0, (_tickTime - GVAR(lastTickTime)) * accTime];
            if (selectMax CBA_missionTimeTriple > 1e3) then {
                private _limitReach = CBA_missionTimeTriple findIf {_x > 1e3};
                private _diff = [0, 0, 0];
                _diff set [_limitReach, -1e3];
                _diff set [_limitReach - 1, 1];
                CBA_missionTimeTriple = CBA_missionTimeTriple vectorAdd _diff;
            };
            CBA_missionTime = CBA_missionTimeTriple vectorDotProduct [1e6 , 1e3, 1];
            GVAR(lastTime) = time; // used to detect paused game
        };

        GVAR(lastTickTime) = _tickTime;
    }] call CBA_fnc_compileFinal;
};
