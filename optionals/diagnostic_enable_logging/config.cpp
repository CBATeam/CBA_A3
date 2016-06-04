#include "script_component.hpp"

class CfgPatches
{
	class ADDON
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {"CBA_Diagnostic"};
		version = VERSION;
		author = "$STR_CBA_Author";
		authors[] = {"Sickboy"};
		authorUrl = "http://dev-heaven.net/projects/cca";
	};
};
class Extended_Init_EventHandlers
{
	class All
	{
		class cba_diagnostic_logging
		{
			init = "diag_log [diag_frameNo, diag_fps, diag_tickTime, time, _this, typeOf (_this select 0), getPosASL (_this select 0)]";
		};
	};
};

