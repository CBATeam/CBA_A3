
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

        class Misc {
            // CBA_fnc_actionArgument
            class actionArgument
            {
                description = "Used to call the code parsed in the addaction argument.";
                file = "\x\cba\addons\common\fnc_actionArgument.sqf";
            };
            // CBA_fnc_addMagazine
            class addMagazine
            {
                description = "Add magazine to a vehicle/unit.";
                file = "\x\cba\addons\common\fnc_addMagazine.sqf";
            };
            // CBA_fnc_addMagazineCargo
            class addMagazineCargo
            {
                description = "Add magazine(s) to a vehicle's cargo.";
                file = "\x\cba\addons\common\fnc_addMagazineCargo.sqf";
            };
            // CBA_fnc_addMagazineCargoGlobal
            class addMagazineCargoGlobal
            {
                description = "Add magazine(s) to a vehicle's cargo. MP synchronized.";
                file = "\x\cba\addons\common\fnc_addMagazineCargoGlobal.sqf";
            };
            // CBA_fnc_addMagazineVerified
            class addMagazineVerified
            {
                description = "Add magazines to the unit, but verify that it was successful and doesn't over-burden the recipient.";
                file = "\x\cba\addons\common\fnc_addMagazineVerified.sqf";
            };
            // CBA_fnc_addPerFrameHandler
            class addPerFrameHandler
            {
                description = "Add a handler that will execute every frame, or every x number of seconds.";
                file = "\x\cba\addons\common\fnc_addPerFrameHandler.sqf";
            };
            // CBA_fnc_addPlayerAction
            class addPlayerAction
            {
                description = "Adds persistent action to player (which will also be available in vehicles and after respawn or teamswitch).";
                file = "\x\cba\addons\common\fnc_addPlayerAction.sqf";
            };
            // CBA_fnc_addWeapon
            class addWeapon
            {
                description = "Add a weapon to a unit.";
                file = "\x\cba\addons\common\fnc_addWeapon.sqf";
            };
            // CBA_fnc_addWeaponCargo
            class addWeaponCargo
            {
                description = "Add weapon(s) to vehicle cargo.";
                file = "\x\cba\addons\common\fnc_addWeaponCargo.sqf";
            };
            // CBA_fnc_addWeaponCargoGlobal
            class addWeaponCargoGlobal
            {
                description = "Add weapon(s) to vehicle cargo. MP synchronized.";
                file = "\x\cba\addons\common\fnc_addWeaponCargoGlobal.sqf";
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
            // CBA_fnc_createNamespace
            class createNamespace
            {
                description = "Creates a namespace. Used to store and read variables via setVariable and getVariable.";
                file = "\x\cba\addons\common\fnc_createNamespace.sqf";
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
            // CBA_fnc_deleteEntity
            class deleteEntity
            {
                description = "A function used to delete entities";
                file = "\x\cba\addons\common\fnc_deleteEntity.sqf";
            };
            // CBA_fnc_deleteNamespace
            class deleteNamespace
            {
                description = "Deletes a namespace created with CBA_fnc_createNamespace.";
                file = "\x\cba\addons\common\fnc_deleteNamespace.sqf";
            };
            // CBA_fnc_directCall
            class directCall
            {
                description = "Executes a piece of code in unscheduled environment.";
                file = "\x\cba\addons\common\fnc_directCall.sqf";
            };
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
            // CBA_fnc_findEntity
            class findEntity
            {
                description = "A function used to find out the first entity of parsed type in a nearEntitys call";
                file = "\x\cba\addons\common\fnc_findEntity.sqf";
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
            // CBA_fnc_getDistance
            class getDistance
            {
                description = "A function used to find out the distance between two positions.";
                file = "\x\cba\addons\common\fnc_getDistance.sqf";
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
            // CBA_fnc_getNearest
            class getNearest
            {
                description = "A function used to find out the nearest entity parsed in an array to a position. Compares the distance between entity's in the parsed array.";
                file = "\x\cba\addons\common\fnc_getNearest.sqf";
            };
            // CBA_fnc_getNearestBuilding
            class getNearestBuilding
            {
                description = "A function used to find out the nearest building and appropriate building positions available.";
                file = "\x\cba\addons\common\fnc_getNearestBuilding.sqf";
            };
            // CBA_fnc_getPistol
            class getPistol
            {
                description = "Returns name of pistol in unit's inventory, if any.";
                file = "\x\cba\addons\common\fnc_getPistol.sqf";
            };
            // CBA_fnc_getPos
            class getPos
            {
                description = "A function used to get the position of an entity.";
                file = "\x\cba\addons\common\fnc_getPos.sqf";
            };
            // CBA_fnc_getSharedGroup
            class getSharedGroup
            {
                description = "Returns existing group on side, or newly created group when not existent.";
                file = "\x\cba\addons\common\fnc_getSharedGroup.sqf";
            };
            // CBA_fnc_getTerrainProfile
            class getTerrainProfile
            {
                description = "A function used to find the terrain profile between two positions";
                file = "\x\cba\addons\common\fnc_getTerrainProfile.sqf";
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
            // CBA_fnc_inArea
            class inArea
            {
                description = "A function used to determine if a position is within a zone.";
                file = "\x\cba\addons\common\fnc_inArea.sqf";
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
            // CBA_fnc_mapDirTo
            class mapDirTo
            {
                description = "Gets the direction between two map grid references.";
                file = "\x\cba\addons\common\fnc_mapDirTo.sqf";
            };
            // CBA_fnc_mapGridToPos
            class mapGridToPos
            {
                description = "Converts a 2, 4, 6, 8, or 10 digit grid reference into a Position.";
                file = "\x\cba\addons\common\fnc_mapGridToPos.sqf";
            };
            // CBA_fnc_mapRelPos
            class mapRelPos
            {
                description = "Find a position relative to a known position on the map. Passing strings in for the Northing and Easting is the preferred way.";
                file = "\x\cba\addons\common\fnc_mapRelPos.sqf";
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
            // CBA_fnc_northingReversed
            class northingReversed
            {
                description = "Checks if the maps northing is reversed (like Chernarus & Utes, or any map pre-OA)";
                file = "\x\cba\addons\common\fnc_northingReversed.sqf";
            };
            // CBA_fnc_objectRandom
            class objectRandom
            {
                description = "Creates a ""random"" number 0-9 based on an object's velocity";
                file = "\x\cba\addons\common\fnc_objectRandom.sqf";
            };
            // CBA_fnc_onTeamColorChanged
            class onTeamColorChanged
            {
                description = "Assigns the units team color if it changed on another machine.";
                file = "\x\cba\addons\common\fnc_onTeamColorChanged.sqf";
            };
            // CBA_fnc_parseYAML
            class parseYAML
            {
                description = "Parses a YAML file into a nested array/Hash structure.";
                file = "\x\cba\addons\common\fnc_parseYAML.sqf";
            };
            // CBA_fnc_players
            class players
            {
                description = "Get a list of current player objects.";
                file = "\x\cba\addons\common\fnc_players.sqf";
            };
            // CBA_fnc_randPos
            class randPos
            {
                description = "A function used to randomize a position around a given center.";
                file = "\x\cba\addons\common\fnc_randPos.sqf";
            };
            // CBA_fnc_randPosArea
            class randPosArea
            {
                description = "A function used to randomize a position within a given zone.";
                file = "\x\cba\addons\common\fnc_randPosArea.sqf";
            };
            // CBA_fnc_realHeight
            class realHeight
            {
                description = "Real z coordinate of an object, for placing stuff on roofs, etc.";
                file = "\x\cba\addons\common\fnc_realHeight.sqf";
            };
            // CBA_fnc_removeBackpackCargo
            class removeBackpackCargo
            {
                description = "Removes specific backpack(s) from local cargo space.";
                file = "\x\cba\addons\common\fnc_removeBackpackCargo.sqf";
            };
            // CBA_fnc_removeBackpackCargoGlobal
            class removeBackpackCargoGlobal
            {
                description = "Remove specific backpack(s) from global cargo space. MP synchronized.";
                file = "\x\cba\addons\common\fnc_removeBackpackCargoGlobal.sqf";
            };
            // CBA_fnc_removeItemCargo
            class removeItemCargo
            {
                description = "Removes specific item(s) from local cargo space.";
                file = "\x\cba\addons\common\fnc_removeItemCargo.sqf";
            };
            // CBA_fnc_removeItemCargoGlobal
            class removeItemCargoGlobal
            {
                description = "Removes specific item(s) from global cargo space. MP synchronized.";
                file = "\x\cba\addons\common\fnc_removeItemCargoGlobal.sqf";
            };
            // CBA_fnc_removeMagazine
            class removeMagazine
            {
                description = "Remove a magazine.";
                file = "\x\cba\addons\common\fnc_removeMagazine.sqf";
            };
            // CBA_fnc_removeMagazineCargo
            class removeMagazineCargo
            {
                description = "Removes specific magazine(s) from local cargo space.";
                file = "\x\cba\addons\common\fnc_removeMagazineCargo.sqf";
            };
            // CBA_fnc_removeMagazineCargoGlobal
            class removeMagazineCargoGlobal
            {
                description = "Removes specific magazine(s) from global cargo space. MP synchronized.";
                file = "\x\cba\addons\common\fnc_removeMagazineCargoGlobal.sqf";
            };
            // CBA_fnc_removePerFrameHandler
            class removePerFrameHandler
            {
                description = "Remove a handler that you have added using CBA_fnc_addPerFrameHandler.";
                file = "\x\cba\addons\common\fnc_removePerFrameHandler.sqf";
            };
            // CBA_fnc_removePlayerAction
            class removePlayerAction
            {
                description = "Removes player action previously added with <CBA_fnc_addPlayerAction>.";
                file = "\x\cba\addons\common\fnc_removePlayerAction.sqf";
            };
            // CBA_fnc_removeWeapon
            class removeWeapon
            {
                description = "Remove a weapon.";
                file = "\x\cba\addons\common\fnc_removeWeapon.sqf";
            };
            // CBA_fnc_removeWeaponCargo
            class removeWeaponCargo
            {
                description = "Removes specific weapon(s) from local cargo space.";
                file = "\x\cba\addons\common\fnc_removeWeaponCargo.sqf";
            };
            // CBA_fnc_removeWeaponCargoGlobal
            class removeWeaponCargoGlobal
            {
                description = "Removes specific weapon(s) from global cargo space. MP synchronized.";
                file = "\x\cba\addons\common\fnc_removeWeaponCargoGlobal.sqf";
            };
            // CBA_fnc_selectWeapon
            class selectWeapon
            {
                description = "Selects a weapon including correctly selecting a weapon mode of specified.";
                file = "\x\cba\addons\common\fnc_selectWeapon.sqf";
            };
            // CBA_fnc_setHeight
            class setHeight
            {
                description = "A function used to set the height of an object";
                file = "\x\cba\addons\common\fnc_setHeight.sqf";
            };
            // CBA_fnc_setPos
            class setPos
            {
                description = "A function used to set the position of an entity.";
                file = "\x\cba\addons\common\fnc_setPos.sqf";
            };
            // CBA_fnc_switchPlayer
            class switchPlayer
            {
                description = "Switch player to another unit.";
                file = "\x\cba\addons\common\fnc_switchPlayer.sqf";
            };
            // CBA_fnc_synchTeamColors
            class synchTeamColors
            {
                description = "Synchs the team colors every second.";
                file = "\x\cba\addons\common\fnc_synchTeamColors.sqf";
            };
            // CBA_fnc_systemChat
            class systemChat
            {
                description = "Display a message in the global chat channel.";
                file = "\x\cba\addons\common\fnc_systemChat.sqf";
            };
        };
    };
};
