#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = CSTRING(component);
        url = "$STR_CBA_URL";
        units[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"CBA_common"};
        version = VERSION;
        authors[] = {"Kerc Kasha"};
    };
};
#include "CfgEventHandlers.hpp"
class bg_weaponparameters 
{

	class onFired_Action
	{
		HandAction = "";
		Actiondelay = 0.2;
		Sound = "";
		Sound_Location = "RightHandMiddle1";
		hasOptic = false;
	};
	class onEmpty
	{
		Sound = "";
		Sound_Location = "RightHandMiddle1";
	};

};
