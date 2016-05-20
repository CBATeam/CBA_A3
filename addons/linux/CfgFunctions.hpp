
class CfgFunctions {
    class CBA {
        class Entities {
            class getAlive {
                file = __EVAL(call compile "[""\x\cba\addons\common\fnc_getAlive.sqf"",""\x\cba\addons\common\fnc_getAlive_Linux.sqf""] select isNil compile 'is3DEN'");
            };
            class getMagazineIndex {
                file = __EVAL(call compile "[""\x\cba\addons\common\fnc_getMagazineIndex.sqf"",""\x\cba\addons\common\fnc_getMagazineIndex_Linux.sqf""] select isNil compile 'is3DEN'");
            };
        };

        class Vehicles {
            class vehicleRole {
                file = __EVAL(call compile "[""\x\cba\addons\common\fnc_vehicleRole.sqf"",""\x\cba\addons\common\fnc_vehicleRole_Linux.sqf""] select isNil compile 'is3DEN'");
            };
            class turretPath {
                file = __EVAL(call compile "[""\x\cba\addons\common\fnc_turretPath.sqf"",""\x\cba\addons\common\fnc_turretPath_Linux.sqf""] select isNil compile 'is3DEN'");
            };
            class turretPathWeapon {
                file = __EVAL(call compile "[""\x\cba\addons\common\fnc_turretPathWeapon.sqf"",""\x\cba\addons\common\fnc_turretPathWeapon_Linux.sqf""] select isNil compile 'is3DEN'");
            };
        };

        class Inventory {
            class removeMagazine {
                file = __EVAL(call compile "[""\x\cba\addons\common\fnc_removeMagazine.sqf"",""\x\cba\addons\common\fnc_removeMagazine_Linux.sqf""] select isNil compile 'is3DEN'");
            };
            class dropWeapon {
                file = __EVAL(call compile "[""\x\cba\addons\common\fnc_dropWeapon.sqf"",""\x\cba\addons\common\fnc_dropWeapon_Linux.sqf""] select isNil compile 'is3DEN'");
            };
            class dropMagazine {
                file = __EVAL(call compile "[""\x\cba\addons\common\fnc_dropMagazine.sqf"",""\x\cba\addons\common\fnc_dropMagazine_Linux.sqf""] select isNil compile 'is3DEN'");
            };
            class addBinocularMagazine {
                file = __EVAL(call compile "[""\x\cba\addons\common\fnc_addBinocularMagazine.sqf"",""\x\cba\addons\common\fnc_addBinocularMagazine_Linux.sqf""] select isNil compile 'is3DEN'");
            };
        };

        class Events {
            class addPlayerEventHandler {
                file = __EVAL(call compile "[""\x\cba\addons\events\fnc_addPlayerEventHandler.sqf"",""\x\cba\addons\events\fnc_addPlayerEventHandler_Linux.sqf""] select isNil compile 'is3DEN'");
            };
            class addKeyHandler {
                file = __EVAL(call compile "[""\x\cba\addons\events\fnc_addKeyHandler.sqf"",""\x\cba\addons\events\fnc_addKeyHandler_Linux.sqf""] select isNil compile 'is3DEN'");
            };
            class targetEvent {
                file = __EVAL(call compile "[""\x\cba\addons\events\fnc_targetEvent.sqf"",""\x\cba\addons\events\fnc_targetEvent_Linux.sqf""] select isNil compile 'is3DEN'");
            };
        };

        class Hashes {
            class hashCreate {
                file = __EVAL(call compile "[""\x\cba\addons\hashes\fnc_hashCreate.sqf"",""\x\cba\addons\hashes\fnc_hashCreate_Linux.sqf""] select isNil compile 'is3DEN'");
            };
        };

        class JR {
            class compatibleItems {
                file = __EVAL(call compile "[""\x\cba\addons\jr\fnc_compatibleItems.sqf"",""\x\cba\addons\jr\fnc_compatibleItems_Linux.sqf""] select isNil compile 'is3DEN'");
            };
        };

        class XEH {
            class compileEventHandlers {
                file = __EVAL(call compile "[""\x\cba\addons\xeh\fnc_compileEventHandlers.sqf"",""\x\cba\addons\xeh\fnc_compileEventHandlers_Linux.sqf""] select isNil compile 'is3DEN'");
            };
        };
    };
};
