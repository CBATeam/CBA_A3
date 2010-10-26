// #define DEBUG_MODE_FULL
#include "\x\cba\addons\ui\script_component.hpp"
#include "\ca\editor\Data\Scripts\dikCodes.h"
#include "data\common.hpp"

#define _minObjDist(_var) (if (_var isKindOf "CAManBase") then {3} else {(2 max (1.4+(sizeOf typeOf _var)/2))}) // minimum object interaction distance: arbitrary distance. Might not work with very long/large vehicles. TODO: Find a very fast way to determine vehicle size.

private["_handled", /* "_ctrl", */ "_dikCode", "_shift", "_ctrlKey", "_alt",
	"_target", "_menuSource", "_active", "_potentialTarget", "_isTypeTarget",
	"_potentialKeyMatch", "_potentialMenuSources", "_vehicleTarget", "_typesList",
	"_keys", "_settings"];
PARAMS_5(_ctrl,_dikCode,_shift,_ctrlKey,_alt);

_handled = false;

// prevent unneeded cpu usage due to key down causing repeated event trigger
if (time-(GVAR(lastAccessCheck) select 0) < 0.220 && (GVAR(lastAccessCheck) select 1) == _dikCode) exitWith {_handled};
GVAR(lastAccessCheck) = [time, _dikCode];

TRACE_1("",GVAR(lastAccessCheck));

// scan typeMenuSources key list (optimise overhead)
_potentialKeyMatch = false;
{
	// syntax of _keys: [[_dikCode1, [_shift, _ctrlKey, _alt]], [_dikCode2, [...]], ...]
	TRACE_1("",_x);
	_keys = (_x select _flexiMenu_typeMenuSources_ID_DIKCodes);
	TRACE_2("",_keys,_flexiMenu_typeMenuSources_ID_DIKCodes);
	{
		TRACE_1("uhh",nil);
		TRACE_5("",_x,_dikCode,_shift,_ctrlKey,_alt);
		_settings = _x select 1;
		if ((_x select 0 == _dikCode) &&
			((!(_settings select 0) && !_shift) || ((_settings select 0) && _shift)) && // can't seem to compare booleans. i.e. ((_settings select 0) == _shift)
			((!(_settings select 1) && !_ctrlKey) || ((_settings select 1) && _ctrlKey)) &&
			((!(_settings select 2) && !_alt) || ((_settings select 2) && _alt))
		) exitWith {
			_potentialKeyMatch = true;
			TRACE_1("",_potentialKeyMatch);
		};
	} forEach _keys;
	TRACE_1("",_potentialKeyMatch);
	if (_potentialKeyMatch) exitWith {};
} forEach GVAR(typeMenuSources);

TRACE_1("",_potentialKeyMatch);

// check if interaction key used
if !(_potentialKeyMatch) exitWith
{
	TRACE_1("No potential keymatch",nil);
	_handled // result
};
//-----------------------------------------------------------------------------
if (!GVAR(optionSelected) || !GVAR(holdKeyDown)) then
{
	// check if menu already open
	_active = (!isNil {uiNamespace getVariable QUOTE(GVAR(display))});
	if (_active) then
	{
		_active = (!isNull (uiNamespace getVariable QUOTE(GVAR(display))));
	};
	if (_active) then
	{
		if (!GVAR(holdKeyDown)) then
		{
			closeDialog 0;
		};
	}
	else
	{
		//player sideChat format [__FILE__+": _active", _this];
		// examine cursor object for relevant menu def variable
		_target = objNull;
		_isTypeTarget = false;

		// check for [cursorTarget or "player" or "vehicle"] types in typeMenuSources list
		_potentialTarget = cursorTarget;
		if (!isNull _potentialTarget) then
		{
			if (_potentialTarget distance player > _minObjDist(_potentialTarget)) then {_potentialTarget = objNull};
		};
		_vehicleTarget = vehicle player;
		if (_vehicleTarget == player) then {_vehicleTarget = objNull};

		_potentialMenuSources = [];

		{ // forEach
			_potentialKeyMatch = false; // "_actualKeyMatchFound"
			_keys = (_x select _flexiMenu_typeMenuSources_ID_DIKCodes);
			{
				_settings = _x select 1;
				if ((_x select 0 == _dikCode) &&
					((!(_settings select 0) && !_shift) || ((_settings select 0) && _shift)) &&
					((!(_settings select 1) && !_ctrlKey) || ((_settings select 1) && _ctrlKey)) &&
					((!(_settings select 2) && !_alt) || ((_settings select 2) && _alt)) ) exitWith
				{
					_potentialKeyMatch = true;
				};
			} forEach _keys;

			if (_potentialKeyMatch) then
			{
				_typesList = _x select _flexiMenu_typeMenuSources_ID_type;
				if (typeName _typesList == "String") then {_typesList = [_typesList]}; // single string type

				if (({_potentialTarget isKindOf _x} count _typesList > 0) ||
					({_vehicleTarget isKindOf _x} count _typesList > 0) ||
					("player" in _typesList)) then
				{
					if (count _potentialMenuSources == 0) then
					{
						_isTypeTarget = true;
						_target = if ((_vehicleTarget != player) &&
							({_vehicleTarget isKindOf _x} count _typesList > 0)) then
						{
							_vehicleTarget
						} else {
							_potentialTarget
						};
						if ("player" in _typesList) then
						{
							_target = player;
						};
					};
					_potentialMenuSources = _potentialMenuSources+[_x select _flexiMenu_typeMenuSources_ID_menuSource];
				};
			};
		} forEach GVAR(typeMenuSources);

		if (!isNull _target) then
		{
			private ["_menuSources", "_menuSource"]; // sometimes nil
			_menuSources = [];
			_menuSource = _target getVariable QUOTE(GVAR(flexiMenu_source));
			if (isNil "_menuSource") then {_menuSource = []} else {_menuSources = _menuSources+[_menuSource]};

			/*
			if ( // count _menuSource == 0 &&
			_isTypeTarget) then
			{
				_menuSources = _menuSources+_potentialMenuSources;
			};
			*/
			_menuSources = _menuSources+_potentialMenuSources;

			//if (isNil "_menuSource") then {_menuSource = []};
			if (count _menuSources > 0) then
			{
				// show menu dialog and load menu data
				GVAR(target) = _target; // global variable used since passing an object as a string is too difficult.
				nul = [_target, _menuSources] call FUNC(menu);
				_handled = true;
			};
		}
		else
		{
			//player sideChat format [__FILE__+": no cursor target", _this];
		};
	};
} else {
	TRACE_1("xxx",nil);
};

TRACE_1("",_handled);
_handled // result
