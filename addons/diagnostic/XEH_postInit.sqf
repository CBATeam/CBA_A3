#include "script_component.hpp"
SCRIPT(XEH_postInit);

if !(getMissionConfigValue ["enableServerDebug", 0] isEqualTo 1) exitWith {};

INFO("enableServerDebug is enabled");

[QGVAR(watchVariable), {
    params ["_clientID", "_varIndex", "_statementText"];
    TRACE_3("serverWatchVariable",_clientID,_varIndex,_statementText);

    private _timeStart = diag_tickTime;
    private _returnString = _statementText call{
        private ["_clientID", "_statementText", "_varName", "_timeStart", "_x"];
        _this = ([nil] apply compile _this) select 0;
        if (isNil "_this") exitWith {"#NIL"};
        str _this
    };
    _returnString = _returnString select [0, 1000]; // limit string length
    private _duration = diag_tickTime - _timeStart;

    private _varName = format ["CBA_serverWatchVar_%1_%2", _clientID, _varIndex];
    (missionNamespace getVariable [_varName, []]) params [["_responseStatement", "", [""]], ["_responseReturn", "", [""]], ["_lastDuration", 0, [0]]];
    if (_responseStatement isEqualTo _statementText) then {_duration = 0.1 * _duration + 0.9 * _lastDuration;}; // if statement is the same, get an average

    missionNamespace setVariable [_varName, [_statementText, _returnString, _duration]];
    if (_clientID != CBA_clientID) then {
        publicVariable _varName; // send back over network
    };
}] call CBA_fnc_addEventHandler;
