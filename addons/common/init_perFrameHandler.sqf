//init_perFrameHandler.sqf
// #define DEBUG_MODE_FULL

#include "script_component.hpp"

#define _DELAY_MONITOR_THRESHOLD 1
#define _DELAY_MONITOR_SLEEP	 0.5

PREP(perFrameEngine);

FUNC(blaHandler) = {
	// All functions get _logic as _this param. Params inside _logic getVariable "params";
	private ["_logic"];
	PARAMS_1(_params);
	_logic = _params select 0;

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
	PARAMS_1(_function);
	DEFAULT_PARAM(1,_params,[]);
	DEFAULT_PARAM(2,_delay,0);
	DEFAULT_PARAM(3,_start,{});
	DEFAULT_PARAM(4,_end,{});
	DEFAULT_PARAM(5,_runCondition,{true});
	DEFAULT_PARAM(6,_exitCondition,{false});
	DEFAULT_PARAM(7,_private,[]);

	// Store vars on Logic
	_logic = "HeliHEmpty" createVehicleLocal [0, 0, 0];
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
		_serialize set [count _serialize, compile format["_logic setVariable ['%1', if (isNil '%1') then { nil } else { %1 }]", _x]];
	} forEach (_logic getVariable 'private');

	_deSerialize = [];
	{
		_deSerialize set [count _deSerialize, compile format["%1 = _logic getVariable '%1'", _x]];
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
	private["_func", "_delay", "_delta", "_handlerData"];
	while { true } do {
		// check to see if the frame-render hasn't run in a second.
		// if it hasnt, pick it up for now
		if((diag_tickTime - GVAR(lastFrameRender)) > _DELAY_MONITOR_THRESHOLD) then {
			{
				_handlerData = _x;
				if !(isNil "_handlerData") then {
					if (IS_ARRAY(_handlerData)) then {
						_func = _handlerData select 0;
						_delay = _handlerData select 1;
						_delta = _handlerData select 2;
						if(diag_tickTime > _delta) then {
							[(_handlerData select 4), (_handlerData select 5)] call _func;
							_delta = diag_tickTime + _delay;
							//TRACE_1("data", _data);
							_handlerData set [2, _delta];
						};
					};
				};
			} forEach GVAR(perFrameHandlerArray);
		} else {
			sleep _DELAY_MONITOR_SLEEP;
		};
	};
};

FUNC(onFrame) = {
	private["_func", "_delay", "_delta", "_handlerData"];
	GVAR(lastFrameRender) = diag_tickTime;
	// if(GVAR(lastCount) > (GVAR(fpsCount)-1)) then {
		// hint "FUCK UP IN SEQUENCE!";
	// };
	// player sideChat format["fps: %1 %2 %3", (GVAR(fpsCount)/diag_fps), diag_fps, GVAR(fpsCount)];
	// GVAR(lastCount) = GVAR(fpsCount);
	// GVAR(fpsCount) = GVAR(fpsCount) + 1;
	// player sideChat format["c: %1", GVAR(perFrameHandlerArray)];
	{
		_handlerData = _x;
		if !(isNil "_handlerData") then {
			if (IS_ARRAY(_handlerData)) then {
				_func = _handlerData select 0;
				_delay = _handlerData select 1;
				_delta = _handlerData select 2;
				if(diag_tickTime > _delta) then {
					[(_handlerData select 4), (_handlerData select 5)] call _func;
					_delta = diag_tickTime + _delay;
					//TRACE_1("data", _data);
					_handlerData set [2, _delta];
				};
			};
		};
	} forEach GVAR(perFrameHandlerArray);
};
GVAR(perFrameHandlerArray) = [];
GVAR(fpsCount) = 0;
GVAR(lastCount) = -1;
GVAR(lastFrameRender) = 0;
