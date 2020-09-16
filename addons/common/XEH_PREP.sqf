// Config
PREPMAIN(getConfigEntry);
PREPMAIN(getObjectConfig);
PREPMAIN(getItemConfig);
PREPMAIN(getMuzzles);
PREPMAIN(getWeaponModes);
PREPMAIN(inheritsFrom);
PREPMAIN(getTurret);
PREPMAIN(getNonPresetClass);

// Entities
PREPMAIN(findEntity);
PREPMAIN(deleteEntity);
PREPMAIN(isAlive);
PREPMAIN(getAlive);
PREPMAIN(getGroup);
PREPMAIN(getSharedGroup);
PREPMAIN(nearPlayer);
PREPMAIN(getArg);
PREPMAIN(createMarker);
PREPMAIN(createTrigger);
PREPMAIN(getGroupIndex);
PREPMAIN(getMagazineIndex);
PREPMAIN(currentMagazineIndex);
PREPMAIN(setCallsign);
PREPMAIN(getActiveFeatureCamera);
PREPMAIN(registerFeatureCamera);

// Soldiers
PREPMAIN(isPerson);
PREPMAIN(canUseWeapon);
PREPMAIN(selectWeapon);
PREPMAIN(switchPlayer);
PREPMAIN(currentUnit);
PREPMAIN(players);

// Vehicles
PREPMAIN(getFirer);
PREPMAIN(isTurnedOut);
PREPMAIN(getVolume);
PREPMAIN(vehicleRole);
PREPMAIN(turretPath);
PREPMAIN(turretPathWeapon);
PREPMAIN(viewDir);
PREPMAIN(turretDir);

// Animations
PREPMAIN(getAnimType);
PREPMAIN(getUnitAnim);
PREPMAIN(getUnitDeathAnim);
PREPMAIN(isUnitGetOutAnim);
PREPMAIN(headDir);
PREPMAIN(modelHeadDir);

// Inventory
PREPMAIN(addWeapon);
PREPMAIN(addWeaponWithoutItems);
PREPMAIN(addMagazine);
PREPMAIN(addItem);
PREPMAIN(compatibleMagazines);
PREPMAIN(removeWeapon);
PREPMAIN(removeMagazine);
PREPMAIN(removeItem);
PREPMAIN(uniqueUnitItems);
PREPMAIN(weaponComponents);
PREPMAIN(dropWeapon);
PREPMAIN(dropMagazine);
PREPMAIN(dropItem);
PREPMAIN(binocularMagazine);
PREPMAIN(addBinocularMagazine);
PREPMAIN(removeBinocularMagazine);
PREPMAIN(randomizeFacewear);

// Cargo
PREPMAIN(addWeaponCargo);
PREPMAIN(addMagazineCargo);
PREPMAIN(addItemCargo);
PREPMAIN(addBackpackCargo);
PREPMAIN(removeWeaponCargo);
PREPMAIN(removeMagazineCargo);
PREPMAIN(removeItemCargo);
PREPMAIN(removeBackpackCargo);

// Map
PREPMAIN(northingReversed);
PREPMAIN(mapGridToPos);
PREPMAIN(mapRelPos);
PREPMAIN(mapDirTo);
PREPMAIN(getTerrainProfile);
PREPMAIN(isTerrainObject);

// Position
PREPMAIN(getArea);
PREPMAIN(getDistance);
PREPMAIN(getPos);
PREPMAIN(setPos);
PREPMAIN(realHeight);
PREPMAIN(setHeight);
PREPMAIN(randPos);
PREPMAIN(randPosArea);
PREPMAIN(getNearest);
PREPMAIN(getNearestBuilding);

// Miscellaneous
PREPMAIN(addPerFrameHandler);
PREPMAIN(removePerFrameHandler);
PREPMAIN(createPerFrameHandlerObject);
PREPMAIN(deletePerFrameHandlerObject);
PREPMAIN(addPlayerAction);
PREPMAIN(removePlayerAction);
PREPMAIN(createNamespace);
PREPMAIN(deleteNamespace);
PREPMAIN(allNamespaces);
PREPMAIN(directCall);
PREPMAIN(objectRandom);
PREPMAIN(execNextFrame);
PREPMAIN(waitAndExecute);
PREPMAIN(waitUntilAndExecute);
PREPMAIN(compileFinal);

// Broken / Legacy
PREPMAIN(actionArgument);
