// Desc: "keyDown" EH for menu dialog
//-----------------------------------------------------------------------------
#include "\x\cba\addons\ui\script_component.hpp"
#include "\ca\editor\Data\Scripts\dikCodes.h"
#include "data\common.hpp"

if (isDedicated || !dialog) exitWith {};

private['_handled', '_EHParams', '_control', '_dikCode', '_shiftKey', '_ctrlKey', '_altKey'];
private['_menuDefs', "_caption", "_action", "_icon", "_tooltip", "_subMenu", "_shortcut", "_visible", "_enabled"]; 
_EHParams = _this select 0;

_control = _EHParams select 0;
_dikCode = _EHParams select 1;
_shiftKey = _EHParams select 2;
_ctrlKey = _EHParams select 3;
_altKey = _EHParams select 4;

_handled = false;
//if (isNil QUOTE(GVAR(lastAccessTime))) then {GVAR(lastAccessTime) = 0};
//if (time-GVAR(lastAccessTime) < 0.1) exitWith {_handled};
//GVAR(lastAccessTime) = time;

_menuDefs = (_this select 1) call FUNC(getMenuDef);
//-----------------------------------------------------------------------------
{ // forEach
	_menuOption = [_menuDefs select 0, _x] call FUNC(getMenuOption);

	//_caption = _menuOption select _flexiMenu_menuDef_ID_caption;
	_action = _menuOption select _flexiMenu_menuDef_ID_action;
	//_icon = _menuOption select _flexiMenu_menuDef_ID_icon;
	//_tooltip = _menuOption select _flexiMenu_menuDef_ID_tooltip;
	//_subMenu = _menuOption select _flexiMenu_menuDef_ID_subMenuSource;
	_shortcut = _menuOption select _flexiMenu_menuDef_ID_shortcut;
	_enabled = _menuOption select _flexiMenu_menuDef_ID_enabled;
	_visible = _menuOption select _flexiMenu_menuDef_ID_visible;

	if (_dikCode == _shortcut && _enabled != 0 && _visible != 0) exitWith
	{
		call compile _action;
		_handled = true;
	};
} forEach (_menuDefs select 1);

_handled;  
