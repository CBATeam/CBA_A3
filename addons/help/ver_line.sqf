// #define DEBUG_MODE_FULL
#include "script_component.hpp"
#include "script_dialog_defines.hpp"

if (isNil "CBA_fnc_defaultParam") then { CBA_fnc_defaultParam = uiNamespace getVariable "CBA_fnc_defaultParam" };

disableSerialization;
private ["_trap", "_disp", "_ctrl_b", "_x", "_ctrl_t", "_ctrl_o", "_next", "_config", "_ver_list", "_entry", "_ver_line", "_ver_act", "_ver_arr"];
PARAMS_1(_ctrl);
DEFAULT_PARAM(1,_key,0);

_trap = ctrlIDC _ctrl != CBA_CREDITS_VER_BTN_IDC;
_disp = ctrlParent _ctrl;
_ctrl = _disp displayCtrl CBA_CREDITS_VER_IDC;
_ctrl_b = _disp displayCtrl CBA_CREDITS_VER_BTN_IDC;
_ctrl_t = _disp displayCtrl CBA_CREDITS_M_IDC;

if ( isNil {uiNamespace getVariable QGVAR(VerList)} ) then {
	_ver_list = [];
	uiNamespace setVariable [QGVAR(VerList), _ver_list];
	//Position version banner
	_ctrl_o = _disp displayCtrl CA_Version_IDC;
	//align with BI version position
	_x = __RIX(-21);
	_y = __IY(23);
	_w = __IW(8);
	_h = __IH(1);
	_ctrl ctrlSetPosition [_x, _y, _w, _h];
	_ctrl ctrlCommit 0;
	//button align
	_ctrl_b ctrlSetPosition [_x, _y, _w, _h];
	_ctrl_b ctrlCommit 0;
	
	//Gather version info
	_config = configFile >> "CfgPatches";
	for "_x" from 0 to ((count _config) - 1) do {
		_entry = _config select _x;
		if ( isClass _entry && {isText(_entry >> "versionDesc")} ) then {
			_ver_line = getText(_entry >> "versionDesc") + " v" + getText(_entry >> "version");
			_ver_act = getText(_entry >> "versionAct");
			_ver_arr = [_ver_line, _ver_act];
			PUSH(_ver_list,_ver_arr);
		};
	};
};

if (_trap) then {
	[_ctrl_b] spawn { //will terminate when main menu mission exits
		while {true} do {
			uiSleep 3;
			if (isNil QGVAR(VerPause)) then { _this call compile preprocessFileLineNumbers '\x\cba\addons\help\ver_line.sqf'; };
		};			
	};
};

//left click forward, other click back
if ( isNil {uiNamespace getVariable QGVAR(VerNext)} ) then { uiNamespace setVariable [QGVAR(VerNext), -1]; };
_next = uiNamespace getVariable QGVAR(VerNext);
if ( _key == 0 ) then {
	_next = _next + 1;
} else {
	_next = _next - 1;
};
//stay in bounds
_ver_list = uiNamespace getVariable QGVAR(VerList);
if ( _next >= count _ver_list ) then {
	_next = 0;
} else {
	if ( _next < 0 ) then { _next = count _ver_list - 1; };
};
uiNamespace setVariable [QGVAR(VerNext), _next];

_ver_arr = _ver_list select _next;
_ver_line = _ver_arr select 0;
_ver_act = _ver_arr select 1;

_ctrl ctrlSetText _ver_line; //print version line
_ctrl_b ctrlSetEventHandler ["MouseButtonDblClick", _ver_act]; //set double-click action if any