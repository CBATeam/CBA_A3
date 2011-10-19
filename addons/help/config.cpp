#include "script_component.hpp"
class CfgPatches {
	class ADDON {
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = { "cba_common", "CBA_hashes" };
		version = VERSION;
		author[] = {"alef", "Rocko", "Sickboy"};
		authorUrl = "http://dev-heaven.net/projects/cca";
	};
};

#include "CfgRscStd.hpp"
#include "CfgEventhandlers.hpp"

