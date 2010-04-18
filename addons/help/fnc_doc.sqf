/* cba_help | (c) 2010 by alef, Rocko, Sickboy */

#include "script_component.hpp"

private ["_pkeynam", "_shift", "_ctrl", "_alt", "_keys", "_key", "_keystrg", "_mod", "_knaml", "_knam", "_k", "_text", "_cEvents", "_i", "_cSys", "_tSys", "_aSys", "_tS", "_j", "_c", "_tC", "_keyn", "_credits"];

_pkeynam = { //local function
	_shift = if(_shift > 0) then {42} else {0};
	_ctrl = if(_ctrl > 0) then {56} else {0};
	_alt = if(_alt > 0) then {29} else {0};
	_keys = [_shift,_ctrl,_alt,_key];
	_keystrg = "^";
	{
		_mod = _x in [42,56,29];
		_knaml = call compile format["format['%2',%1]",(keyName _x),"%1"];
		_knaml = [_knaml, " "] call CBA_fnc_split;
		_knam = "^";
		{_k = _x; _knam = _knam + " " + _k} forEach _knaml;
		// if(!(_mod) || ( (_k != (localize "STR_ACE_KN_LEFT")) && (_k != (localize "STR_ACE_KN_RIGHT")) )) then {  // ?????
		_knam = [_knam, "^ ", ""] call CBA_fnc_replace;
		_keystrg = _keystrg + "-" + _knam;
	} forEach _keys;
	_keystrg = [_keystrg, "^ ", ""] call CBA_fnc_replace;
	_keystrg = [_keystrg, "^-", ""] call CBA_fnc_replace;
	_keystrg = [_keystrg, "^", "None"] call CBA_fnc_replace;
	_keystrg
};

_text="";
_cEvents = configFile/"CfgSettings"/"CBA"/"events";
for "_i" from 0 to (count _cEvents)-1 do {
	_cSys = _cEvents select _i;
	_tSys = configName _cSys;
	if (isNumber((_cSys select 0)/"key")) then {
		//format system name
		_aSys = [_tSys, "_"] call CBA_fnc_split;
		_tS = "^";
		{if((_x != "ace") && (_x != "sys")) then {_tS = _tS + " " + _x;}} forEach _aSys;
		_tS = [_tS, "^ ", ""] call CBA_fnc_replace;
		_tS = format["%1:",_tS];
		_text = _text + _tS + "<br/>";
		for "_j" from 0 to (count _cSys)-1 do {
			_c = _cSys select _j;
			_tC = configName _c;
			_tC = [_tC, "_", " "] call CBA_fnc_replace;
			//key
			_key = getNumber (_c/"key");
			_shift = getNumber (_c/"shift");
			_ctrl = getNumber (_c/"ctrl");
			_alt = getNumber (_c/"alt");
			_keyn = [_key,_shift,_ctrl,_alt] call _pkeynam;
			_tC = format["    %1: %2",_tC,_keyn];
			_text = _text + _tC + "<br/>";
		};
		_text = _text + "<br/>";
	};
};


FUNC(readConfig) = {
	PARAMS_1(_type);
	_config = configFile >> _type;
	_hash = [[], []] call CBA_fnc_hashCreate;
	_hash2 = [[], ""] call CBA_fnc_hashCreate;
	for "_i" from 0 to (count _config) - 1 do {
		_entry = _config select _i;
		if (isClass _entry) then {
			_author = _entry >> "AUTHOR";
			_authorUrl = _entry >> "AUTHOR_URL";
			if (isArray _author) then { [_hash, configName _entry, getArray _author] call CBA_fnc_hashSet };
			if (isText _authorUrl) then { [_hash2, configName _entry, getText _authorUrl] call CBA_fnc_hashSet };
		};
	};
	[_hash, _hash2];
};

FUNC(process) = {
	PARAMS_2(_h1,_h2);
	_ar = [];
	[_h1, {_entry = format["%1, URL: %3<br/>Authors: %2", _key, [_value, ", "] call CBA_fnc_join, [_h2, _key] call CBA_fnc_hashGet]; PUSH(_ar,_entry) }] call CBA_fnc_hashEachPair;
	[_ar, "<br/><br/>"] call CBA_fnc_join;
};

GVAR(credits) = [[], []] call CBA_fnc_hashCreate;
{ [GVAR(credits), _x, [_x] call FUNC(readConfig)] call CBA_fnc_hashSet } forEach ["CfgPatches", "CfgVehicles", "CfgWeapons"];



player createDiarySubject ["CBA_docs", "CBA"]; 
player createDiaryRecord ["CBA_docs", ["Credits - Addons", ([GVAR(credits), "CfgPatches"] call CBA_fnc_hashGet) call FUNC(process)]];
player createDiaryRecord ["CBA_docs", ["Credits - Vehicles", ([GVAR(credits), "CfgVehicles"] call CBA_fnc_hashGet) call FUNC(process)]];
player createDiaryRecord ["CBA_docs", ["Credits - Weapons", ([GVAR(credits), "CfgWeapons"] call CBA_fnc_hashGet) call FUNC(process)]];
player createDiaryRecord ["CBA_docs", ["Keys", _text]];
player createDiaryRecord ["CBA_docs", ["Website", "http://dev-heaven.net/projects/cca"]];
player createDiaryRecord ["CBA_docs", ["Wiki", "http://dev-heaven.net/projects/cca"]];

