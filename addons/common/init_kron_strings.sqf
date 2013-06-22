#include "script_component.hpp"
// =========================================================================================================
//
//  String Functions Library
//  Version: 2.2.1
//  Author: Kronzky
//
// =========================================================================================================
//
//  Usage:
//
//    • KRON_StrToArray - Converts a string into an array of characters:
//                        _array =[_str] call KRON_StrToArray
//
//    • KRON_StrLen     - Returns the length of the string
//                        _len =[_str] call KRON_StrLen
//
//    • KRON_StrLeft    - Returns l characters from the left side of the string
//                        _left =[_str,l] call KRON_StrLeft
//
//    • KRON_StrRight   - Returns l characters from the right side of the string
//                        _right =[_str,l] call KRON_StrRight
//
//    • KRON_StrMid     - Returns l characters from the string, starting at position p (zero-based)
//                        If l is not defined, the rest of the string is returned
//                        _mid =[_str,p,(l)] call KRON_StrMid
//
//    • KRON_StrInStr   - Tests whether string b is present in string a
//                        _found =[a,b] call KRON_StrInStr
//
//    • KRON_StrIndex   - Returns the position of string b in string a
//                        _index =[a,b] call KRON_StrIndex
//
//    • KRON_StrUpper   - Converts a string to uppercase characters
//                        _upper =[_str] call KRON_StrUpper
//
//    • KRON_StrLower   - Converts a string to lowercase characters
//                        _lower =[_str] call KRON_StrLower
//
//    • KRON_Replace    - Replaces every occurrence of string _old in string _str with string _new
//                        _index =[_str,_old,_new] call KRON_Replace
//
//    • KRON_FindFlag   - Checks a mixed array (_this) for the presence of a string (_str)
//                        _flg =[_this,_str] call KRON_FindFlag
//
//    • KRON_getArg     - Searches a mixed array (_this) for a matching string beginning with (_t), and returns the part after a separator (s)
//                        A default value can be defined as (_d).
//                        _arg =[_this,_t,(_d)] call KRON_getArg
//
//    • KRON_getArgRev  - Works like getArg, but search for the part *after* the colon, and return the part in front of it
//                        A default value can be defined as (_d).
//                        _arg =[_this,_t,(_d)] call KRON_getArgRev
//
//    • KRON_Compare    - Compares two elements and returns -1 if first is smaller, 1 if second is smaller, and 0 if equal
//                        If optional parameter "case" is given, capitalization is considered (upper before lowercase)
//                        _cmp =[_str1,_str2,("case")] call KRON_Compare
//
//    • KRON_ArraySort  - Sorts an array of strings in acsending order (Numbers before letters, uppercase before lowercase)
//                        If array is multi-dimensional, optional parameter (_idx) specifies which column is used for sorting
//                        If optional parameter "desc" is given, order is reversed
//                        If optional parameter "case" is given, capitalization is considered (upper before lowercase)
//                        _srt =[_arr,(_idx),("desc"),("case")] call KRON_ArraySort
//
// =========================================================================================================

/*
KRON_StrToArray = {
	private["_in", "_i", "_arr", "_out"];
	_in = _this select 0;
	_arr = toArray(_in);
	_out =[];
	for "_i" from 0 to (count _arr)-1 do
	{
		_out = _out+[toString([_arr select _i])];
	};
	_out
};
*/

KRON_StrLeft = {
	private["_in", "_len", "_arr", "_out"];
	_in = _this select 0;
	_len = (_this select 1) - 1;
	_arr = [_in] call KRON_StrToArray;
	_out ="";
	if (_len >= count _arr) then {
		_out = _in;
	} else {
		for "_i" from 0 to _len do {
			_out = _out + (_arr select _i);
		};
	};
	_out
};

/*
KRON_StrLen = {
	private["_in", "_arr", "_len"];
	_in = _this select 0;
	_arr =[_in] call KRON_StrToArray;
	_len = count (_arr);
	_len
};
*/

KRON_StrRight = {
	private["_in", "_len", "_arr", "_i", "_out"];
	_in = _this select 0;
	_len = _this select 1;
	_arr = [_in] call KRON_StrToArray;
	_out ="";
	if (_len > count _arr) then {_len = count _arr};
	for "_i" from ((count _arr) - _len) to ((count _arr) - 1) do {
		_out = _out + (_arr select _i);
	};
 _out
};

