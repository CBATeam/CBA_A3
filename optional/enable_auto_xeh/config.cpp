#include "script_component.hpp"

class CfgPatches
{
	class ADDON
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {"Extended_EventHandlers", "CBA_Main"};
		version = VERSION;
		author[] = {"CBA Team"};
		authorUrl = "https://github.com/CBATeam/CBA_A3";
	};
};

class CfgSettings
{
	class CBA
	{
		class XEH
		{
			supportMonitor = 1;
		};
	};
};
