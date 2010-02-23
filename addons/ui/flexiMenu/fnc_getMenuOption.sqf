// Desc: parse and set menu option record values
// _this = [_menuDefs select 0, _menuDefs select 1 select N] (header & one menu def)
//-----------------------------------------------------------------------------
private["_menuDefs0", "_menuDef", 
	"_result", "_caption", "_action", "_icon", "_tooltip", "_subMenu", "_shortcut_DIK", "_visible", "_enabled", 
	"_array", "_index", "_containCaret", "_subMenuSource", "_asciiKey", "_iconFolder", "_multiReselect",
	"_keyName", "_offset", "_params", "_useListBox"];

#include "\x\cba\addons\ui\script_component.hpp"
#include "\ca\editor\Data\Scripts\dikCodes.h"
#include "DIKASCIIMap.hpp"
#include "data\common.hpp"

_menuDefs0 = _this select 0;
_menuDef = _this select 1;

_iconFolder = if (count _menuDefs0 > _flexiMenu_menuProperty_ID_iconFolder) then {_menuDefs0 select _flexiMenu_menuProperty_ID_iconFolder} else {""}; // base icon folder (eg: "\ca\ui\data\")
_multiReselect = if (count _menuDefs0 > _flexiMenu_menuProperty_ID_multiReselect) then {_menuDefs0 select _flexiMenu_menuProperty_ID_multiReselect} else {0}; // menuStayOpenUponSelect: 0/1 type boolean
if (typeName _multiReselect == typeName true) then {_multiReselect = if (_multiReselect) then {1}else{0}};

_caption = "";
_action = "";
_icon = "";
_tooltip = "";
_subMenu = "";
_shortcut_DIK = -1;
_enabled = 0;
_visible = 0;
//-----------------------------------------------------------------------------
_caption = _menuDef select _flexiMenu_menuDef_ID_caption;
_shortcut_DIK = if (count _menuDef > _flexiMenu_menuDef_ID_shortcut) then {_menuDef select _flexiMenu_menuDef_ID_shortcut} else {-1};
_tooltip = if (count _menuDef > _flexiMenu_menuDef_ID_tooltip) then {_menuDef select _flexiMenu_menuDef_ID_tooltip} else {""};

// enabled
_enabled = if (count _menuDef > _flexiMenu_menuDef_ID_enabled) then {_menuDef select _flexiMenu_menuDef_ID_enabled} else {1};
if (isNil "_enabled") then
{
	hint ("Error logged: 'enabled' menu property returned nil.\n\n"+
		format["Source data: %1", _this]);
	ERROR_WITH_TITLE("'enabled' menu property returned nil.", str _this);
	_enabled = 0; 
	_caption = "Error: "+_caption;
};
if (typeName _enabled != typeName 2) then
{
	if (typeName _enabled == typeName "") then {_enabled = parseNumber _enabled}; // allow "0"/"1" like BIS does
	if (typeName _enabled == typeName true) then {_enabled = if (_enabled) then {1}else{0}}; // convert boolean to number
};

// visible
_visible = if (count _menuDef > _flexiMenu_menuDef_ID_visible) then {_menuDef select _flexiMenu_menuDef_ID_visible} else {1};
if (isNil "_visible") then
{
	hint ("Error logged: 'visible' menu property returned nil.\n\n"+
		format["Source data: %1", _this]);
	ERROR_WITH_TITLE("'visible' menu property returned nil.", str _this);
	_visible = 0; 
	_caption = "Error: "+_caption;
};
if (typeName _visible != typeName 2) then
{
	if (typeName _visible == typeName "") then {_visible = parseNumber _visible}; // allow "0"/"1"/"2" like BIS does
	if (typeName _visible == typeName true) then {_visible = if (_visible) then {1}else{0}}; // convert boolean to number
};
//-----------------------------------------------------------------------------
// search for "^" embedded caption shortcut
_array = toArray /* toUpper */ _caption;

// find hot key marker char "^"
_index = _array find 94; // "^"
_containCaret = (_index >= 0 && _index < (count _array)-1);
// ensure a char follows eg: "^S" (i.e. "^" is not last char)
_asciiKey = -1;
if (_containCaret) then
{
	_shortcut_DIK = -1; // caret shortcut overrides DIK shortcut, so remove any DIK shortcut (if any)
	_asciiKey = (toArray toUpper toString [_array select (_index+1)]) select 0;
};

if (_enabled != 0 && _visible > 0) then
{
	if (_shortcut_DIK == -1 && _asciiKey != -1) then
	{
		// find DIK code based on asciiKey ('Z'->DIK_Z)
		{
			if (_x select 0 == _asciiKey) exitWith
			{
				_shortcut_DIK = (_x select 1);
	//if (_index >= 0) then {player sideChat str ["found ^ for ", _asciiKey, _x, _shortcut_DIK]};
			};
		} forEach ICE_DIKASCIIMap;
	};
	// mark coloured shortcut letter
	if (_shortcut_DIK != -1 && !_containCaret) then
	{
		// find asciiKey based on DIK code (DIK_Z->'Z')
		{
			if (_x select 1 == _shortcut_DIK) exitWith
			{
				_asciiKey = (_x select 0);
			};
		} forEach ICE_DIKASCIIMap;

		_index = _array find _asciiKey; // uppercase key
		if (_index >= 0) then
		{
		}
		else
		{
			_index = _array find (_asciiKey+32); // lowercase key
		};
	};
}
else
{
	_shortcut_DIK = -1; // disable shortcut for disabled menu options
	if (_shortcut_DIK != -1) then {player sidechat str [_caption, _shortcut_DIK, _enabled, _visible]};	
};

