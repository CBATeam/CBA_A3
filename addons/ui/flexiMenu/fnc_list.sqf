// Desc: Fill and show an embedded listbox on dialog menu.
//-----------------------------------------------------------------------------
#include "\x\cba\addons\ui\script_component.hpp"
#include "data\common.hpp"

private ["_menuSources", "_menuDefs", "_idc", "_iconFolder"];
private["_menuOption", "_caption", "_action", "_icon", "_tooltip", "_shortcut_DIK", "_visible", "_enabled", "_array"];

_menuDefs = _this call FUNC(getMenuDef);
//-----------------------------------------------------------------------------
// replace primary menu's key EH and menuDefs with same key EH but using secondary menu's menuDefs
(uiNamespace getVariable QUOTE(GVAR(display))) displayRemoveEventHandler ["keyDown", GVAR(keyDownEHID)];
_menuSources = _this select 1;
GVAR(keyDownEHID) = (uiNamespace getVariable QUOTE(GVAR(display))) displayAddEventHandler ["keyDown", 
	format ["[_this, [%1, %2]] call %3", QUOTE(GVAR(target)), _menuSources, QUOTE(FUNC(menuShortcut))]];

_caption = if (count (_menuDefs select 0) > _flexiMenu_menuProperty_ID_menuDesc) then {_menuDefs select 0 select _flexiMenu_menuProperty_ID_menuDesc} else {""};
((uiNamespace getVariable QUOTE(GVAR(display))) displayCtrl _flexiMenu_IDC_listMenuDesc) ctrlSetText _caption;

_iconFolder = if (count (_menuDefs select 0) > _flexiMenu_menuProperty_ID_iconFolder) then {_menuDefs select 0 select _flexiMenu_menuProperty_ID_iconFolder} else {""}; // base icon folder (eg: "\ca\ui\data\")
//-----------------------------------------------------------------------------
_menuRsc = _menuDefs select 0 select _flexiMenu_menuProperty_ID_menuResource;
if (typeName _menuRsc != typeName "") exitWith {diag_log format ["%1: Invalid params c4: %2", __FILE__, _this]};
if (!isClass (configFile >> _menuRsc)) then // if not a full class name
{
	_menuRsc = _menuRscPrefix+_menuRsc; // attach standard flexi menu prefix
};

// TODO: Support missionConfigFile too
_width = getNumber(ConfigFile >> _menuRsc >> "flexiMenu_subMenuCaptionWidth");
if (_width == 0) then
{
	player sideChat format ["Error: missing flexiMenu_subMenuCaptionWidth: %1", _menuRsc];
	_width = _SMW;
};

with uiNamespace do
{
	_idc = _flexiMenu_IDC_listMenuDesc;
	_array = ctrlPosition (GVAR(display) displayCtrl _idc);
	if ({_x == 0} count _array != 4) then
	{
		if (_array select 2 == 0) then
		{
			_array = [_array select 0, _array select 1, _width, _array select 3];
			(GVAR(display) displayCtrl _idc) ctrlSetPosition _array;

			(GVAR(display) displayCtrl _idc) ctrlCommit 0; // commit pos/size before showing
		};
	};
	(GVAR(display) displayCtrl _idc) ctrlShow true;
};

// TODO: Support missionConfigFile too
// TODO: For merged menus, _menuRsc must come from the first merged menu, not secondary.
_width = getNumber(ConfigFile >> _menuRsc >> "flexiMenu_subMenuControlWidth");
//player sideChat format ["control width = %1", [_width, _menuRsc]];
if (_width == 0) then
{
	player sideChat format ["Error: missing flexiMenu_subMenuControlWidth: %1", _menuRsc];
	_width = _SMW;
};

_idc = _flexiMenu_baseIDC_listButton;
//-----------------------------------------------------------------------------
{ // forEach
	_menuOption = [_menuDefs select 0, _x] call FUNC(getMenuOption);

	_caption = _menuOption select _flexiMenu_menuDef_ID_caption;
	_action = _menuOption select _flexiMenu_menuDef_ID_action;
	_icon = _menuOption select _flexiMenu_menuDef_ID_icon;
	_tooltip = _menuOption select _flexiMenu_menuDef_ID_tooltip;
	_subMenu = _menuOption select _flexiMenu_menuDef_ID_subMenuSource;
	_shortcut_DIK = _menuOption select _flexiMenu_menuDef_ID_shortcut;
	_enabled = _menuOption select _flexiMenu_menuDef_ID_enabled;
	_visible = _menuOption select _flexiMenu_menuDef_ID_visible;

	with uiNamespace do
	{
		_array = ctrlPosition (GVAR(display) displayCtrl _idc);
		if ({_x == 0} count _array == 4) then
		{
			if (!isNull GVAR(display)) exitWith
			{
				diag_log format ["Warning: Too many menu items or missing List button control: %1", 
					[_menuRsc, _idc, _caption]]
			};
		}
		else
		{
			if (_array select 2 == 0) then
			{
				_array = [_array select 0, _array select 1, _width, _array select 3];
				(GVAR(display) displayCtrl _idc) ctrlSetPosition _array;
//diag_log format ["Adjusting list width to: %1", _width];
			};
		};

		(GVAR(display) displayCtrl _idc) ctrlSetStructuredText parseText _caption;
		(GVAR(display) displayCtrl _idc) ctrlSetToolTip _tooltip;
		(GVAR(display) displayCtrl _idc) buttonSetAction _action;

		(GVAR(display) displayCtrl _idc) ctrlCommit 0; // commit pos/size before showing

		(GVAR(display) displayCtrl _idc) ctrlShow (_visible > 0);
		(GVAR(display) displayCtrl _idc) ctrlEnable (_enabled != 0);
	};
	if (_visible != 0) then // i.e. in [-1,1]
	{
		_idc = _idc+1;
	}; // else if (_visible == 0) then {re-use hidden button idc}
} forEach (_menuDefs select 1);
//-----------------------------------------------------------------------------
// hide and disable unused list buttons
with uiNamespace do
{
	for [{_i = _idc}, {_i < _flexiMenu_baseIDC_listButton+_flexiMenu_maxButtons}, {_i = _i + 1}] do
	{
		(GVAR(display) displayCtrl _i) ctrlShow false;
		(GVAR(display) displayCtrl _i) ctrlEnable false;
	};
};
//-----------------------------------------------------------------------------
_idc = _flexiMenu_baseIDC_listButton;
ctrlSetFocus (GVAR(display) displayCtrl _idc);
