// Desc: determine menuDef to use, based on variable param variations
//-----------------------------------------------------------------------------
//#define DEBUG_MODE_FULL
#include "\x\cba\addons\ui\script_component.hpp"

private ["_menuDefs", "_target", "_menuSources"];

_target = _this select 0;
_menuSources = _this select 1; // [_target, _menuSources];

_menuDefs = [];

{ // forEach
	private ["_params", "_menuSource", "_menuParams", "_array", "_menuDef"]; // declare locally to safe guard variables after _menuSource call, which is beyond our control of correctness.

	_params = _x;
    if (isNil "_params") then { diag_log format ["%1:%2: CBA WARNING: Menu sources item is nil! Check Source: %3", __FILE__, __LINE__, _params]; };
	
	_menuSource = "";
	_menuParams = [_target];
	// Syntax 1
	if (typeName _params == typeName "") then {
		_menuSource = _params;
	};
	// Syntax 2
	if (typeName _params == typeName [] && {count _params > 0}) then {
		_menuSource = _params select 0;
		if (typeName _menuSource == typeName "") then {// check for syntax: function, code string or sqf filename
			_menuParams = if (count _params > 1) then {[_target, _params select 1]};
		} else {
			_menuSource = _params;
		};
	};
	
	TRACE_1("",_menuSource);
	//-----------------------------------------------------------------------------
	// determine if string represents an executable statement or actual data (via variable).
	if (typeName _menuSource == typeName []) then {
		// _menuSource is _menuDefs. a single menuDef array
		LOG("_menuSource Single Definition");
		_menuDef = _menuSource; //somtimes Nil
	} else {
		// check which string syntax was used: function, code string or sqf filename
		LOG("_menuSource alternate format");
		_array = toArray _menuSource;
		_menuDef = if (_array find 46 >= 0 && {_array find 34 < 0} && {_array find 39 < 0}) then { // 46='.',34=("),39=(') (eg: as in 'path\file.sqf')
			// sqf filename. Eg: 'path\file.sqf'
			_menuParams call COMPILE_FILE2(_menuSource);
			// TODO: DEBUG switch to recompile menus always?
		} else { // code string. Eg: '_this call someFunction' or '_this call compile preprocessFileLineNumbers "file.sqf"'
			_menuParams call compile _menuSource;
		};
	};

	TRACE_1("",_menuDef); //sometimes Nil
	
	// merge menuDef's - keeping original header array [0] and merging data array [1]
	if !(isNil "_menuDef") then {
		if (count _menuDefs == 0) then {
			_menuDefs = _menuDef;
		} else {
			if (count _menuDef > 0) then {
				_menuDefs set [1, (_menuDefs select 1) + (_menuDef select 1)];
			};
		};
	} else {
	   diag_log format ["%1:%2: Warning: Expected Type Array but received nil. Check MenuSource: %3", __FILE__, __LINE__, _menuSource];
	};
} forEach _menuSources;
TRACE_1("",_menuDefs);
_menuDefs