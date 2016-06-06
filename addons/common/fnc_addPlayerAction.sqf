/*
Function: CBA_fnc_addPlayerAction

Description:
    Adds persistent action to the player.

    The action will be available in vehicles and after respawn or teamswitch.

    Remove action with <CBA_fnc_removePlayerAction>. *Do not* use standard
    removeAction command with these player-action indices!

Parameters:
    _actionArray - Array that defines the action, as used in addAction command [Array]

Returns:
    Index of action if added. -1 if used on a dedicated server [Number]

Example:
    (begin example)
        _actionIndex = [["Teleport", "teleport.sqf"]] call CBA_fnc_addPlayerAction;
    (end)

Author:
    Sickboy

*/
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_actionArray"];
TRACE_1(_this);

private _return = if (isDedicated) then {
    WARNING("Function ran on a dedicated server. Function only usable on a client. Action: " + str _actionArray);
    -1; // Invalid action number.
} else {
    if (!GVAR(actionListPFEH)) then {
        LOG("Action monitor started");
        GVAR(actionIndexes) = [];
        GVAR(actionListPFEH) = true;
        private _fnc = {
            params ["_params"];
            _params params ["_prevVic"];
            private _curVic  = vehicle player;
            if (isNull player) exitWith {};
            if (GVAR(actionListUpdated) || {_curVic != _prevVic}) then {
                TRACE_4("update",GVAR(actionListUpdated),_curVic,_prevVic,GVAR(actionIndexes));
                if (count GVAR(actionIndexes) > 0) then {
                    { _prevVic removeAction _x; } forEach GVAR(actionIndexes);
                    GVAR(actionIndexes) = [];
                };
                GVAR(actionListUpdated) = false;
                [GVAR(actionList), {
                    TRACE_3("Inside the code for the hashPair",(vehicle player),GVAR(actionIndexes), _value);
                    if ((!isNil "_value") && {_value isEqualType []}) then {
                        GVAR(actionIndexes) pushBack (_curVic addAction _value);
                    };
                }] call CBA_fnc_hashEachPair;
            };
            _params set [0, (vehicle player)];
        };
        [_fnc, 1, [vehicle player]] call CBA_fnc_addPerFrameHandler;
    };

    private _index = GVAR(nextActionIndex);
    [GVAR(actionList), _index, _actionArray] call CBA_fnc_hashSet;
    GVAR(actionListUpdated) = true;
    INC(GVAR(nextActionIndex));
    _index;
};

_return;

