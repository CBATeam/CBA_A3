/* ----------------------------------------------------------------------------
Internal Function: CBA_events_fnc_perFrameEngine

THIS FUNCTION IS PRIVATE AND NOT FOR USER EXECUTION!

This file creates two functions, one that executes every frame and is
added to the map control, and the other which spawns up and monitors
for a stoppage of the on frame handler (because alt-tabbing stops its
execution).
---------------------------------------------------------------------------- */

#include "script_component.hpp"

// prepare our handlers list
((_this select 0) displayCtrl 40122) ctrlSetEventHandler ["Draw", QUOTE([_this] call FUNC(onFrame)) ];
[] spawn {
	sleep 3;
	GVAR(lastFrameRender) = diag_tickTime;
	[] spawn FUNC(monitorFrameRender);
};
