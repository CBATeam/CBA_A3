
#define F_FILEPATH(mod,func) class func {\
    file = QUOTE(PATHTOF(mod\DOUBLES(fnc,func).sqf));\
}

class CfgFunctions {
    class CBA {
        class Config {
            F_FILEPATH(config,getConfigEntry);
            F_FILEPATH(config,getObjectConfig);
            F_FILEPATH(config,getItemConfig);
            F_FILEPATH(config,getMuzzles);
            F_FILEPATH(config,getWeaponModes);
            F_FILEPATH(config,inheritsFrom);
            F_FILEPATH(config,getTurret);
        };

        class Inventory {
            F_FILEPATH(inventory,addWeapon);
            F_FILEPATH(inventory,addMagazine);
            F_FILEPATH(inventory,addItem);
            F_FILEPATH(inventory,removeWeapon);
            F_FILEPATH(inventory,removeMagazine);
            F_FILEPATH(inventory,removeItem);
        };

        class Cargo {
            F_FILEPATH(cargo,addWeaponCargo);
            F_FILEPATH(cargo,addMagazineCargo);
            F_FILEPATH(cargo,addItemCargo);
            F_FILEPATH(cargo,addBackpackCargo);
            F_FILEPATH(cargo,removeWeaponCargo);
            F_FILEPATH(cargo,removeMagazineCargo);
            F_FILEPATH(cargo,removeItemCargo);
            F_FILEPATH(cargo,removeBackpackCargo);
        };

        class Maps {
            F_FILEPATH(maps,northingReversed);
            F_FILEPATH(maps,mapGridToPos);
            F_FILEPATH(maps,mapRelPos);
            F_FILEPATH(maps,mapDirTo);
            F_FILEPATH(maps,getTerrainProfile);
        };

        class Positions {
            F_FILEPATH(positions,getDistance);
            F_FILEPATH(positions,getPos);
            F_FILEPATH(positions,setPos);
            F_FILEPATH(positions,realHeight);
            F_FILEPATH(positions,setHeight);
            F_FILEPATH(positions,randPos);
            F_FILEPATH(positions,randPosArea);
            F_FILEPATH(positions,inArea);
            F_FILEPATH(positions,getNearest);
            F_FILEPATH(positions,getNearestBuilding);
        };

        class Entities {
            F_FILEPATH(entities,findEntity);
            F_FILEPATH(entities,deleteEntity);
        };

        class Misc {
            F_FILEPATH(misc,addPerFrameHandler);
            F_FILEPATH(misc,removePerFrameHandler);
            F_FILEPATH(misc,addPlayerAction);
            F_FILEPATH(misc,removePlayerAction);
            F_FILEPATH(misc,createNamespace);
            F_FILEPATH(misc,deleteNamespace);
            F_FILEPATH(misc,directCall);
            F_FILEPATH(misc,objectRandom);
            F_FILEPATH(misc,parseYAML);
        };






















