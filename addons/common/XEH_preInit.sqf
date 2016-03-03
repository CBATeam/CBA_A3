// Any registered functions used in the PreINIT phase must use the uiNamespace copies of the variable.
// So uiNamespace getVariable "CBA_fnc_hashCreate" instead of just CBA_fnc_hashCreate -VM
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
SCRIPT(XEH_preInit);

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

/*
if (isNil "RE" && isNil "BIS_MPF_logic") then
{
    LOG("Initialising the MP module early.");
    _this call COMPILE_FILE2(\ca\Modules\MP\data\scripts\MPframework.sqf);
};
*/

[] call COMPILE_FILE(init_functionsModule);
LOG(MSG_INIT);
// if (true) exitWith {};

ADDON = false;

CBA_nil = [nil];
GVAR(centers) = [];
CBA_actionHelper = QUOTE(PATHTO(actionHelper));
GVAR(delayless) = QUOTE(PATHTOF(delayless.fsm));
GVAR(delayless_loop) = QUOTE(PATHTOF(delayless_loop.fsm));

// DirectCall, using single-frame-code-executioner
// The directCall function will execute (with parameters) next frame, and without delay
// [[1,2,3], {mycode to execute}] call FUNC(directCall);
// _obj = [[1,2,3], {mycode to execute}] call FUNC(directCall); waitUntil {isNull _obj}; // waits until the code has completed
FUNC(directCall) = {
    private "_o";
    params ["_params","_code"];
    _o = SLX_XEH_DUMMY createVehicleLocal [0, 0, 0];
    ["CBA_DC", "onEachFrame", {
        params ["_args", "_code", "_o"];
        _args call _code;
        _o setDamage 1;
        ["CBA_DC", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
    }, [_params, _code, _o]] call BIS_fnc_addStackedEventHandler;
    _o
};

CBA_logic = objNull;

FUNC(log) = {
    diag_log text _this;
    sleep 1;
    systemChat _this;
    hintC _this;
};

// Nil check
ISNILS(CBA_NIL_CHECKED,false);

// bwc
CBA_fnc_getPistol = {params [["_unit", objNull, [objNull]]]; handgunWeapon _unit};
CBA_fnc_players = {allPlayers};
CBA_fnc_systemChat = {params [["_message", "", [""]]]; systemChat _message;};

CBA_fnc_determineMuzzles = CBA_fnc_getMuzzles;

CBA_fnc_addWeaponCargoGlobal = CBA_fnc_addWeaponCargo;
CBA_fnc_addMagazineCargoGlobal = CBA_fnc_addMagazineCargo;
CBA_fnc_removeWeaponCargoGlobal = CBA_fnc_removeWeaponCargo;
CBA_fnc_removeMagazineCargoGlobal = CBA_fnc_removeMagazineCargo;
CBA_fnc_removeItemCargoGlobal = CBA_fnc_removeItemCargo;
CBA_fnc_removeBackpackCargoGlobal = CBA_fnc_removeBackpackCargo;

// Initialize Components
GVAR(groups) = [grpNull, grpNull, grpNull, grpNull, grpNull];
call COMPILE_FILE(init_gauss);

call COMPILE_FILE(init_tables);

call COMPILE_FILE(init_perFrameHandler);

// NOTE: Due to activateAddons being overwritten by eachother (only the last executed command will be active), we apply this bandaid
call COMPILE_FILE(init_addons);

call COMPILE_FILE(init_delayLess);

// Announce Initialization Complete
ADDON = true;
