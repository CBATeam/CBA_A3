/*
	Disable XEH logging
	
	This is an optional addon that can be used to silence the log output
	that XEH (Extended Eventhandlers) generates.
	
	To use this and disable the XEH log output, place this addon in @CBA\Addons.
	
	Reference: http://dev-heaven.net/issues/15637
*/
class CfgPatches
{
	class Disable_XEH_Logging
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"Extended_EventHandlers"};
	};
};

