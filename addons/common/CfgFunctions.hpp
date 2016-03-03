
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

        class Entities {
            F_FILEPATH(entities,findEntity);
            F_FILEPATH(entities,deleteEntity);
            F_FILEPATH(entities,isAlive);
            F_FILEPATH(entities,getAlive);
            F_FILEPATH(entities,getGroup);
            F_FILEPATH(entities,getSharedGroup);
            F_FILEPATH(entities,nearPlayer);
            F_FILEPATH(entities,getArg);
            F_FILEPATH(entities,createMarker);
            F_FILEPATH(entities,createTrigger);
            F_FILEPATH(entities,getGroupIndex);
            F_FILEPATH(entities,getMagazineIndex);
            F_FILEPATH(entities,currentMagazineIndex);
        };

        class Soldiers {
            F_FILEPATH(soldiers,isPerson);
            F_FILEPATH(soldiers,canUseWeapon);
            F_FILEPATH(soldiers,selectWeapon);
            F_FILEPATH(soldiers,switchPlayer);
        };

        class Vehicles {
            F_FILEPATH(vehicles,getFirer);
            F_FILEPATH(vehicles,isTurnedOut);
            F_FILEPATH(vehicles,getVolume);
            F_FILEPATH(vehicles,getVehicleRole);
        };

        class Anims {
            F_FILEPATH(anims,getAnimType);
            F_FILEPATH(anims,getUnitAnim);
            F_FILEPATH(anims,getUnitDeathAnim);
            F_FILEPATH(anims,isUnitGetOutAnim);
            F_FILEPATH(anims,headDir);
            F_FILEPATH(anims,modelHeadDir);
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

        class Misc {
            F_FILEPATH(misc,addPerFrameHandler);
            F_FILEPATH(misc,removePerFrameHandler);
            F_FILEPATH(misc,addPlayerAction);
            F_FILEPATH(misc,removePlayerAction);
            F_FILEPATH(misc,createNamespace);
            F_FILEPATH(misc,deleteNamespace);
            F_FILEPATH(misc,directCall);
            F_FILEPATH(misc,objectRandom);
        };

        class Ui {
            F_FILEPATH(ui,getFov);
            F_FILEPATH(ui,getAspectRatio);
            F_FILEPATH(ui,getUISize);
        };

        class Broken {
            // CBA_fnc_actionArgument
            class actionArgument
            {
                description = "Used to call the code parsed in the addaction argument.";
                file = "\x\cba\addons\common\fnc_actionArgument.sqf";
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
        };
    };
};
