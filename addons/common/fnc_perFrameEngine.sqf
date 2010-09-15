/* ----------------------------------------------------------------------------
Internal Function: CBA_events_fnc_perFrameEngine

THIS FUNCTION IS PRIVATE AND NOT FOR USER EXECUTION!

This file creates two functions, one that executes every frame and is 
added to the map control, and the other which spawns up and monitors
for a stoppage of the on frame handler (because alt-tabbing stops its
execution).
---------------------------------------------------------------------------- */

#include "script_component.hpp"

#define _DELAY_MONITOR_THRESHOLD 1
#define _DELAY_MONITOR_SLEEP	 0.5

// We monitor all our frame render's in this loop. If the frames stop rendering, that means they alt+tabbed
// and we still want to at least TRY and run them until the onDraw kicks up again
FUNC(_monitorFrameRender) = {
	private["_func", "_delay", "_delta", "_handlerData"];
	while { true } do {
		// check to see if the frame-render hasn't run in a second. 
		// if it hasnt, pick it up for now
		if((diag_tickTime - GVAR(lastFrameRender)) > _DELAY_MONITOR_THRESHOLD) then {
			{	
				_handlerData = _x;
				if(!(isNil "_handlerData") && IS_ARRAY(_handlerData)) then {
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
			} forEach GVAR(perFrameHandlerArray);
		} else {
			sleep _DELAY_MONITOR_SLEEP;
		};
	};
};

FUNC(_onFrame) = {	
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
		if(!(isNil "_handlerData") && IS_ARRAY(_handlerData)) then {
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
	} forEach GVAR(perFrameHandlerArray);
};
GVAR(perFrameHandlerArray) = [];
GVAR(fpsCount) = 0;
GVAR(lastCount) = -1;
GVAR(lastFrameRender) = 0;
// prepare our handlers list
((_this select 0) displayCtrl 40122) ctrlSetEventHandler ["Draw", QUOTE([_this] call FUNC(_onFrame);) ];
[] spawn {
	sleep 3;
	GVAR(lastFrameRender) = diag_tickTime;
	[] spawn FUNC(_monitorFrameRender);
};
