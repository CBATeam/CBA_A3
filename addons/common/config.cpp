#include "script_component.hpp"
class CfgPatches
{
	class ADDON
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = { "Extended_EventHandlers" };
		version = VERSION;
		author[] = {"Spooner", "Sickboy", "Rocko"};
		authorUrl = "http://dev-heaven.net/projects/cca";
	};
};
#include "CfgEventHandlers.hpp"

#include "CfgFunctions.hpp"

#include "CfgPerFrame.hpp"

class CfgVehicles {
	// Override - no need to double compile or compile functions at the same time (main disabled)
	class Logic;
	class FunctionsManager: Logic
		class EventHandlers {
			init = "textLogFormat ['PRELOAD_ Functions\init %1', [_this, BIS_functions_mainscope]]; 	if (isnil 'BIS_functions_mainscope') then 	{ BIS_functions_mainscope = _this select 0;  if (isServer) then {_dummy = BIS_functions_mainscope spawn {_this setpos [1000,10,0];}};} else {_this spawn { textLogFormat ['PRELOAD_ Functions\init  ERROR: deleting redundant FM! %1', [_this, (_this select 0), BIS_functions_mainscope]]; _mygrp = group (_this select 0); deleteVehicle (_this select 0); deleteGroup _mygrp;};}; if (isnil 'RE') then {[] execVM '\ca\Modules\MP\data\scripts\MPframework.sqf'};	";
		};
	};
};
