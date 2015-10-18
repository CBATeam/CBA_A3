// #define DEBUG_MODE_FULL
#include "script_component.hpp"

LOG(MSG_INIT);

// if (true) exitWith {};

// NOTE: Due to the way the BIS functions initializations work, and the requirement of BIS_functions_mainscope to be a unit (in a group)
//       the logic is created locally on MP dedicated client, to still allow this early, called precompilation of the functions.
//       But initialization doesn't officially finish until the official (server created / mission.sqm included) logic is available.
//         In SP or as server (dedicated or clientServer), the logic is created with group and createUnit.
SLX_XEH_STR spawn {
    waitUntil {!isNil "bis_functions_mainscope"};
    waitUntil {!isNull bis_functions_mainscope};
    CBA_logic = bis_functions_mainscope;
    #ifdef DEBUG_MODE_FULL
        diag_log [diag_frameNo, diag_tickTime, time, "BLA: Function module init true!"];
    #endif
};

// A2 / Operation Arrowhead, standalone / combined operations check
/*
TRACE_1("OA Check",nil);
private ["_hasCbaOa", "_hasCbaA2", "_hasA2", "_hasOa"];
_hasCbaA2 = isClass(configFile >> "CfgPatches" >> "CBA_A2_main");
_hasCbaOa = isClass(configFile >> "CfgPatches" >> "CBA_OA_main");
_hasA2 = isClass(configFile >> "CfgPatches" >> "Chernarus");
_hasOa = isClass(configFile >> "CfgPatches" >> "Takistan");

if (_hasA2 && !_hasCbaA2) then { "Running A2 Content but missing @CBA_A2, please install and enable @CBA_A2, or disable A2 content" spawn FUNC(log) };
if (_hasOA && !_hasCbaOA) then { "Running OA Content but missing @CBA_OA, please install and enable @CBA_OA, or disable OA content" spawn FUNC(log) };
if (!_hasA2 && _hasCbaA2) then { "Not Running A2 Content but running @CBA_A2, please disable @CBA_A2 or enable A2 content" spawn FUNC(log) };
if (!_hasOa && _hasCbaOa) then { "Not Running OA Content but running @CBA_OA, please disable @CBA_OA or enable OA content" spawn FUNC(log) };
 */

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
                format["WARNING: Found addon that should be removed: %1; Please remove and restart game", _x] spawn FUNC(log);
            };
        } forEach (getArray(_entry >> "removed"));
    };
};

private ["_oldPFH"];
_oldPFH = isNil "BIS_fnc_addStackedEventHandler";

FUNC(initPerFrameHandlers) = {
    if (_this) then {
        7771 cutRsc ["CBA_FrameHandlerTitle", "PLAIN"];
    } else {
        // Use the new, stacked onEachFrame system
        ["CBA_PFH", "onEachFrame", QUOTE(FUNC(onFrame))] call BIS_fnc_addStackedEventHandler;
    };

    GVAR(lastFrameRender) = diag_frameNo;
    // Use a trigger, runs every 0.5s, unscheduled execution
    GVAR(perFrameTrigger) = createTrigger["EmptyDetector", [0,0,0]];
    GVAR(perFrameTrigger) setTriggerStatements[QUOTE(call FUNC(monitorFrameRender)), "", ""];
};

// Run the per frame handler init code, bringing up the hidden map control
if (_oldPFH && {!CBA_MISSION_START}) then {
    ["CBA_MISSION_START", { _oldPFH call FUNC(initPerFrameHandlers) }] call CBA_fnc_addEventHandler;
} else {
    _oldPFH call FUNC(initPerFrameHandlers);
};

GVAR(actionIndexes) = [];
if !(isDedicated) then {
    SLX_XEH_STR spawn
    {
        waitUntil {!isNil QGVAR(nextActionIndex)};
        LOG("Action monitor started");
        _fnc = {
            _params  = _this select 0;
            _prevVic = _params select 0;
            _curVic  = vehicle player;
            if (isNull player) exitWith {};
            if (GVAR(actionListUpdated) || (_curVic != _prevVic) && (count GVAR(actionIndexes) > 0)) then
            {
                _vic = if (_curVic != _prevVic) then {_prevVic} else {_curVic};
                { _vic removeAction _x; } forEach GVAR(actionIndexes);
                GVAR(actionIndexes) = [];
            };
            if (GVAR(actionListUpdated) || (_curVic != _prevVic)) then
            {
                GVAR(actionListUpdated) = false;
                [GVAR(actionList), {
                    TRACE_3("Inside the code for the hashPair",(vehicle player),GVAR(actionIndexes), _value);
                    if (!isNil "_value" && typeName(_value) == "ARRAY") then {
                        PUSH(GVAR(actionIndexes), (vehicle player) addAction _value)
                    };
                }] call CBA_fnc_hashEachPair;
            };
            _params set [0, (vehicle player)];
        };
        [_fnc, 1, [vehicle player]] call CBA_fnc_addPerFrameHandler;
    };
};

// TODO: Consider a waitUntil loop with tickTime check to wait for some frames as opposed to trying to sleep until time > 0. Re MP Briefings etc.
/*
[CBA_COMMON_ADDONS] spawn {
    params ["_addons"];
    TRACE_1("Activating addons",nil);
    activateAddons _addons;
    sleep 0.001;
    if (SLX_XEH_MACHINE select 1) then { sleep 0.001 }; // JIP, sleep uses time, and time skips for JIP.
    TRACE_1("Activating addons",nil);
    activateAddons _addons;
};
*/

if (hasInterface) then {
    ["CBA_teamColorChanged", CBA_fnc_onTeamColorChanged] call CBA_fnc_addEventHandler;
    [CBA_fnc_synchTeamColors, 0, []] call CBA_fnc_addPerFrameHandler;
};
