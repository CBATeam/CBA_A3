// #define DEBUG_MODE_FULL
#include "script_component.hpp"
#include "script_dialog_defines.hpp"

disableSerialization;
private ["_trap", "_ctrl", "_disp", "_ctrl_b", "_ctrl_t", "_ctrl_o", "_bi_ver_pos", "_cba_ver_pos", "_config", "_ver_list", "_entry", "_ver_line", "_ver_act", "_ver_arr", "_key"];
PARAMS_1(_data);
//DEFAULT_PARAM (or anything using a compiled function) not available on main menu
_trap = _this select 1;
ISNILS(_trap,false);

_ctrl = _data select 0;
_disp = ctrlParent _ctrl;
_ctrl = _disp displayCtrl CBA_CREDITS_VER_IDC;
_ctrl_b = _disp displayCtrl CBA_CREDITS_VER_BTN_IDC;
_ctrl_t = _disp displayCtrl CBA_CREDITS_M_IDC;

if ( isNil {uiNamespace getVariable QGVAR(VerList)} ) then {
	//Position version banner
	_ctrl_o = _disp displayCtrl CA_Version_IDC;
	//align with BI version position
	_bi_ver_pos = ctrlPosition _ctrl_o;
	//BI version width is large - halve it, move above
	_cba_ver_pos = [_bi_ver_pos select 0,(_bi_ver_pos select 1) + (_bi_ver_pos select 3) / 1.8,_bi_ver_pos select 2,_bi_ver_pos select 3];
	_ctrl ctrlSetPosition _cba_ver_pos;
	_ctrl ctrlCommit 0;
	//button align
	_ctrl_b ctrlSetPosition _cba_ver_pos;
	_ctrl_b ctrlCommit 0;
	
	//Gather version info
	_config = configFile >> "CfgPatches";
	_ver_list = [];
	for "_x" from 0 to ((count _config) - 1) do {
		_entry = _config select _x;
		if ( isClass _entry ) then {
			if ( isText(_entry >> "versionDesc") ) then {
				_ver_line = getText(_entry >> "versionDesc") + " v" + getText(_entry >> "version");
				_ver_act = getText(_entry >> "versionAct");
				_ver_arr = [_ver_line, _ver_act];
				PUSH(_ver_list,_ver_arr);
			};
		};
	};
	uiNamespace setVariable [QGVAR(VerList), _ver_list];
};

if (_trap) then {
	[_ctrl_t] spawn {
		disableSerialization;
		private ["_ctrl_t", "_timeTo"];
		PARAMS_1(_ctrl_t);
		uisleep 3;
		_ctrl_t ctrlShow true;
		_ctrl_t ctrlEnable true;
	};
} else {
	GVAR(VerTime) = diag_tickTime + 3;
};

if (isNil QGVAR(VerTime)) then { GVAR(VerTime) = diag_tickTime; };
if (! _trap || diag_tickTime >= GVAR(VerTime)) then {
	_key = _data select 1;
	ISNILS(_key,0);
	//left click forward, other click back
	if (isNil QGVAR(VerNext)) then { GVAR(VerNext) = -1; };
	if ( _key == 0 ) then {
		GVAR(VerNext) = GVAR(VerNext) + 1;
	} else {
		GVAR(VerNext) = GVAR(VerNext) - 1;
	};
	//stay in bounds
	_ver_list = uiNamespace getVariable QGVAR(VerList);
	if ( GVAR(VerNext) >= count _ver_list ) then {
		GVAR(VerNext) = 0;
	} else {
		if ( GVAR(VerNext) < 0 ) then { GVAR(VerNext) = count _ver_list - 1; };
	};
	
	_ver_arr = _ver_list select GVAR(VerNext);
	_ver_line = _ver_arr select 0;
	_ver_act = _ver_arr select 1;
	
	_ctrl ctrlSetText _ver_line; //print version line
	_ctrl_b ctrlSetEventHandler ["MouseButtonDblClick", _ver_act]; //set double-click action if any
};