#include "script_component.hpp"
SCRIPT(XEH_PreInit_once);
   
// Prepare BIS functions/MP and precompile all functions we already have registered with it:
// NOTE: This functions module is local rather than global, but there is no reason that this should
//       affect anything adversely. Well, unless someone foolishly makes use of that assumption...
_functionsModule = "FunctionsManager" createVehicleLocal [0, 0];
[_functionsModule] CALLF(init_functionsModule);
LOG("Initialising the Functions module early.");
if (isnil "RE") then
{
	LOG("Initialising the MP module early.");
	_this call compile preprocessFileLineNumbers ("\ca\Modules\MP\data\scripts\MPframework.sqf");
};

["Initializing...", QUOTE(ADDON), DEBUGSETTINGS] call CBA_fnc_Debug;

ADDON = false;

ISNILMAIN(ActionList, []);

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

DEPRECATE_SYS(PREFIX,fVectorSum3d,BIS,fnc_vectorAdd);

DEPRECATE(fAddMagazineVerified,fnc_addMagazineVerified);
DEPRECATE(fCreateMarker,fnc_createMarker);
DEPRECATE(fCreateTrigger,fnc_createTrigger);
DEPRECATE(fGetArg,fnc_getArg);
DEPRECATE(fInheritsFrom,fnc_inheritsFrom);
DEPRECATE(fNearPlayer,fnc_nearPlayer);

DEPRECATE_SYS(PREFIX,fRndInt,BIS,fnc_randomInt);
DEPRECATE_SYS(PREFIX,fRndSelect,BIS,fnc_selectRandom);

DEPRECATE(fSelectWeapon,fnc_selectWeapon);
DEPRECATE(fShuffle,fnc_shuffle);
DEPRECATE(fSwitchPlayer,fnc_switchPlayer);

// Initialize Components
CALLF(init_gauss);
CALLF(init_kron_strings);

// Announce Initialization Complete
ADDON = true;
