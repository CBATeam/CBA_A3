#include "\x\cba\addons\ui\script_component.hpp"
#include "data\common.hpp"
//-----------------------------------------------------------------------------
// TODO: Menu string parameter substitutions. Eg: _action="[%ID%] call func". Eg: %ID%,<ID>
// TODO: Consider adding: a base IDC override value.
// TODO: Consider adding: a max buttons override value.
// TODO: Consider adding: x,y menu offsets override values.
// TODO: Consider adding: auto centering x,y menu offsets. Each menu dialog may need it's own center.sqf script.
// TODO: Consider adding: menu properties source value.
// TODO: Consider adding: "stay open" menu or menu option property (see menuStayOpenUponSelect), eg: for NV adjustment or VD adjustment, etc. TODO: Clarify: presumably upon releasing interact key. Close with right click.
// TODO: Consider adding: pass parameters [object, caller] to action
// TODO high: Pass in _target as param in keyDown: nul = [_target, _menuSource] call FUNC(menu);
// TODO: Consider adding: object menu interaction radius (similar to userAction class). (Specify where?)
// TODO: Bug: the rsc of curr menu is not properly passed on to list menu, whereby default menu param gets used instead (if different).
// TODO (half done): Refactor: the dialog display speed has deteriorated with the inclusion of shortcut handling and 'clean drawing'. Investigate possible performance improvements. Replace KRON string functions maybe.
// TODO high: Consider adding: "default menu source" in first array of menu def (same as "optional icon folder") to allow nominated (usually same) menu file to be re-used for same section of menu tree.
// TODO: how to distinguish external/internal vehicle actions
// TODO medium/easy: Support missionConfigFile too

// Desc: Determine which menu resource to display. Create and init the menu using menu def's param.
// Pass optional paramters (if used) to determine which menu to use and/or alter it's properties.
//-----------------------------------------------------------------------------
// Notes: CBA_UI_fnc_setObjectMenuSource allows you to assign a menu source to a particular object. It will add an object variable called QUOTE(GVAR(flexiMenu_source)) containing the menu source.
//-----------------------------------------------------------------------------
// Syntax 1: _source
//   _this = menu definition source string
//   Eg 1.1: sqf filename. Eg: 'path\file.sqf'
//   Eg 1.2: 'call function' code string. Eg: '_this call someFunction'
//   Eg 1.3: 'call compile' code string. Eg: '_this call compile preprocessFileLineNumbers "file.sqf"'
// Syntax 2: globalSingleMenuDef array
// ToDo: Consider deleting this syntax.
//   _this = single menu definition array
//   Eg 2: array. Eg: [["menu properties...", ...], [["", "", "", "", "", -1, 1, 1], ...]]
// Syntax 3: [_source, _params]
//   _this select 0 = menu definition source string
//   _this select 1 = optional menu script parameters (type: any, syntax: any). Eg: ['menu name', 'menu resource name']
//   Eg 3: array: [menu definition source string, paramters]. Eg: ["mission\ammoCrate_menuDef.sqf", ["main", _menuRsc]]
//-----------------------------------------------------------------------------
/* submenu is either: 
	a menuDef array variable, - typeName "array"
	"_this call function", - typeName "string" - space but no dot, nor quotes
	"_this call compile preprocessFileLineNumbers 'mission\sys_crewserved_menuDef.sqf'" - typeName "string" - dot and space and embedded quotes
	"mission\sys_crewserved_subMenu1.sqf" - typeName "string" - dot and no space, nor quotes
*/
// General menu definition syntax:
// Note: subMenu follows the _source syntax above
/*
[
	["Menu Caption", "flexiMenu resource dialog", "optional icon folder", menuStayOpenUponSelect],
	[
		[
			"caption", 
			"action", 
			"icon", 
			"tooltip", 
			{"submenu"|["menuName", "", {0/1} (optional - use embedded list menu)]}, 
			-1 (shortcut DIK code), // TODO: Allow string ("Z") type shortcut designation
			{0/1/"0"/"1"/false/true} (enabled), 
			{0|1|2/"0"|"1"|"2"/false/true} (visible)]
	]
]
Note: visible allows value 2 to make the current button be re-used for the next menu item, rather than hidden and left as a gap. It is dependent on the design of the menu dialog used.
*/

