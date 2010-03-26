#include "\x\cba\addons\ui\script_component.hpp"
#include "\ca\editor\Data\Scripts\dikCodes.h"
#include "data\common.hpp"

#define _minObjDist(_var) (4 max (1.4+(sizeOf typeOf _var)/2)) // minimum object interaction distance: arbitrary distance. Might not work with very long/large vehicles. TODO: Find a very fast way to determine vehicle size.

private["_handled", /* "_ctrl", */ "_dikCode", /* "_shift", "_ctrlKey", "_alt", */
	"_target", "_menuSource", "_active", "_potentialTarget", "_isTypeTarget", 
	"_potentialKeyMatch", "_potentialMenuSources", "_vehicleTarget", "_typesList"];

//_ctrl = _this select 0;
_dikCode = _this select 1;
//_shift = _this select 2;
//_ctrlKey = _this select 3;
//_alt = _this select 4;

_handled = false;

// scan typeMenuSources key list (optimise overhead)
_potentialKeyMatch = false;
{
	if (_dikCode in (_x select _flexiMenu_typeMenuSources_ID_DIKCodes)) exitWith
	{
		_potentialKeyMatch = true;
	};
} forEach GVAR(typeMenuSources);

// check if interaction key used
if !(_potentialKeyMatch || (_dikCode in _flexiMenu_interactKeys)) exitWith
{
	_handled // result
};
//-----------------------------------------------------------------------------
if (!GVAR(optionSelected) && time-GVAR(lastAccessTime) > 0.4) then
{
	GVAR(lastAccessTime) = time;
	// check if menu already open
	_active = (!isNil {uiNamespace getVariable QUOTE(GVAR(display))});
	if (_active) then
	{
		_active = (!isNull (uiNamespace getVariable QUOTE(GVAR(display))));
	};
	if (!_active) then
	{
		// examine cursor object for relevant menu def variable
		_target = objNull;
		// if dedicated interact key is used
		if (_dikCode in _flexiMenu_interactKeys) then {_target = cursorTarget};
		if (!isNull _target) then
		{
			if (_target distance player > _minObjDist(_target)) then {_target = objNull};
		};

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
			if (_dikCode in (_x select _flexiMenu_typeMenuSources_ID_DIKCodes)) then
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
	}
	else
	{
		//player sideChat format [__FILE__+": _active", _this];
	};
};

_handled // result
