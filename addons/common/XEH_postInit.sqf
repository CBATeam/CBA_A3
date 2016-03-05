// #define DEBUG_MODE_FULL
#include "script_component.hpp"

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

private _oldPFH = isNil "BIS_fnc_addStackedEventHandler";

FUNC(initPerFrameHandlers) = {
    if (_this) then {
        7771 cutRsc ["CBA_FrameHandlerTitle", "PLAIN"];
    } else {
        // Use the new, stacked onEachFrame system
        ["CBA_PFH", "onEachFrame", QUOTE(FUNC(onFrame))] call BIS_fnc_addStackedEventHandler;
    };

    GVAR(lastFrameRender) = diag_frameNo;
    // Use a trigger, runs every 0.5s, unscheduled execution
    GVAR(perFrameTrigger) = createTrigger ["EmptyDetector", [0,0,0], false];
    GVAR(perFrameTrigger) setTriggerStatements [QUOTE(call FUNC(monitorFrameRender)), "", ""];
};

// Run the per frame handler init code, bringing up the hidden map control
_oldPFH call FUNC(initPerFrameHandlers);

// system to synch team colors
PREP(onTeamColorChanged);
PREP(synchTeamColors);

["CBA_teamColorChanged", FUNC(onTeamColorChanged)] call CBA_fnc_addEventHandler;

if (hasInterface) then {
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
