#include "script_component.hpp"
SCRIPT(XEH_preInit);

#define CREATE_CENTER _center = createCenter sideLogic
#define CREATE_GROUP _group = createGroup sideLogic
   
// Prepare BIS functions/MP and precompile all functions we already have registered with it:
private ["_logic"];
_logic = "LOGIC" createVehicleLocal [0,0,0]; // TODO: Removal

[_logic] call COMPILE_FILE(init_functionsModule);
LOG("Initialising the Functions module early.");

LOG(MSG_INIT);

ADDON = false;

// Prepare all functions
DEPRECATE(fAddMagazine,fnc_addMagazine);
DEPRECATE(fAddMagazineCargo,fnc_addMagazineCargo);
DEPRECATE(fAddWeapon,fnc_addWeapon);
DEPRECATE(fAddWeaponCargo,fnc_addWeaponCargo);
DEPRECATE(fDetermineMuzzles,fnc_determineMuzzles);
DEPRECATE(fDropMagazine,fnc_dropMagazine);
DEPRECATE(fDropWeapon,fnc_dropWeapon);
DEPRECATE(fGetAnimType,fnc_getAnimType);
DEPRECATE(fGetConfigEntry,fnc_getConfigEntry);
DEPRECATE(fGetPistol,fnc_getPistol);
DEPRECATE(fGetUnitAnim,fnc_getUnitAnim);
DEPRECATE(fGetUnitDeathAnim,fnc_getUnitDeathAnim);
DEPRECATE(fGetVehicleAnim,fnc_isTurnedOut);
DEPRECATE(fHeadDir,fnc_headDir);

OBSOLETE(fMyWeapon,{ currentWeapon player });

DEPRECATE(fObjectRandom,fnc_objectRandom);
DEPRECATE(fPlayers,fnc_players);
DEPRECATE(fRealHeight,fnc_realHeight);
DEPRECATE(fRemoveMagazine,fnc_removeMagazine);
DEPRECATE(fRemoveWeapon,fnc_removeWeapon);

OBSOLETE(fSelectedWeapon,{ currentWeapon _this });

DEPRECATE_SYS(DOUBLES(PREFIX,fVectorSum3d),BIS_fnc_vectorAdd);

DEPRECATE(fAddMagazineVerified,fnc_addMagazineVerified);
DEPRECATE(fCreateMarker,fnc_createMarker);
DEPRECATE(fCreateTrigger,fnc_createTrigger);
DEPRECATE(fGetArg,fnc_getArg);
DEPRECATE(fInheritsFrom,fnc_inheritsFrom);
DEPRECATE(fNearPlayer,fnc_nearPlayer);

DEPRECATE_SYS(DOUBLES(PREFIX,fRndInt),BIS_fnc_randomInt);
DEPRECATE_SYS(DOUBLES(PREFIX,fRndSelect),BIS_fnc_selectRandom);

DEPRECATE(fSelectWeapon,fnc_selectWeapon);
DEPRECATE(fShuffle,fnc_shuffle);
DEPRECATE(fSwitchPlayer,fnc_switchPlayer);

// Initialize Components
GVAR(groups) = [grpNull, grpNull, grpNull, grpNull, grpNull];
call COMPILE_FILE(init_gauss);
call COMPILE_FILE(init_kron_strings);

OBSOLETE_SYS(KRON_StrUpper,{ toUpper (_this select 0) });
OBSOLETE_SYS(KRON_StrLower,{ toLower (_this select 0) });
DEPRECATE_SYS(KRON_StrIndex,DOUBLES(PREFIX,fnc_find)); // CBA_fnc_find does the same and more.
DEPRECATE_SYS(KRON_StrLen,DOUBLES(PREFIX,fnc_strLen));
DEPRECATE_SYS(KRON_StrToArray,DOUBLES(PREFIX,fnc_split)); // CBA_fnc_split does the same and more.
DEPRECATE_SYS(KRON_Replace,DOUBLES(PREFIX,fnc_replace)); // KRON is faster, but CBA one is 1 line (reuses other functions).

// Announce Initialization Complete
ADDON = true;
