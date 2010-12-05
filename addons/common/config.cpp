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
	// Also use to kick-off XEH as final resort.
	class Logic;
	class FunctionsManager: Logic
	{
		class EventHandlers
		{
			init = "if(isnil'SLX_XEH_objects')then{call compile preprocessFile'extended_eventhandlers\InitXEH.sqf'};_this call SLX_XEH_EH_Init; textLogFormat ['PRELOAD_ Functions\init %1', [_this, BIS_functions_mainscope]]; 	if (isnil 'BIS_functions_mainscope') then 	{ BIS_functions_mainscope = _this select 0; if (isServer) then {_this execVM 'ca\modules\functions\main.sqf'};} else {_this spawn { textLogFormat ['PRELOAD_ Functions\init  ERROR: deleting redundant FM! %1', [_this, (_this select 0), BIS_functions_mainscope]]; _mygrp = group (_this select 0); deleteVehicle (_this select 0); deleteGroup _mygrp;};}; if (isnil 'RE') then {[] execVM '\ca\Modules\MP\data\scripts\MPframework.sqf'};	";
		};
	};
};
