// #define DEBUG_MODE_FULL
#include "script_component.hpp"
#include "script_dialog_defines.hpp"

disableSerialization;
private ["_init", "_ctrl_t", "_disp", "_ctrl", "_ctrl_b", "_ctrl_o", "_bi_ver_pos", "_cba_ver_pos", "_config", "_entry", "_x", "_ver_line", "_ver_act", "_ver_arr", "_key"];
PARAMS_1(_data);
//DEFAULT_PARAM (anything using a compiled function) not available on main menu
_init = _this select 1;
ISNILS(_init,false);

_ctrl_t = _data select 0;
_disp = ctrlParent _ctrl_t;
_ctrl = _disp displayCtrl CBA_CREDITS_VER_IDC;
_ctrl_b = _disp displayCtrl CBA_CREDITS_VER_BTN_IDC;

if ( _init ) then {
    //diag_log "mouse trap triggered";
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

	//get list of mods with versions
	_config = configFile >> "CfgPatches";
	GVAR(VerList) = [];
	for "_x" from 0 to ((count _config) - 1) do {
		_entry = _config select _x;
		if ( isClass _entry ) then {
			if ( isText(_entry >> "versionDesc") ) then {
			    _ver_line = getText(_entry >> "versionDesc") + " v" + getText(_entry >> "version");
			    _ver_act = getText(_entry >> "versionAct");
			    _ver_arr = [_ver_line, _ver_act];
				PUSH(GVAR(VerList),_ver_arr);
			};
		};
	};
	//current index
	GVAR(VerNext) = -1;
	GVAR(VerTime) = 2; //cycle version every 4 seconds
	//auto-cycle, main menu never unloads so need to reset (mouse trap) when not visible
	[_data] spawn {
	    #include "script_component.hpp"
		#include "script_dialog_defines.hpp"
	    disableSerialization;
		private ["_ctrl_t", "_timeout"];
		_timeout = 30; // one minute
		while { _timeout > 0 } do {
			uisleep 2;
			GVAR(VerTime) = GVAR(VerTime) - 1;
			if ( GVAR(VerTime) <= 0 ) then {
				_this call COMPILE_FILE2(\x\cba\addons\help\showver.sqf);
			};
			_timeout = _timeout - 1;
		};
		_ctrl_t = (_this select 0) select 0;
        _ctrl_t ctrlEnable true;
		_ctrl_t ctrlShow true;
		//diag_log "mouse trap reset";
	};
};

_key = _data select 1;
ISNILS(_key,0);
//left click forward, other click back
if ( _key == 0 ) then {
	GVAR(VerNext) = GVAR(VerNext) + 1;
} else {
    GVAR(VerNext) = GVAR(VerNext) - 1;
};
//stay in bounds
if ( GVAR(VerNext) >= count GVAR(VerList) ) then {
	GVAR(VerNext) = 0;
} else {
	if ( GVAR(VerNext) < 0 ) then { GVAR(VerNext) = count GVAR(VerList) - 1; };
};

_ver_arr = GVAR(VerList) select GVAR(VerNext);
_ver_line = _ver_arr select 0;
_ver_act = _ver_arr select 1;

_ctrl ctrlSetText _ver_line; //print version line
_ctrl_b ctrlSetEventHandler ["MouseButtonDblClick", _ver_act]; //set double-click action if any

GVAR(VerTime) = 2;