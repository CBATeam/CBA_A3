#include "script_component.hpp"
SCRIPT(XEH_PreInit_once);

#define CREATE_CENTER _center = createCenter sideLogic
#define CREATE_GROUP _group = createGroup sideLogic
   
// Prepare BIS functions/MP and precompile all functions we already have registered with it:
// NOTE: Due to the way the BIS functions initializations work, and the requirement of BIS_functions_mainscope to be a unit (in a group)
//       the logic is created locally on MP dedicated client, to still allow this early, called precompilation of the functions.
//       But initialization doesn't officially finish until the official (server created / mission.sqm included) logic is available.
//		 In SP or as server (dedicated or clientServer), the logic is created with group and createUnit.
private ["_center", "_group", "_logic"];
if (isNil "BIS_functions_mainscope") then
{
	if (isServer) then
	{
		CREATE_GROUP;
		if (isNil "_group") then
		{
			CREATE_CENTER;
			CREATE_GROUP;
		} else {
			if (isNull _group) then { CREATE_CENTER; CREATE_GROUP };
		};
		_logic = _group createUnit ["FunctionsManager", [0,0,0], [], 0, "none"];
	} else {
		// TODO: Evaluate cleanup for this one
		_logic = "LOGIC" createVehicleLocal [0, 0];
	};
} else {
	_logic = BIS_functions_mainscope;
};

[_logic] call COMPILE_FILE(init_functionsModule);
LOG("Initialising the Functions module early.");
if (isnil "RE") then
{
	LOG("Initialising the MP module early.");
	_this call compile preprocessFileLineNumbers "\ca\Modules\MP\data\scripts\MPframework.sqf";
};

LOG("Initializing: " + QUOTE(ADDON));

ADDON = false;

ISNILMAIN(ActionList,[]);

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
call COMPILE_FILE(init_gauss);
call COMPILE_FILE(init_kron_strings);

OBSOLETE_SYS(KRON,StrUpper,{ toUpper (_this select 0) });
OBSOLETE_SYS(KRON,StrLower,{ toLower (_this select 0) });
DEPRECATE_SYS(KRON,StrIndex,CBA,fnc_find); // CBA_fnc_find does the same and more.
DEPRECATE_SYS(KRON,StrLen,CBA,fnc_strLen);
DEPRECATE_SYS(KRON,StrToArray,CBA,fnc_split); // CBA_fnc_split does the same and more.
DEPRECATE_SYS(KRON,Replace,CBA,fnc_replace); // KRON is faster, but CBA one is 1 line (reuses other functions).

// Announce Initialization Complete
ADDON = true;
