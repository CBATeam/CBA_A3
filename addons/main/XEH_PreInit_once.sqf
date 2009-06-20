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
PREPMAIN(fMyWeapon);
PREPMAIN(fObjectRandom);
PREPMAIN(fPlayers);
PREPMAIN(fRealHeight);
PREPMAIN(fRemoveMagazine);
PREPMAIN(fRemoveWeapon);
PREPMAIN(fSelectedWeapon);
PREPMAIN(fVectorSum3d);
PREPMAIN(fAddMagazineVerified);
PREPMAIN(fCreateMarker);
PREPMAIN(fCreateTrigger);
PREPMAIN(fGetArg);
PREPMAIN(fInheritsFrom);
PREPMAIN(fNearPlayer);
PREPMAIN(fRndInt);
PREPMAIN(fRndSelect);
PREPMAIN(fSelectWeapon);
PREPMAIN(fShuffle);
PREPMAIN(fSwitchPlayer);

// Execute scripts
EXECF(sGauss_Init);
EXECF(sKRON_Strings);

// Announce Initialization Complete
SETVAR ["_init", true];