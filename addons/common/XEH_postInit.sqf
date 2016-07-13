// #define DEBUG_MODE_FULL
#include "script_component.hpp"

//Install PFEH:
addMissionEventHandler ["EachFrame", FUNC(onFrame)];

LOG(MSG_INIT);

// NOTE: Due to the way the BIS functions initializations work, and the requirement of BIS_functions_mainscope to be a unit (in a group)
//       the logic is created locally on MP dedicated client, to still allow this early, called precompilation of the functions.
//       But initialization doesn't officially finish until the official (server created / mission.sqm included) logic is available.
//         In SP or as server (dedicated or clientServer), the logic is created with group and createUnit.
0 spawn {
    waitUntil {!isNil "bis_functions_mainscope"};
    waitUntil {!isNull bis_functions_mainscope};
    CBA_logic = bis_functions_mainscope;
    #ifdef DEBUG_MODE_FULL
        diag_log [diag_frameNo, diag_tickTime, time, "BLA: Function module init true!"];
    #endif
};

// Upgrade check - Registry for removed addons, warn the user if found
// TODO: Evaluate registry of 'current addons' and verifying that against available CfgPatches
TRACE_1("Upgrade Check",nil);
#define CFG configFile >> "CfgSettings" >> "CBA" >> "registry"
private ["_entry"];
for "_i" from 0 to ((count (CFG)) - 1) do {
    _entry = (CFG) select _i;
    if (isClass(_entry) && {isArray(_entry >> "removed")}) then {
        {
            if (isClass(configFile >> "CfgPatches" >> _x)) then {
                format["WARNING: Found addon that should be removed: %1; Please remove and restart game", _x] call FUNC(log);
            };
        } forEach (getArray(_entry >> "removed"));
    };
};

// system to synch team colors
// Note: 1.62 added Multiplayer synchronization for assigned team
// Run the PFEH only if on previous versions, keep the event for backwards compatability

PREP(onTeamColorChanged);
PREP(synchTeamColors);

["CBA_teamColorChanged", FUNC(onTeamColorChanged)] call CBA_fnc_addEventHandler;

if (hasInterface && {(productVersion select 2) < 162}) then {
    [FUNC(synchTeamColors), 1, []] call CBA_fnc_addPerFrameHandler;

    if (didJIP) then {
        {
            private _team = _x getVariable [QGVAR(synchedTeam), ""];
            if (_team != "") then {
                _x assignTeam _team;
            };
            true
        } count allUnits;
    };
};

//Event for switching vehicle var names from CBA_fnc_switchPlayer
["CBA_setVehicleVarName", {
    params ["_oldVeh", "_newVeh", "_vehName"];
    _oldVeh setVehicleVarName "";
    _newVeh setVehicleVarName _vehName;
}] call CBA_fnc_addEventHandler;
