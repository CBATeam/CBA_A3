#include "script_component.hpp"
SCRIPT(XEH_preInit);

LOG(MSG_INIT);

ADDON = false;

#include "XEH_PREP.hpp"
#include "initSettings.inc.sqf"


[QGVAR(debug), {_this call CBA_fnc_debug}] call CBA_fnc_addEventHandler;

GVAR(projectileData) = [];
GVAR(projectileDrawHandle) = nil;
GVAR(projectileIndex) = 0;
GVAR(projectileMaxLines) = 20;
GVAR(projectileStartedDrawing) = false;
GVAR(projectileTrackedUnits) = [];

if (getMissionConfigValue ["EnableTargetDebug", 0] == 1 || {getNumber (configFile >> "EnableTargetDebug") == 1}) then {
    INFO("EnableTargetDebug is enabled.");

    [QGVAR(watchVariable), {
        params ["_clientID", "_varIndex", "_statementText"];
        TRACE_3("targetWatchVariable",_clientID,_varIndex,_statementText);

        private _timeStart = diag_tickTime;
        private _returnString = _statementText call {
            private ["_clientID", "_statementText", "_varName", "_timeStart", "_x"]; // prevent these variables from being overwritten
            private _str = ([nil] apply compile _this) select 0;
            if (isNil "_str") exitWith {"<any>"};
            str _str
        };
        _returnString = _returnString select [0, 1000]; // limit string length
        private _duration = diag_tickTime - _timeStart;

        private _varName = format ["CBA_targetWatchVar_%1_%2", _clientID, _varIndex];
        (missionNamespace getVariable [_varName, []]) params [["_responseStatement", "", [""]], ["_responseReturn", "", [""]], ["_lastDuration", 0, [0]]];

        if (_responseStatement isEqualTo _statementText) then {
            _duration = 0.1 * _duration + 0.9 * _lastDuration; // if statement is the same, get an average
        };

        missionNamespace setVariable [_varName, [_statementText, _returnString, _duration]];
        if (_clientID != CBA_clientID) then {
            _clientID publicVariableClient _varName; // send back over network
        };
    }] call CBA_fnc_addEventHandler;


    if (isNil QGVAR(clientIDs)) then {
        GVAR(clientIDs) = [[2, format ["[SERVER] %1", profileName]]];
    };

    if (isServer) then {
        addMissionEventHandler ["PlayerConnected", {
            params ["", "", "_name", "", "_owner"];

            if (_owner == 2) exitWith {};
            GVAR(clientIDs) pushBackUnique [_owner, _name];
            publicVariable QGVAR(clientIDs);
        }];

        addMissionEventHandler ["PlayerDisconnected", {
            params ["", "", "_name", "", "_owner"];

            GVAR(clientIDs) deleteAt (GVAR(clientIDs) find [_owner, _name]);
            publicVariable QGVAR(clientIDs);
        }];
    };
};

ADDON = true;