// remove "^" from caption and substitute coloured shortcut letter if enabled.
if (_index >= 0) then
{
	if (_enabled != 0) then
	{
		private ["_offset"];

//#define _ST_highlightKey_attribute "<t underline='true'>"
//#define _ST_highlightKey_attribute "<t color='#f0ffff00'>"
#define _ST_highlightKey_attribute "<t color='#f07EB27E'>"

// TODO: Read an appropriate color from the menu class.

		_offset = (if (_containCaret) then {1} else {0});
		_caption = [_array, _index, _offset, _ST_highlightKey_attribute] call FUNC(highlightCaretKey);
	}
	else
	{
		_array = _array-[94]; // "^"
		_caption = toString _array;
	};
}
else
{
	// map menu shortcut DIK code
	if (_shortcut_DIK != -1) then
	{
		private ["_keyName"];
		_keyName = keyName _shortcut_DIK;
		_array = toArray _keyName;
		if (count _array > 2) then
		{
			_array = _array-[34]; // 34=("). Strip off leading and trailing quotes.
		};
		_keyName = toString _array;
		
		// append shortcut key name to caption. Eg: "Option (F9)".
		_caption = _caption+format[" (%1%2</t>)", _ST_highlightKey_attribute, _keyName];
	};
};
//-----------------------------------------------------------------------------
_icon = "";
if (count _menuDef > _flexiMenu_menuDef_ID_icon) then
{
	_icon = _menuDef select _flexiMenu_menuDef_ID_icon;
	if (_icon != "") then
	{
		_array = toArray _icon;
		// if pathname does not already contain a folder path
		if (_iconFolder != "" && _array find 92 < 0 && _array find 47 < 0) then // 92='\', 47='/'
		{
			_icon = _iconFolder+_icon;
		};
		_caption = format ["<img image='%2'/> %1", _caption, _icon];
	};
};
//-----------------------------------------------------------------------------
_action = "";
if (_caption != "") then
{
	// default option handling
	_action = "";
	if (_multiReselect == 0) then {_action = format["%1 = true;", QUOTE(GVAR(optionSelected))];};
	// prefix with custom option handling
	if ((_menuDef select _flexiMenu_menuDef_ID_action) != "") then
	{
		_action = _action+";"+(_menuDef select _flexiMenu_menuDef_ID_action);
	};

	// append optional sub menu handling
	_subMenu = if (count _menuDef > _flexiMenu_menuDef_ID_subMenuSource) then {_menuDef select _flexiMenu_menuDef_ID_subMenuSource} else {""};
//diag_log "_subMenu="+_subMenu;
//player groupchat _subMenu;
	_subMenuSource = "";
	_params = ["?"];
	_useListBox = 0;
	if (typeName _subMenu == typeName []) then
	{
		_subMenuSource = _subMenu select 0;
		_params = _subMenu select 1;
		_useListBox = if (count _subMenu > 2) then {_subMenu select 2} else {0};
	}
	else // else (assume?) it was a string
	{
		_subMenuSource = _subMenu;
	};
	// add code to action to show sub menu
	if (_subMenuSource != "") then
	{
		_action = format ["%1;[%5, [[%2, %3]]] call compile preprocessFileLineNumbers '%4'", 
			_action, 
// TODO: Does _subMenuSource need to handle merged menus too?
			str _subMenuSource, 
			if (typeName _params == typeName []) then {_params} else {str _params},
			if (_useListBox == 0) then {
				QUOTE(PATHTO_SUB(PREFIX,COMPONENT_F,flexiMenu,fnc_menu))
			} else {
				QUOTE(PATHTO_SUB(PREFIX,COMPONENT_F,flexiMenu,fnc_list)) },
			QUOTE(GVAR(target))
		];
	};
	if (_useListBox == 0 && _multiReselect == 0) then // if using embedded listBox && close upon selection
	{
		_action = "closeDialog 0;"+_action;
	};
};
//-----------------------------------------------------------------------------
_result = [];
_result set [_flexiMenu_menuDef_ID_caption, _caption];
_result set [_flexiMenu_menuDef_ID_action, _action];
_result set [_flexiMenu_menuDef_ID_icon, _icon];
_result set [_flexiMenu_menuDef_ID_tooltip, _tooltip];
_result set [_flexiMenu_menuDef_ID_subMenuSource, _subMenu];
_result set [_flexiMenu_menuDef_ID_shortcut, _shortcut_DIK];
_result set [_flexiMenu_menuDef_ID_enabled, _enabled];
_result set [_flexiMenu_menuDef_ID_visible, _visible];
_result
