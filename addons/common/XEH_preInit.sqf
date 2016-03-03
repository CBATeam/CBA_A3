//#define DEBUG_MODE_FULL
#include "script_component.hpp"
SCRIPT(XEH_preInit);

[] call COMPILE_FILE(init_functionsModule); // @todo

LOG(MSG_INIT);

ADDON = false;

CBA_logic = objNull;

// FSM
GVAR(delayless) = QUOTE(PATHTOF(delayless.fsm));
GVAR(delayless_loop) = QUOTE(PATHTOF(delayless_loop.fsm));

// Initialize Components
GVAR(groups) = [grpNull, grpNull, grpNull, grpNull, grpNull];

call COMPILE_FILE(init_gauss);
call COMPILE_FILE(init_perFrameHandler);
call COMPILE_FILE(init_delayLess);

// Due to activateAddons being overwritten by eachother (only the last executed command will be active), we apply this bandaid
private _addons = ("true" configClasses (configFile >> "CfgPatches")) apply {configName _x};

activateAddons _addons;
GVAR(addons) = _addons;

// BWC
#include "backwards_comp.sqf"

ADDON = true;