KRON_StrMid = {
	private["_in", "_pos", "_len", "_arr", "_i", "_out"];
	_in = _this select 0;
	_pos = abs(_this select 1);
	_arr = [_in] call KRON_StrToArray;
	_len = count _arr;
	if (count _this > 2) then {_len = _this select 2};
	_out ="";
	if ((_pos + _len) >= count _arr) then {_len = (count _arr) - _pos};
	if (_len > 0) then {
		for "_i" from _pos to (_pos + _len - 1) do {
			_out = _out + (_arr select _i);
		};
	};
	_out
};

/*
KRON_StrIndex = {
	private["_hay", "_ndl", "_lh", "_ln", "_arr", "_tmp", "_i", "_j", "_out"];
	_hay = _this select 0;
	_ndl = _this select 1;
	_out =-1;
	_i = 0;
	if (_hay == _ndl) exitWith { 0 };
	_lh =[_hay] call KRON_StrLen;
	_ln =[_ndl] call KRON_StrLen;
	if (_lh < _ln) exitWith {-1 };
	_arr =[_hay] call KRON_StrToArray;
	for "_i" from 0 to (_lh-_ln) do
	{
		_tmp ="";
		for "_j" from _i to (_i+_ln-1) do
		{
			_tmp = _tmp + (_arr select _j);
		};
		if (_tmp == _ndl) exitWith { _out = _i };
	};
	_out
};
*/

KRON_StrInStr = {
	(([_this select 0, _this select 1] call KRON_StrIndex) != -1)
};

/*
KRON_Replace = {
	private["_str", "_old", "_new", "_out", "_tmp", "_jm", "_la", "_lo", "_ln", "_i"];
	_str = _this select 0;
	_arr = toArray(_str);
	_la = count _arr;
	_old = _this select 1;
	_new = _this select 2;
	_na =[_new] call KRON_StrToArray;
	_lo =[_old] call KRON_StrLen;
	_ln =[_new] call KRON_StrLen;
	_out ="";
	for "_i" from 0 to (count _arr)-1 do
	{
		_tmp ="";
		if (_i <= _la-_lo) then
		{
			for "_j" from _i to (_i+_lo-1) do
			{
				_tmp = _tmp + toString([_arr select _j]);
			};
		};
		if (_tmp == _old) then
		{
			_out = _out+_new;
			_i = _i+_lo-1;
		} else {
			_out = _out+toString([_arr select _i]);
		};
	};
	_out
};
*/

/*
KRON_StrUpper = {
	private["_in", "_out"];
	_in = _this select 0;
	_out = toUpper(_in);
	_out
};
*/

/*
KRON_StrLower = {
	private["_in", "_out"];
	_in = _this select 0;
	_out = toLower(_in);
	_out
};
*/

KRON_ArrayToUpper = {
	private["_in", "_i", "_e", "_out"];
	_in = _this select 0;
	_out = [];
	if (count _in > 0) then {
		for "_i" from 0 to (count _in) - 1 do {
			_e = _in select _i;
			if (typeName _e == "STRING") then {
				_e = toUpper _e;
			};
			_out set [_i, _e];
		};
	};
	_out
};

KRON_Compare = {
	private["_k", "_n", "_s", "_i", "_c", "_t", "_s1", "_s2", "_l1", "_l2", "_l"];
	_k = [_this, "CASE"] call KRON_findFlag;
	_n = 0;
	_s = 0;
	for "_i" from 0 to 1 do {
		_t = _this select _i;
		switch (typeName _t) do {
			case "SCALAR": { _n = 1 };
			case "BOOL": { _this set [_i, str _t]};
			case "SIDE": { _this set [_i, str _t]};
			case "STRING": { if !(_k) then { _this = [_this] call KRON_ArrayToUpper }};
			default { _n =-1 };
		};
	};
	_s1 = _this select 0;
	_s2 = _this select 1;
	if (_n != 0) exitWith {
		if (_n == 1) then {
			if (_s1 < _s2) then { _s =-1 } else { if (_s1 > _s2) then { _s = 1 }};
		};
		_s
	};
	_s1 = toArray _s1;
	_s2 = toArray _s2;
	_l1 = count _s1;
	_l2 = count _s2;
	_l = if (_l1 < _l2) then { _l1 } else { _l2 };
	for "_i" from 0 to _l - 1 do {
		if ((_s1 select _i) < (_s2 select _i)) then {
			_s = -1;
			_i = _l;
		} else {
			if ((_s1 select _i) > (_s2 select _i)) then {
				_s = 1;
				_i = _l;
			};
		};
	};
	if (_s == 0) then {
		if (_l1 < _l2) then {
			_s =-1;
		} else {
			if (_l1 > _l2) then { _s = 1 };
		};
	};
	_s
};

