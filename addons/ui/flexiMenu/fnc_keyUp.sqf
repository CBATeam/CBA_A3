#include "\x\cba\addons\ui\script_component.hpp"
#include "\ca\editor\Data\Scripts\dikCodes.h"
#include "data\common.hpp"

private["_handled", /* "_ctrl", */ "_dikCode", /* "_shift", "_ctrlKey", "_alt", */
	"_active", "_potentialKeyMatch"];
//_ctrl = _this select 0;
_dikCode = _this select 1;
//_shift = _this select 2;
//_ctrlKey = _this select 3;
//_alt = _this select 4;

_handled = false;
//player sideChat format [__FILE__+":", _this];

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
_active = (!isNil {uiNamespace getVariable QUOTE(GVAR(display))});
if (_active) then
{
	_active = (!isNull (uiNamespace getVariable QUOTE(GVAR(display))));
};
if (_active) then
{
	//player sideChat format [__FILE__+": hide menu", _this];
	//nul = [] execVM "flexiMenu\closeMenu.sqf";
	closeDialog 0;
	_handled = true;
};
GVAR(optionSelected) = false;

_handled // result
