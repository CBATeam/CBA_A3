#include "script_component.hpp"

PREPMAIN(fDebug);
["Initializing...", QUOTE(ADDON), DEBUG_SETTINGS] call CBA_fDebug;

CREATELOGICLOCAL;

// Possibly convert to the variable namespace thing, taste:
SETVAR ["_init", false];
SETVAR ["_dead", false];
SETVAR ["_actionList", false];
ISNILMAIN(ActionList, []);
GVAR(debug) = []; // TODO: Evaluate if this is useful... Logging to rpt and using a tail reader seems okay too!

// Prepare BIS functions and precompile all functions we already have registered with it:
"FunctionsManager" createVehicleLocal [0, 0];

// Prepare all functions
PREPMAIN(fAddMagazine);
PREPMAIN(fAddMagazineCargo);
PREPMAIN(fAddWeapon);
PREPMAIN(fAddWeaponCargo);
PREPMAIN(fDetermineMuzzles);
PREPMAIN(fDropMagazine);
PREPMAIN(fDropWeapon);
PREPMAIN(fGetAnimType);
PREPMAIN(fGetConfigEntry);
PREPMAIN(fGetPistol);
PREPMAIN(fGetUnitAnim);
PREPMAIN(fGetUnitDeathAnim);
PREPMAIN(fGetVehicleAnim);
PREPMAIN(fHeadDir);

OBSOLETE(fMyWeapon,{ currentWeapon player });

PREPMAIN(fObjectRandom);
PREPMAIN(fPlayers);
PREPMAIN(fRealHeight);
PREPMAIN(fRemoveMagazine);
PREPMAIN(fRemoveWeapon);

OBSOLETE(fSelectedWeapon,{ currentWeapon _this });

DEPRECATE_SYS(PREFIX,fVectorSum3d,BIS,fnc_vectorAdd);

PREPMAIN(fAddMagazineVerified);
PREPMAIN(fCreateMarker);
PREPMAIN(fCreateTrigger);
PREPMAIN(fGetArg);
PREPMAIN(fInheritsFrom);
PREPMAIN(fNearPlayer);

DEPRECATE_SYS(PREFIX,fRndInt,BIS,fnc_randomInt);
DEPRECATE_SYS(PREFIX,fRndSelect,BIS,fnc_selectRandom);

PREPMAIN(fSelectWeapon);
PREPMAIN(fShuffle);
PREPMAIN(fSwitchPlayer);

// Initialize Components
CALLF(init_gauss);
CALLF(init_kron_strings);

// Announce Initialization Complete
SETVAR ["_init", true];