KRON_ArraySort = {
	private["_a", "_d", "_k", "_s", "_i", "_vo", "_v1", "_v2", "_j", "_c", "_x"];
	_a = +(_this select 0);
	_d = if ([_this, "DESC"] call KRON_findFlag) then { -1 } else { 1 };
	_k = if ([_this, "CASE"] call KRON_findFlag) then { "CASE" } else { "nocase" };
	_s = -1;
	if (typeName (_a select 0) == "ARRAY") then {
		_s = 0;
		if (count _this > 1 && {typeName (_this select 1) == "SCALAR"}) then {
			_s = _this select 1;
		};
	};
	for "_i" from 0 to (count _a) - 1 do {
		_vo = _a select _i;
		_v1 = _vo;
		if (_s > -1) then { _v1 = _v1 select _s };
		_j = 0;
		for [{ _j = _i-1 }, { _j >= 0 }, { _j = _j - 1 }] do {
			_v2 = _a select _j;
			if (_s > -1) then { _v2 = _v2 select _s };
			_c = [_v2, _v1, _k] call KRON_Compare;
			if (_c != _d) exitWith {};
			_a set [_j + 1, _a select _j];
		};
		_a set [_j + 1, _vo];
	};
	_a
};

KRON_findFlag = {
	private["_in", "_flg", "_arr"];
	_in = _this select 0;
	_flg = toUpper(_this select 1);
	_arr = [_in] call KRON_ArrayToUpper;
	(_flg in _arr)
};

KRON_getArg = {
	private["_in", "_flg", "_fl", "_def", "_arr", "_i", "_j", "_as", "_aa", "_org", "_p", "_out"];
	_in = _this select 0;
	_flg = toUpper(_this select 1);
	_fl = [_flg] call KRON_StrLen;
	_out = "";
	if (count _this > 2) then { _out = _this select 2 };
	_arr = [_in] call KRON_ArrayToUpper;
	if (count _arr > 0) then {
		for "_i" from 0 to (count _in) - 1 do {
			_as = _arr select _i;
			if (typeName _as =="STRING") then {
				_aa = [_as] call KRON_StrToArray;
				_p = _aa find ":";
				if (_p == _fl) then {
					if (([_as,_fl] call KRON_StrLeft) == _flg) then {
						_org = _in select _i;
						_out = [_org, _p + 1] call KRON_StrMid;
					};
				};
			};
		};
	};
	_out
};


KRON_getArgRev = {
	private["_in", "_flg", "_fl", "_def", "_arr", "_i", "_j", "_as", "_aa", "_org", "_p", "_out"];
	_in = _this select 0;
	_flg = toUpper(_this select 1);
	_fl = [_flg] call KRON_StrLen;
	_out ="";
	if (count _this > 2) then { _out = _this select 2 };
	_arr = [_in] call KRON_ArrayToUpper;
	if (count _arr > 0) then {
		for "_i" from 0 to (count _in) - 1 do {
			_as = _arr select _i;
			if (typeName _as =="STRING") then {
				_aa = [_as] call KRON_StrToArray;
				_p = _aa find ":";
				if (_p + 1 == (count _aa) - _fl) then {
					if (([_as, _p + 1] call KRON_StrMid) == _flg) then {
						_org = _in select _i;
						_out = [_org, _p] call KRON_StrLeft;
					};
				};
			};
		};
	};
	_out
};
