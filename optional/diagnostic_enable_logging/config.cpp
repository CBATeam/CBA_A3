class CfgPatches
{
	class cba_diagnostic_logging
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.05;
		requiredAddons[] = {"Extended_EventHandlers"};
		version = "0.7.0.134";
		author[] = {"Sickboy"};
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

