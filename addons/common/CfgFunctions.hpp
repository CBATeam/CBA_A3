
class CfgFunctions {
    class CBA {
        class Config {
            PATHTO_FNC(getConfigEntry);
            PATHTO_FNC(getObjectConfig);
            PATHTO_FNC(getItemConfig);
            PATHTO_FNC(getMuzzles);
            PATHTO_FNC(getWeaponModes);
            PATHTO_FNC(inheritsFrom);
            PATHTO_FNC(getTurret);
            PATHTO_FNC(getNonPresetClass);
        };

        class Entities {
            PATHTO_FNC(findEntity);
            PATHTO_FNC(deleteEntity);
            PATHTO_FNC(isAlive);
            PATHTO_FNC(getAlive);
            PATHTO_FNC(getGroup);
            PATHTO_FNC(getSharedGroup);
            PATHTO_FNC(nearPlayer);
            PATHTO_FNC(getArg);
            PATHTO_FNC(createMarker);
            PATHTO_FNC(createTrigger);
            PATHTO_FNC(getGroupIndex);
            PATHTO_FNC(getMagazineIndex);
            PATHTO_FNC(currentMagazineIndex);
            PATHTO_FNC(setCallsign);
        };

        class Soldiers {
            PATHTO_FNC(isPerson);
            PATHTO_FNC(canUseWeapon);
            PATHTO_FNC(selectWeapon);
            PATHTO_FNC(switchPlayer);
            PATHTO_FNC(currentUnit);
            PATHTO_FNC(players);
        };

        class Vehicles {
            PATHTO_FNC(getFirer);
            PATHTO_FNC(isTurnedOut);
            PATHTO_FNC(getVolume);
            PATHTO_FNC(vehicleRole);
            PATHTO_FNC(turretPath);
            PATHTO_FNC(turretPathWeapon);
            PATHTO_FNC(viewDir);
            PATHTO_FNC(turretDir);
        };

        class Anims {
            PATHTO_FNC(getAnimType);
            PATHTO_FNC(getUnitAnim);
            PATHTO_FNC(getUnitDeathAnim);
            PATHTO_FNC(isUnitGetOutAnim);
            PATHTO_FNC(headDir);
            PATHTO_FNC(modelHeadDir);
        };

        class Inventory {
            PATHTO_FNC(addWeapon);
            PATHTO_FNC(addMagazine);
            PATHTO_FNC(addItem);
            PATHTO_FNC(removeWeapon);
            PATHTO_FNC(removeMagazine);
            PATHTO_FNC(removeItem);
            PATHTO_FNC(weaponComponents);
            PATHTO_FNC(dropWeapon);
            PATHTO_FNC(dropMagazine);
            PATHTO_FNC(dropItem);
            PATHTO_FNC(binocularMagazine);
            PATHTO_FNC(addBinocularMagazine);
            PATHTO_FNC(removeBinocularMagazine);
        };

        class Cargo {
            PATHTO_FNC(addWeaponCargo);
            PATHTO_FNC(addMagazineCargo);
            PATHTO_FNC(addItemCargo);
            PATHTO_FNC(addBackpackCargo);
            PATHTO_FNC(removeWeaponCargo);
            PATHTO_FNC(removeMagazineCargo);
            PATHTO_FNC(removeItemCargo);
            PATHTO_FNC(removeBackpackCargo);
        };

        class Maps {
            PATHTO_FNC(northingReversed);
            PATHTO_FNC(mapGridToPos);
            PATHTO_FNC(mapRelPos);
            PATHTO_FNC(mapDirTo);
            PATHTO_FNC(getTerrainProfile);
            PATHTO_FNC(isTerrainObject);
        };

        class Positions {
            PATHTO_FNC(getArea);
            PATHTO_FNC(getDistance);
            PATHTO_FNC(getPos);
            PATHTO_FNC(setPos);
            PATHTO_FNC(realHeight);
            PATHTO_FNC(setHeight);
            PATHTO_FNC(randPos);
            PATHTO_FNC(randPosArea);
            PATHTO_FNC(getNearest);
            PATHTO_FNC(getNearestBuilding);
        };

        class Misc {
            PATHTO_FNC(addPerFrameHandler);
            PATHTO_FNC(removePerFrameHandler);
            PATHTO_FNC(createPerFrameHandlerObject);
            PATHTO_FNC(deletePerFrameHandlerObject);
            PATHTO_FNC(addPlayerAction);
            PATHTO_FNC(removePlayerAction);
            PATHTO_FNC(createNamespace);
            PATHTO_FNC(deleteNamespace);
            PATHTO_FNC(allNamespaces);
            PATHTO_FNC(directCall);
            PATHTO_FNC(objectRandom);
            PATHTO_FNC(execNextFrame);
            PATHTO_FNC(waitAndExecute);
            PATHTO_FNC(waitUntilAndExecute);
            PATHTO_FNC(compileFinal);
        };

        class Ui {
            PATHTO_FNC(getFov);
            PATHTO_FNC(getAspectRatio);
            PATHTO_FNC(getUISize);
        };

        class Broken {
            PATHTO_FNC(actionArgument);
        };
    };
};
