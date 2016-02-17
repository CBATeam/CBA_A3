// Any registered functions used in the PreINIT phase must use the uiNamespace copies of the variable.
// So uiNamespace getVariable "CBA_fnc_hashCreate" instead of just CBA_fnc_hashCreate -VM
#include "script_component.hpp"

LOG(MSG_INIT);

[QUOTE(GVAR(debug)), { _this call (uiNamespace getVariable "CBA_fnc_debug") }] call (uiNamespace getVariable "CBA_fnc_addEventHandler");

if (SLX_XEH_MACHINE select 3) then
{
    FUNC(handle_peak) =
    {
        params ["_variable"];
        if (isNil _variable) then
        {
            [QUOTE(GVAR(receive_peak)), [_variable, nil]] call (uiNamespace getVariable "CBA_fnc_globalEvent");
        } else {
            [QUOTE(GVAR(receive_peak)), [_variable, call compile _variable]] call (uiNamespace getVariable "CBA_fnc_globalEvent");
        };

    };
    [QUOTE(GVAR(peek)), { _this call CBA_fnc_handle_peak }] call (uiNamespace getVariable "CBA_fnc_addEventHandler");
};

PREP(perf_loop);

FUNC(logStatement) = {
    _display = uiNamespace getVariable "cba_diagnostic_display";
    _exe = _display displayCtrl 12284;
    _statement = ctrlText _exe;

    _index = uiNamespace getVariable ["cba_diagnostic_statementIndex", 0];

    _prevStatements = profileNamespace getVariable ["cba_diagnostic_statements", []];
    _update = true;
    if(count _prevStatements > 0) then {
        if((_prevStatements select 0) == _statement) then {
            _update = false;
        };
    };
    if(_update) then {
        _prevStatements = [_statement] + _prevStatements;

        if(count _prevStatements > 50) then {
            _prevStatements resize 50;
        };
        uiNamespace setVariable ["cba_diagnostic_statementIndex", 0];
        profileNamespace setVariable ["cba_diagnostic_statements", _prevStatements];
        if((count _prevStatements) > 1) then {
            _prevButton = _display displayCtrl 90110;
            _prevButton ctrlEnable true;
            _prevButton ctrlCommit 0;
        };
        _nextButton = _display displayCtrl 90111;
        _nextButton ctrlEnable false;
        _nextButton ctrlCommit 0;
    };
};

FUNC(debugPrevStatement) = {
    _index = uiNamespace getVariable ["cba_diagnostic_statementIndex", 0];
    _prevStatements = profileNamespace getVariable ["cba_diagnostic_statements", []];
    _index = ((_index + 1) min (((count _prevStatements)-1) max 0)) min 49;
    uiNamespace setVariable ["cba_diagnostic_statementIndex", _index];
    _prevStatement = _prevStatements select _index;

    _display = uiNamespace getVariable "cba_diagnostic_display";
    _exe = _display displayCtrl 12284;
    _exe ctrlSetText _prevStatement;

    if(_index > 0) then {
        _nextButton = _display displayCtrl 90111;
        _nextButton ctrlEnable true;
        _nextButton ctrlCommit 0;
    };

    if(_index == 49 || _index == (count _prevStatements)-1) then {
        _prevButton = _display displayCtrl 90110;
        _prevButton ctrlEnable false;
        _prevButton ctrlCommit 0;
    };
};

FUNC(debugNextStatement) = {
    _index = uiNamespace getVariable ["cba_diagnostic_statementIndex", 0];
    _prevStatements = profileNamespace getVariable ["cba_diagnostic_statements", []];
    _index = (_index - 1) max 0;
    uiNamespace setVariable ["cba_diagnostic_statementIndex", _index];
    _nextStatement = _prevStatements select _index;

    _display = uiNamespace getVariable "cba_diagnostic_display";
    _exe = _display displayCtrl 12284;
    _exe ctrlSetText _nextStatement;


    if((count _prevStatements) > 0) then {
        _prevButton = _display displayCtrl 90110;
        _prevButton ctrlEnable true;
        _prevButton ctrlCommit 0;
    };

    if(_index == 0) then {
        _nextButton = _display displayCtrl 90111;
        _nextButton ctrlEnable false;
        _nextButton ctrlCommit 0;
    };
};
