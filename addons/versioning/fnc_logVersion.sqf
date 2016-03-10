/* ----------------------------------------------------------------------------
Function: CBA_fnc_logVersion

Description:
    Logs addon version numbers in RPT file.

Parameters:
    _mode - 0: local versions, 1: server versions (meant for client) <NUMBER>

Example:
    (begin example)
        0 call CBA_fnc_logVersion;
    (end)

Returns:
    None

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(formatVersionNumber);

params [["_mode", 0, [0]]];

if !(SLX_XEH_DisableLogging) then {
    private _messageAr = [];

    private _hash = [GVAR(versions), GVAR(versionsServ)] select _mode;

    [_hash, {
        _value params ["_version"];
        _version = _version call CBA_fnc_formatVersionNumber;

        _messageAr pushBack format ["%1 v%2", _key, _version];
    }] CBA_fnc_hashEachPair;

    private _message = ["CBA Versioning: ", "CBA Versioning Server: "] select _mode;
    _message = _message + (_messageAr joinString ", ");

    diag_log [diag_frameNo, diag_tickTime, time, _message];
};
