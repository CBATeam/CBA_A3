#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        units[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"CBA_common"};
        version = VERSION;
        author[] = {"Spooner","Sickboy","Xeno","commy2"};
        authorUrl = "https://github.com/CBATeam/CBA_A3";
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"

#include "test_keys.hpp"

/*
id0 = [15, [false, false, false], {systemChat str _this}, "keydown", nil, false, 2] call CBA_fnc_addKeyHandler;

id1 = ["TestAddon", "action1", {systemChat str _this}] call CBA_fnc_addKeyHandlerFromConfig;
id2 = ["TestAddon", "action2", {systemChat str _this}] call CBA_fnc_addKeyHandlerFromConfig;
*/
