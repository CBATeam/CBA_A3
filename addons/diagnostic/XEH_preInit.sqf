#include "script_component.hpp"
SCRIPT(XEH_preInit);

LOG(MSG_INIT);

ADDON = false;

#include "XEH_PREP.sqf"

[QGVAR(debug), {_this call CBA_fnc_debug}] call CBA_fnc_addEventHandler;

GVAR(projectileData) = [];
GVAR(projectileDrawHandle) = nil;
GVAR(projectileIndex) = 0;
GVAR(projectileMaxLines) = 20;
GVAR(projectileStartedDrawing) = false;
GVAR(projectileTrackedUnits) = [];

ADDON = true;

if !(getMissionConfigValue ["enableServerDebug", 0] isEqualTo 1) exitWith {};

if (isNil QGVAR(clientIDs)) then {
    GVAR(clientIDs) = [[2, profileName]];
};

if (isServer) then {
    addMissionEventHandler ["PlayerConnected", {
        params ["", "", "_name", "", "_owner"];

        GVAR(clientIDs) pushBackUnique [_owner, _name];
        publicVariable QGVAR(clientIDs);
    }];

    addMissionEventHandler ["PlayerDisconnected", {
        params ["", "", "_name", "", "_owner"];

        GVAR(clientIDs) deleteAt (GVAR(clientIDs) find [_owner, _name]);
        publicVariable QGVAR(clientIDs);
    }];
};
