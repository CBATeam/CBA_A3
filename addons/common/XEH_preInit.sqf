#include "script_component.hpp"
SCRIPT(XEH_preInit);

CBA_nil = [nil];

/*
 * Prepare BIS functions/MP and precompile all functions we already have
 * registered with it. In order to have the functions loaded early,
 * we do so in the "init_functionsModule" script. However, to make sure
 * everything is done properly, we also create a new BIS functions manager
 * module so that the whole BIS MP and functions framework is initialised
 * completely. (We need to do it this way since the BIS function manager
 * defers initialisation by way of execVM:ing its init script.)
 *
 * Yes, there's some redundancy in that the functions will be
 * loaded and preprocessed twice, but this should only occur once per mission
 * and will hopefully ensure forward compatibility with future ArmA II patches.
 */
[objNull] call COMPILE_FILE(init_functionsModule);

LOG(MSG_INIT);
call COMPILE_FILE(init);
LOG("Initialising the Functions module early.");

ADDON = false;

GVAR(centers) = [];
CBA_actionHelper = QUOTE(PATHTO(actionHelper));
GVAR(delayless) = QUOTE(PATHTOF(delayless.fsm));
GVAR(delayless_loop) = QUOTE(PATHTOF(delayless_loop.fsm));

[] spawn {
	if !(isMultiplayer) exitWith {};
	if (isDedicated) exitWith {};
	waitUntil {isServer};
	diag_log [diag_frameNo, diag_tickTime, time, "WARNING: isServer is true while isDedicated is false; You can safely ignore this if this is a hosted game; otherwise please report asap"];
};

// DirectCall, using single-frame-code-executioner by Xeno
// The directCall function will execute (with parameters) next frame, and without delay
// [[1,2,3], {mycode to execute}] call FUNC(directCall);
// _obj = [[1,2,3], {mycode to execute}] call FUNC(directCall); waitUntil {isNull _obj}; // waits until the code has completed
GVAR(call_i) = 0; 
FUNC(directCallInt) = { (_this getVariable QUOTE(GVAR(params))) call (_this getVariable QUOTE(GVAR(code))); deleteVehicle _this };
FUNC(directCall) = {
	private ["_obj", "_objName"];
	PARAMS_2(_params,_code);

	INC(GVAR(call_i));
	_objName = format[QUOTE(GVAR(call_obj_%1)), GVAR(call_i)];
	_obj = "HeliHEmpty" createVehicleLocal [0, 0, 0];
	missionNameSpace setVariable [_objName, _obj];
	_obj setVariable [QUOTE(GVAR(params)), _params];
	_obj setVariable [QUOTE(GVAR(code)), _code];
	_obj addEventHandler ["killed", compile format[QUOTE(%1 call FUNC(directCallInt); %1 = nil), _objName]];
	_obj setDamage 1;
	_obj;
};


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

call COMPILE_FILE(init_perFrameHandler);

// NOTE: Due to activateAddons being overwritten by eachother (only the last executed command will be active), we apply this bandaid
[] call compile preProcessFileLineNumbers QUOTE(PATHTO_F(init_addons));

[] call compile preProcessFileLineNumbers QUOTE(PATHTO_F(init_delayLess));

// Announce Initialization Complete
ADDON = true;