// For each menu option, only the caption and action are required paramters. The other parameters are optional.
/*
[
	["Menu Name": type Any, "Menu Caption": string, "menu dialog class or suffix id": string, "\ca\ui\data\": string, "menuStayOpenUponSelect": boolean],
	[
		["caption 1", "player sideChat 'selected option 1'", "iconplane_ca.paa", "hint 1", "", -1, 1, 1],
		...]
	]
*/
//-----------------------------------------------------------------------------
private ["_valid", "_menuDefs", "_menuParams", "_menuRsc", "_array", "_i", 	"_t", "_w", "_idcIndex", "_idc"];
private ["_caption", "_action", "_icon", "_subMenu", "_tooltip", "_shortcut_DIK", "_visible", "_enabled"];
private ["_params", "_useListBox", "_menuOption", "_commitList", "_menuRscPrefix", "_source", "_width"];

//player sideChat format [__FILE__+": %1", _this];

/*
_valid = (!isNil {uiNamespace getVariable QUOTE(GVAR(display))});
if (_valid) then
{
  _valid = (!isNull (uiNamespace getVariable QUOTE(GVAR(display))));
};
if (_valid) exitWith {hint format["%1 is not nil", GVAR(display)]}; // or ignore and overwrite
*/
//-----------------------------------------------------------------------------
if !(typeName _this in [typeName [], typeName ""]) exitWith {diag_log format ["%1: Invalid params type: %2", __FILE__, _this]};

_menuDefs = _this call FUNC(getMenuDef);
//-----------------------------------------------------------------------------
if (typeName _menuDefs != typeName []) exitWith {diag_log format ["%1: Invalid params c5: %2", __FILE__, _this]};
if (count _menuDefs == 0) exitWith {diag_log format ["%1: Invalid params c1: %2", __FILE__, _this]};
if (count _menuDefs < 2) exitWith {diag_log format ["%1: Invalid params c2: %2", __FILE__, _this]};
if (count (_menuDefs select 0) <= _flexiMenu_menuProperty_ID_menuResource) exitWith {diag_log format ["%1: Invalid params c3: %2", __FILE__, _this]};
_menuRsc = _menuDefs select 0 select _flexiMenu_menuProperty_ID_menuResource; // determine which dialog to show

if (typeName _menuRsc != typeName "") exitWith {diag_log format ["%1: Invalid params c4: %2", __FILE__, _this]};
if (!isClass (configFile >> _menuRsc)) then // if not a full class name
{
	_menuRsc = _menuRscPrefix+_menuRsc; // attach standard flexi menu prefix
};
if (!createDialog _menuRsc) exitWith {hint format ["%1: createDialog failed: %2", __FILE__, _menuRsc]};
setMousePosition [0.5, 0.5];
//if (isNil QUOTE(GVAR(display))) exitWith {hint format["%1 is nil", GVAR(display)]};
//if (isNull GVAR(display)) exitWith {hint format["%1 is null", GVAR(display)]};

_caption = if (count (_menuDefs select 0) > _flexiMenu_menuProperty_ID_menuDesc) then {_menuDefs select 0 select _flexiMenu_menuProperty_ID_menuDesc} else {""};
((uiNamespace getVariable QUOTE(GVAR(display))) displayCtrl _flexiMenu_IDC_menuDesc) ctrlSetText _caption;

#ifndef _flexiMenu_useSlowCleanDrawMode
// initially hide all list buttons
for [{_i = 0}, {_i < _flexiMenu_maxListButtons}, {_i = _i + 1}] do
{
  _idc = _flexiMenu_baseIDC_listButton+_i;
	if (isNull ((uiNamespace getVariable QUOTE(GVAR(display))) displayCtrl _idc)) exitWith {};
  ((uiNamespace getVariable QUOTE(GVAR(display))) displayCtrl _idc) ctrlShow false;
	//((uiNamespace getVariable QUOTE(GVAR(display))) displayCtrl _idc) ctrlEnable false;
};
#endif
// initially list caption
((uiNamespace getVariable QUOTE(GVAR(display))) displayCtrl _flexiMenu_IDC_listMenuDesc) ctrlShow false;

// TODO: Can't find a CBA macro for dialog EH's.
GVAR(keyDownEHID) = (uiNamespace getVariable QUOTE(GVAR(display))) displayAddEventHandler ["keyDown", 
	format ["[_this, %1] call %2", _this, QUOTE(FUNC(menuShortcut))]];