        class Unsorted {
            // CBA_fnc_actionArgument
            class actionArgument
            {
                description = "Used to call the code parsed in the addaction argument.";
                file = "\x\cba\addons\common\fnc_actionArgument.sqf";
            };
            // CBA_fnc_canUseWeapon
            class canUseWeapon
            {
                description = "Checks if the unit can currently use a weapon.";
                file = "\x\cba\addons\common\fnc_canUseWeapon.sqf";
            };
            // CBA_fnc_createCenter
            class createCenter
            {
                description = "Selects center if it already exists, creates it if it doesn't yet.";
                file = "\x\cba\addons\common\fnc_createCenter.sqf";
            };
            // CBA_fnc_createMarker
            class createMarker
            {
                description = "Creates a marker all at once.";
                file = "\x\cba\addons\common\fnc_createMarker.sqf";
            };
            // CBA_fnc_createTrigger
            class createTrigger
            {
                description = "Create a trigger all at once.";
                file = "\x\cba\addons\common\fnc_createTrigger.sqf";
            };
            // CBA_fnc_defaultParam
            class defaultParam
            {
                description = "Gets a value from parameters list (usually _this) with a default.";
                file = "\x\cba\addons\common\fnc_defaultParam.sqf";
            };
            // CBA_fnc_getAlive
            class getAlive
            {
                description = "A function used to find out who is alive in an array or a group.";
                file = "\x\cba\addons\common\fnc_getAlive.sqf";
            };
            // CBA_fnc_getAnimType
            class getAnimType
            {
                description = "Used to determine which weapon unit is currently holding and return proper animation type.";
                file = "\x\cba\addons\common\fnc_getAnimType.sqf";
            };
            // CBA_fnc_getArg
            class getArg
            {
                description = "Get default named argument from list.";
                file = "\x\cba\addons\common\fnc_getArg.sqf";
            };
            // CBA_fnc_getAspectRatio
            class getAspectRatio
            {
                description = "Used to determine the Aspect ratio of the screen.";
                file = "\x\cba\addons\common\fnc_getAspectRatio.sqf";
            };
            // CBA_fnc_getFirer
            class getFirer
            {
                description = "A function used to find out which unit exactly fired (Replacement for gunner, on multi-turret vehicles).";
                file = "\x\cba\addons\common\fnc_getFirer.sqf";
            };
            // CBA_fnc_getFov
            class getFov
            {
                description = "Get current camera's field of view in radians and zoom.";
                file = "\x\cba\addons\common\fnc_getFov.sqf";
            };
            // CBA_fnc_getGroup
            class getGroup
            {
                description = "A function used to find out the group of an object.";
                file = "\x\cba\addons\common\fnc_getGroup.sqf";
            };
            // CBA_fnc_getGroupIndex
            class getGroupIndex
            {
                description = "Finds out the actual ID number of a person within his group as assigned by the game and used in the squad leader's command menu.";
                file = "\x\cba\addons\common\fnc_getGroupIndex.sqf";
            };
            // CBA_fnc_getSharedGroup
            class getSharedGroup
            {
                description = "Returns existing group on side, or newly created group when not existent.";
                file = "\x\cba\addons\common\fnc_getSharedGroup.sqf";
            };
            // CBA_fnc_getUISize
            class getUISize
            {
                description = "Used to determine the UI size of the screen.";
                file = "\x\cba\addons\common\fnc_getUISize.sqf";
            };
            // CBA_fnc_getUnitAnim
            class getUnitAnim
            {
                description = "Get information about a unit's stance and speed.";
                file = "\x\cba\addons\common\fnc_getUnitAnim.sqf";
            };
            // CBA_fnc_getUnitDeathAnim
            class getUnitDeathAnim
            {
                description = "Get death animation for a unit.";
                file = "\x\cba\addons\common\fnc_getUnitDeathAnim.sqf";
            };
            // CBA_fnc_getVolume
            class getVolume
            {
                description = "Return the volume of an object based on the object's model's bounding box.";
                file = "\x\cba\addons\common\fnc_getVolume.sqf";
            };
            // CBA_fnc_headDir
            class headDir
            {
                description = "Get the direction of a unit's head.";
                file = "\x\cba\addons\common\fnc_headDir.sqf";
            };
            // CBA_fnc_intToString
            class intToString
            {
                description = "Faster int to string, uses an integer lookup table if possible";
                file = "\x\cba\addons\common\fnc_intToString.sqf";
            };
            // CBA_fnc_isAlive
            class isAlive
            {
                description = "A function used to find out if the group or object is alive.";
                file = "\x\cba\addons\common\fnc_isAlive.sqf";
            };
            // CBA_fnc_isPerson
            class isPerson
            {
                description = "Checks if an object is a person - soldier or civilian.";
                file = "\x\cba\addons\common\fnc_isPerson.sqf";
            };
            // CBA_fnc_isTurnedOut
            class isTurnedOut
            {
                description = "Checks whether a unit is turned out in a vehicle or not.";
                file = "\x\cba\addons\common\fnc_isTurnedOut.sqf";
            };
            // CBA_fnc_isUnitGetOutAnim
            class isUnitGetOutAnim
            {
                description = "Checks whether a unit is turned out in a vehicle or not.";
                file = "\x\cba\addons\common\fnc_isUnitGetOutAnim.sqf";
            };
            // CBA_fnc_locked
            class locked
            {
                description = "A2/OA/TOH compatible locked function.";
                file = "\x\cba\addons\common\fnc_locked.sqf";
            };
            // CBA_fnc_modelHeadDir
            class modelHeadDir
            {
                description = "Get the direction of any unit's head.";
                file = "\x\cba\addons\common\fnc_modelHeadDir.sqf";
            };
            // CBA_fnc_nearPlayer
            class nearPlayer
            {
                description = "Check whether these are any players within a certain distance of a unit.";
                file = "\x\cba\addons\common\fnc_nearPlayer.sqf";
            };
            // CBA_fnc_selectWeapon
            class selectWeapon
            {
                description = "Selects a weapon including correctly selecting a weapon mode of specified.";
                file = "\x\cba\addons\common\fnc_selectWeapon.sqf";
            };
            // CBA_fnc_switchPlayer
            class switchPlayer
            {
                description = "Switch player to another unit.";
                file = "\x\cba\addons\common\fnc_switchPlayer.sqf";
            };
        };

        class Internal {
            F_FILEPATH(internal,onTeamColorChanged);
            F_FILEPATH(internal,synchTeamColors);
        };

        class Broken {
            // CBA_fnc_dropMagazine
            class dropMagazine
            {
                description = "Drop a magazine.";
                file = "\x\cba\addons\common\fnc_dropMagazine.sqf";
            };
            // CBA_fnc_dropWeapon
            class dropWeapon
            {
                description = "Drops a weapon.";
                file = "\x\cba\addons\common\fnc_dropWeapon.sqf";
            };
        };
    };
};
