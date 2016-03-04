
#define F_FILEPATH(func) class func {\
    file = QUOTE(PATHTOF(DOUBLES(fnc,func).sqf));\
}

class CfgFunctions {
    class CBA {
        class Config {
            F_FILEPATH(getConfigEntry);
            F_FILEPATH(getObjectConfig);
            F_FILEPATH(getItemConfig);
            F_FILEPATH(getMuzzles);
            F_FILEPATH(getWeaponModes);
            F_FILEPATH(inheritsFrom);
            F_FILEPATH(getTurret);
        };

        class Entities {
            F_FILEPATH(findEntity);
            F_FILEPATH(deleteEntity);
            F_FILEPATH(isAlive);
            F_FILEPATH(getAlive);
            F_FILEPATH(getGroup);
            F_FILEPATH(getSharedGroup);
            F_FILEPATH(nearPlayer);
            F_FILEPATH(getArg);
            F_FILEPATH(createMarker);
            F_FILEPATH(createTrigger);
            F_FILEPATH(getGroupIndex);
            F_FILEPATH(getMagazineIndex);
            F_FILEPATH(currentMagazineIndex);
        };

        class Soldiers {
            F_FILEPATH(isPerson);
            F_FILEPATH(canUseWeapon);
            F_FILEPATH(selectWeapon);
            F_FILEPATH(switchPlayer);
        };

        class Vehicles {
            F_FILEPATH(getFirer);
            F_FILEPATH(isTurnedOut);
            F_FILEPATH(getVolume);
            F_FILEPATH(getVehicleRole);
        };

        class Anims {
            F_FILEPATH(getAnimType);
            F_FILEPATH(getUnitAnim);
            F_FILEPATH(getUnitDeathAnim);
            F_FILEPATH(isUnitGetOutAnim);
            F_FILEPATH(headDir);
            F_FILEPATH(modelHeadDir);
        };

        class Inventory {
            F_FILEPATH(addWeapon);
            F_FILEPATH(addMagazine);
            F_FILEPATH(addItem);
            F_FILEPATH(removeWeapon);
            F_FILEPATH(removeMagazine);
            F_FILEPATH(removeItem);
        };

        class Cargo {
            F_FILEPATH(addWeaponCargo);
            F_FILEPATH(addMagazineCargo);
            F_FILEPATH(addItemCargo);
            F_FILEPATH(addBackpackCargo);
            F_FILEPATH(removeWeaponCargo);
            F_FILEPATH(removeMagazineCargo);
            F_FILEPATH(removeItemCargo);
            F_FILEPATH(removeBackpackCargo);
        };

        class Maps {
            F_FILEPATH(northingReversed);
            F_FILEPATH(mapGridToPos);
            F_FILEPATH(mapRelPos);
            F_FILEPATH(mapDirTo);
            F_FILEPATH(getTerrainProfile);
        };

        class Positions {
            F_FILEPATH(getDistance);
            F_FILEPATH(getPos);
            F_FILEPATH(setPos);
            F_FILEPATH(realHeight);
            F_FILEPATH(setHeight);
            F_FILEPATH(randPos);
            F_FILEPATH(randPosArea);
            F_FILEPATH(inArea);
            F_FILEPATH(getNearest);
            F_FILEPATH(getNearestBuilding);
        };

        class Misc {
            F_FILEPATH(addPerFrameHandler);
            F_FILEPATH(removePerFrameHandler);
            F_FILEPATH(addPlayerAction);
            F_FILEPATH(removePlayerAction);
            F_FILEPATH(createNamespace);
            F_FILEPATH(deleteNamespace);
            F_FILEPATH(directCall);
            F_FILEPATH(objectRandom);
        };

        class Ui {
            F_FILEPATH(getFov);
            F_FILEPATH(getAspectRatio);
            F_FILEPATH(getUISize);
        };

        class Broken {
            F_FILEPATH(actionArgument);
            F_FILEPATH(dropMagazine);
            F_FILEPATH(dropWeapon);
        };
    };
};