_idcIndex = 0;

#ifdef _flexiMenu_useSlowCleanDrawMode
// TODO: Support missionConfigFile too
_width = getNumber(ConfigFile >> _menuRsc >> "flexiMenu_primaryMenuControlWidth");
if (_width == 0) then
{
	player sideChat format ["Error: missing flexiMenu_primaryMenuControlWidth: %1", _menuRsc];
	_width = _SMW;
};
#endif
//-----------------------------------------------------------------------------
_commitList = [];
{ // forEach
	if (count _x >= 2) then // all essential array items exist
	{
		_idc = _flexiMenu_baseIDC_button+_idcIndex;
		_menuOption = [_menuDefs select 0, _x] call FUNC(getMenuOption);

		_caption = _menuOption select _flexiMenu_menuDef_ID_caption;
		_action = _menuOption select _flexiMenu_menuDef_ID_action;
		_icon = _menuOption select _flexiMenu_menuDef_ID_icon;
		_tooltip = _menuOption select _flexiMenu_menuDef_ID_tooltip;
		_subMenu = _menuOption select _flexiMenu_menuDef_ID_subMenuSource;
		_shortcut_DIK = _menuOption select _flexiMenu_menuDef_ID_shortcut;
//if (_shortcut_DIK != -1) then {player sidechat str [_caption, _shortcut_DIK, round time]};
		_enabled = _menuOption select _flexiMenu_menuDef_ID_enabled;
		_visible = _menuOption select _flexiMenu_menuDef_ID_visible;

		if (_caption != "") then
		{
			with uiNamespace do
			{
#ifdef _flexiMenu_useSlowCleanDrawMode
				_array = ctrlPosition (GVAR(display) displayCtrl _idc);
				if ({_x == 0} count _array == 4) then
				{
					if (!isNull GVAR(display)) exitWith {diag_log format ["Warning: Too many menu items or missing Menu button control: %1", [_menuRsc, _idc, _caption]]};
				}
				else
				{
					if (_array select 2 == 0) then
					{
						_array = [_array select 0, _array select 1, _width, _array select 3];
						(GVAR(display) displayCtrl _idc) ctrlSetPosition _array;
					};
				};

				(GVAR(display) displayCtrl _idc) ctrlCommit 0; // commit pos/size before showing
#endif

				(GVAR(display) displayCtrl _idc) ctrlSetStructuredText parseText _caption;
				(GVAR(display) displayCtrl _idc) ctrlSetToolTip _tooltip;
				buttonSetAction [_idc, _action];

				_commitList set[count _commitList, [_idc, _enabled, _visible]];
			};

			_idcIndex = _idcIndex+1;
		};
	};
} forEach (_menuDefs select 1);
//-----------------------------------------------------------------------------
// handle odd case where uncommitted controls are not shown
{
	_t = time;
	_idc = _x select 0;
	if (!ctrlCommitted (GVAR(display) displayCtrl _idc)) then
	{
		waitUntil {ctrlCommitted (GVAR(display) displayCtrl _idc) || time > _t+1.9};
	};
	_enabled = _x select 1;
	_visible = _x select 2;
	ctrlShow [_idc, (_visible != 0)];
	ctrlEnable [_idc, (_enabled != 0)];
} forEach _commitList;

// hide and disable unused buttons
// Note: you still need to disable hidden buttons because you can tab to them otherwise!
with uiNamespace do
{
	for [{_i = _idcIndex}, {_i < _flexiMenu_maxButtons}, {_i = _i + 1}] do
	{
		_idc = _flexiMenu_baseIDC_button+_i;
		(GVAR(display) displayCtrl _idc) ctrlShow false;
		(GVAR(display) displayCtrl _idc) ctrlEnable false;
	};
//#ifndef _flexiMenu_useSlowCleanDrawMode
	// hide and disable unused list buttons
	for [{_i = 0}, {_i < _flexiMenu_maxButtons}, {_i = _i + 1}] do
	{
		_idc = _flexiMenu_baseIDC_listButton+_i;
		(GVAR(display) displayCtrl _idc) ctrlShow false;
		(GVAR(display) displayCtrl _idc) ctrlEnable false;
	};
//#endif
};
