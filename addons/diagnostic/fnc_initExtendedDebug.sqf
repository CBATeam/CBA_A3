#include "script_component.hpp"

#define DEBUG_CONSOLE   (_display displayCtrl 13184)
#define MOVIE_PAUSE (_display displayCtrl 1004)
#define YPOS(y) (y * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))

disableSerialization;

params ["_display"];

_dbg = DEBUG_CONSOLE;

uiNamespace setVariable ["cba_diagnostic_display", _display];
_pos = ctrlPosition _dbg;
_x = _pos select 0;//9 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX);
_y = safeZoneY;// * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2));
_w = 22 * (((safezoneW / safezoneH) min 1.2) / 40);
_h = safeZoneH;//40 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25);

_dbg ctrlSetPosition [_x, _y, _w, _h];
_dbg ctrlCommit 0;

_dbgConfig = configFile >> "RscDebugConsole" >> "controls";

_exclude = [11891, 11884, 11885, 11892, 12284];
for "_i" from 0 to (count _dbgConfig)-1 do {
    _control = _dbgConfig select _i;
    if(isClass(_control)) then {
        _idc = getNumber(_control >> "idc");
        if(_idc != 0 && !(_idc in _exclude)) then {
            _ctrl = _display displayCtrl _idc;
            _pos = ctrlPosition _ctrl;
            _pos set[1, (_pos select 1)+SafeZoneH-YPOS(25)];
            _ctrl ctrlSetPosition _pos;
            _ctrl ctrlCommit 0;
        };
    };
};

_exeBg = _display displayCtrl 11885;
_exeBgPos = ctrlPosition _exeBg;
_exeBgPos set[3, SafeZoneH-YPOS(18.25)];
_exeBg ctrlSetPosition _exeBgPos;
_exeBg ctrlCommit 0;

_exe = _display displayCtrl 12284;
_exePos = ctrlPosition _exe;
_exePos set[3, SafeZoneH-YPOS(19.25)];
_exe ctrlSetPosition _exePos;
_exe ctrlCommit 0;

_prevButton = _display ctrlCreate ["RscButtonMenu", 90110, _dbg];

_x = 0 * (((safezoneW / safezoneH) min 1.2) / 40);
_y = 9.25 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
_w = 11.25 * (((safezoneW / safezoneH) min 1.2) / 40);
_h = 1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25);

_y = _y + SafeZoneH - YPOS(26.25);


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


_prevButton ctrlSetPosition [_x, _y, _w, _h];
_prevButton ctrlSetText "Previous Statement";
_prevButton ctrlSetTextColor [1,1,1,1];
_prevButton ctrlCommit 0;

_prevButton ctrlAddEventHandler ["MouseButtonUp", {_this call FUNC(debugPrevStatement); true}];

_nextButton = _display ctrlCreate ["RscButtonMenu", 90111, _dbg];

_x = 11.5 * (((safezoneW / safezoneH) min 1.2) / 40);
_y = 9.25 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
_w = 11.25 * (((safezoneW / safezoneH) min 1.2) / 40);
_h = 1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25);

_y = _y + SafeZoneH - YPOS(26.25);

_nextButton ctrlSetPosition [_x, _y, _w, _h];
_nextButton ctrlSetText "Next Statement";
_nextButton ctrlSetTextColor [1,1,1,1];
_nextButton ctrlCommit 0;

_nextButton ctrlAddEventHandler ["MouseButtonUp", {_this call FUNC(debugNextStatement); true}];

_exeButton = _display displayCtrl 13285;
_exeButton ctrlAddEventHandler ["MouseButtonUp", { _this call FUNC(logStatement); false; }];

_exeButton = _display displayCtrl 1;
_exeButton ctrlAddEventHandler ["MouseButtonUp", { _this call FUNC(logStatement); false; }];

_exeButton = _display displayCtrl 13286;
_exeButton ctrlAddEventHandler ["MouseButtonUp", { _this call FUNC(logStatement); false; }];

// Save expression when hitting enter key inside expression text field
_exe ctrlAddEventHandler ["KeyDown", {
    params ["", "_key"];
    if (_key in [DIK_RETURN, DIK_NUMPADENTER]) then { // 28 and 156
        _this call FUNC(logStatement);
    };
    false
}];

_index = uiNamespace getVariable ["cba_diagnostic_statementIndex", 0];

_prevStatements = profileNamespace getVariable ["cba_diagnostic_statements", []];

if(_index == 0) then {
    _nextButton ctrlEnable false;
    _nextButton ctrlCommit 0;
};

if(_index == 49 || _index == (count _prevStatements)-1 || (count _prevStatements) == 0) then {
    _prevButton ctrlEnable false;
    _prevButton ctrlCommit 0;
};
