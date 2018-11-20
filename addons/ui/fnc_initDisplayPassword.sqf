#include "script_component.hpp"

if (profileNamespace getVariable [QGVAR(StorePasswords), 1] < 1) exitWith {};

params ["_display"];
private _ctrlConfirm = _display displayCtrl IDC_OK;
private _ctrlPassword = _display displayCtrl IDC_PASSWORD;
private _ctrlServerList = (uinamespace getVariable "RscDisplayMultiplayer") displayCtrl IDC_MULTI_SESSIONS;

_ctrlConfirm ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlConfirm"];
    private _display = ctrlParent _ctrlConfirm;
    private _ctrlPassword = _display displayCtrl IDC_PASSWORD;
    private _ctrlServerList = (uinamespace getVariable "RscDisplayMultiplayer") displayCtrl IDC_MULTI_SESSIONS;

    private _server = _ctrlServerList lbData lbCurSel _ctrlServerList;
    private _password = ctrlText _ctrlPassword;
    //diag_log ["write", _server, _password];

    // store password in cache
    private _passwordCache = profileNamespace getVariable [QGVAR(ServerPasswords), [[], []]];
    private _index = (_passwordCache select 0) find _server;
    if (_index isEqualTo -1) then {
        _index = (_passwordCache select 0) pushBack _server;
    };
    (_passwordCache select 1) set [_index, _password];
    profileNamespace setVariable [QGVAR(ServerPasswords), _passwordCache];
    saveProfileNamespace;
}];

private _server = _ctrlServerList lbData lbCurSel _ctrlServerList;

// read password from cache
private _passwordCache = profileNamespace getVariable [QGVAR(ServerPasswords), [[], []]];
private _index = (_passwordCache select 0) find _server;
private _password = (_passwordCache select 1) param [_index, ""];
//diag_log ["read", _server, _password];

if (_password != "") then {
    _ctrlPassword ctrlSetText _password;
};
