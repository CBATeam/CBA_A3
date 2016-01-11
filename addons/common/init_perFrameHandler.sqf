//init_perFrameHandler.sqf
// #define DEBUG_MODE_FULL

#include "script_component.hpp"

#define DELAY_MONITOR_THRESHOLD 1 // Frames

GVAR(perFrameHandlerArray) = [];
GVAR(fpsCount) = 0;
GVAR(lastCount) = -1;
GVAR(lastFrameRender) = 0;

PREP(perFrameEngine);

FUNC(blaHandler) = {
    // All functions get _logic as _this param. Params inside _logic getVariable "params";
    (_this select 0) params ["_logic"];

    if (isNil "_logic") exitWith {
        // Remove handler
        [_logic getVariable "handle"] call CBA_fnc_removePerFrameHandler;
    };

    if (isNull _logic) exitWith {
        // Remove handler
        [_logic getVariable "handle"] call CBA_fnc_removePerFrameHandler;
    };

    // Deserialize
    private (_logic getVariable "private");
    { call _x } forEach (_logic getVariable "deserialize");

    // Check exit condition - Exit if false
    if (_logic call (_logic getVariable "exit_condition")) exitWith {
        TRACE_1("Exit Condition", _logic);
        // Execute End code
        _logic call (_logic getVariable "end");
        // Remove handler
        [_logic getVariable "handle"] call CBA_fnc_removePerFrameHandler;

        // Bai Bai logic
        deleteVehicle _logic;
    };

    // Check Run Condition - Exit until next loop if false
    if !(_logic call (_logic getVariable "run_condition")) exitWith {};
    // TRACE_1("Executing",_logic);
    // Execute code
    _logic call (_logic getVariable "run");

    // Serialize
    { call _x } forEach (_logic getVariable "serialize");
};


FUNC(addPerFrameHandlerLogic) = {
    params ["_function", ["_params", [], [[]]], ["_delay", 0, [0]], ["_start", {}, [{}]], ["_end", {}, [{}]], ["_runCondition", {true}, [{true}]], ["_exitCondition",{false},[{false}]], ["_private", [],[[]]]];

    // Store vars on Logic
    _logic = SLX_XEH_DUMMY createVehicleLocal [0, 0, 0];
    _logic setVariable ["start", _start];
    _logic setVariable ["run_condition", _runCondition];
    _logic setVariable ["exit_condition", _exitCondition];
    _logic setVariable ["run", _function];
    _logic setVariable ["end", _end];
    _logic setVariable ["params", _params];
    _logic setVariable ["private", _private];

    // Prepare Serialization and Deserialization code
    _serialize = [];
    {
        _serialize pushBack (compile format["_logic setVariable ['%1', if (isNil '%1') then { nil } else { %1 }]", _x]);
    } forEach (_logic getVariable 'private');

    _deSerialize = [];
    {
        _deSerialize pushBack (compile format["%1 = _logic getVariable '%1'", _x]);
    } forEach (_logic getVariable 'private');

    _logic setVariable ["serialize", _serialize];
    _logic setVariable ["deserialize", _deserialize];

    // Run start code
    private (_logic getVariable "private");
    _params call (_logic getVariable "start");

    // Serialize
    { call _x } forEach (_logic getVariable "serialize");

    // Add handler
    _handle = [FUNC(blaHandler), _delay, [_logic]] call CBA_fnc_addPerFrameHandler;
    _logic setVariable ["handle", _handle];

    _logic; // Returns logic because you can get the handle from it, and much more
};

// We monitor all our frame render's in this loop. If the frames stop rendering, that means they alt+tabbed
// and we still want to at least TRY and run them until the onDraw kicks up again
FUNC(monitorFrameRender) = {
    private "_pfhIdd";
    disableSerialization;
    TRACE_1("Monitor frame render loop",nil);
    // Check if the PFH died for some reason.
    if (isNil "BIS_fnc_addStackedEventHandler") then {
        _pfhIdd = uiNamespace getVariable "CBA_PFHIDD";
        if (isNil "_pfhIdd") then {
            7771 cutRsc ["CBA_FrameHandlerTitle", "PLAIN"];
        } else {
            if (isNull _pfhIdd) then {
                7771 cutRsc ["CBA_FrameHandlerTitle", "PLAIN"];
            };
        };
    };

    // check to see if the frame-render hasn't run in > 1 frame.
    // if it hasnt, pick it up for now
    if ( abs(diag_frameNo - GVAR(lastFrameRender)) > DELAY_MONITOR_THRESHOLD) then {
        TRACE_1("Executing frameRender",nil);
        if (isNil "BIS_fnc_addStackedEventHandler") then {
            call FUNC(onFrame);
        } else {
            // Restore the onEachFrame handler
            ["CBA_PFH", "onEachFrame", QUOTE(FUNC(onFrame))] call BIS_fnc_addStackedEventHandler;
        };
    };
};

FUNC(onFrame) = {
    TRACE_1("Executing onFrame",nil);
    GVAR(lastFrameRender) = diag_frameNo;

    {
        _x params ["_function", "_delay", "_delta", "", "_args", "_handle"];

        if (diag_tickTime > _delta) then {
            _x set [2, _delta + _delay];
            [_args, _handle] call _function;
            false
        };
    } count GVAR(perFrameHandlerArray);
};
