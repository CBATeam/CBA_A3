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
		author[] = {"Sickboy"};
		authorUrl = "http://dev-heaven.net/projects/cca";
	};
};

class CfgSettings
{
	class CBA
	{
		class Caching
		{
			xeh = 0;
			compile = 0;
			functions = 0;
		};
	};
};
