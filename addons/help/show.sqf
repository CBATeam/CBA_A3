// #define DEBUG_MODE_FULL
#include "script_component.hpp"
#include "script_dialog_defines.hpp"

disableSerialization;
PARAMS_1(_data);
private ["_disp", "_ctrlt", "_ctrl", "_config", "_stop", "_rand", "_entry", "_name", "_authors", "_author", "_url", "_text"];

if ( isNil QUOTE(GVAR(show_proc)) ) then {
	GVAR(show_proc) = true;

	//get display control
	if (typeName (_data select 0) == "DISPLAY") then {
		  _disp = _data select 0;
	};

	if (typeName (_data select 0) == "CONTROL") then {
		_ctrlt = _data select 0;
		_disp = ctrlParent _ctrlt;
	};
	_ctrlt ctrlEnable false;
	_ctrlt ctrlShow false;

	_ctrl = _disp displayCtrl CBA_CREDITS_CONT_IDC;

	//TRACE_1("",ctrlText _ctrl);
	//if text not already shown
	if ( (ctrlText _ctrl) == "" ) then {
		//find addon with author
		_config = configFile >> "CfgPatches";
		_stop = false;
		while { ! _stop } do {
			_rand = floor(random(count _config));
			_entry = _config select _rand;
			if ( isClass _entry ) then { _stop = isArray (_entry >> "author"); };
			//TRACE_1("",configName _entry);
		};

		//addon name
		_name = configName _entry;
		_name = "<t color='#99cccc'>" + _name + "</t>";
		//author(s) name
		_authors = getArray(_entry >> "author");
		_author = _authors select 0;
		for "_x" from 1 to (count(_authors)-1) do {
			if ( typeName (_authors select _x) == "STRING" ) then { _author = _author + ", " + (_authors select _x); }
		};
		//url if any
		if (isText (_entry >> "authorUrl")) then {
			_url = getText(_entry >> "authorUrl");
			_url = "<t color='#566D7E'>" + _url + "</t>";
		} else {
			_url = "";
		};

		//single line
		_text = _name + " by " + _author + " " + _url;
		_ctrl ctrlSetStructuredText parseText _text;
		//TRACE_1("2",ctrlText _ctrl);
	};
	GVAR(show_proc) = nil;
};
