#include "script_component.hpp"
// execVM "\x\cba\addons\ui\test_preload.sqf";

if (!canSuspend) exitWith {
    execVM __FILE__;
};

isNil {
    with uiNamespace do {
        // 3DEN
        TEST_DEFINED(QFUNC(preload3DEN),"");

        AmmoBox_list = nil;
        ["onLoad", [controlNull]] call compile preprocessFile "\a3\3den\UI\Attributes\AmmoBox.sqf";
    };
};

waitUntil {!isNil {uiNamespace getVariable "AmmoBox_list"}};

isNil {
    with uiNamespace do {
        private _vanilla = AmmoBox_list;

        AmmoBox_list = nil;
        call FUNC(preload3DEN);
        private _cba = AmmoBox_list;

        TEST_TRUE([_vanilla] isEqualTo [_cba],QFUNC(preload3DEN));
        if !([_vanilla] isEqualTo [_cba]) then {
            copyToClipboard ("3DEN" + endl + str _vanilla + endl + str _cba);
        };

        // Curator
        TEST_DEFINED(QFUNC(preloadCurator),"");

        private _unit = player;
        private _curator = getAssignedCuratorLogic _unit;

        if (isNull _curator) then {
            _curator = createGroup sideLogic createUnit ["ModuleCurator_F", [0,0,0], [], 0, "NONE"];
            _unit assignCurator _curator;
        };

        _curator removeCuratorAddons call EGVAR(common,addons);
        _curator addCuratorAddons call EGVAR(common,addons);

        missionNamespace setVariable ["RscAttrbuteInventory_weaponAddons", nil];
        ["onLoad", [displayNull], objNull] call compile preprocessFile "\a3\ui_f_curator\UI\RscCommon\RscAttributeInventory.sqf";
        _vanilla = RscAttributeInventory_list;

        GVAR(curatorItemCache) = nil;
        call FUNC(preloadCurator);
        missionNamespace setVariable ["RscAttrbuteInventory_weaponAddons", GVAR(curatorItemCache)];
        ["onLoad", [displayNull], objNull] call compile preprocessFile "\a3\ui_f_curator\UI\RscCommon\RscAttributeInventory.sqf";
        _cba = RscAttributeInventory_list;

        TEST_TRUE([_vanilla] isEqualTo [_cba],QFUNC(preloadCurator));
        if !([_vanilla] isEqualTo [_cba]) then {
            copyToClipboard ("Curator" + endl + str _vanilla + endl + str _cba);
        };
    };
};
