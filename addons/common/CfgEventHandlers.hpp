// TODO: Find better way to schedule which addon inits first, does not seem to be alphabetic, but when the addon loads (probably filename/prefixname/other loading order)
class Extended_PreInit_EventHandlers
{
	class ADDON
	{
		init = QUOTE(call COMPILE_FILE(XEH_preInit));
		clientInit = QUOTE(call COMPILE_FILE(XEH_preClientInit));
	};
};

class Extended_PostInit_EventHandlers
{
	class ADDON
	{
		init = QUOTE(call COMPILE_FILE(XEH_postInit));
	};
};

class Extended_Init_EventHandlers
{
	// Override - no need to double compile or compile functions at the same time (main disabled)
	class FunctionsManager /* : Logic */ {
		SLX_BIS = "textLogFormat ['PRELOAD_ Functions\init %1', [_this, BIS_functions_mainscope]]; 	if (isnil 'BIS_functions_mainscope') then 	{ BIS_functions_mainscope = _this select 0;  if (isServer) then {_dummy = BIS_functions_mainscope spawn {_this setpos [1000,10,0];}};} else {_this spawn { textLogFormat ['PRELOAD_ Functions\init  ERROR: deleting redundant FM! %1', [_this, (_this select 0), BIS_functions_mainscope]]; _mygrp = group (_this select 0); deleteVehicle (_this select 0); deleteGroup _mygrp;};}; if (isnil 'RE') then {[] execVM '\ca\Modules\MP\data\scripts\MPframework.sqf'};	";
	};
};
