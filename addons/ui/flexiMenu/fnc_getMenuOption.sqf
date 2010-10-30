// Desc: parse and set menu option record values
// _this = [_menuDefs select 0, _menuDefs select 1 select N] (header & one menu def)
//-----------------------------------------------------------------------------
#include "\x\cba\addons\ui\script_component.hpp"
#include "\ca\editor\Data\Scripts\dikCodes.h"
#include "DIKASCIIMap.hpp"

#define _flexiMenuSeparatorLine "<img image='\x\cba\addons\ui\flexiMenu\data\popup\separator.paa'/>"//<t size='1'> </t>  <t underline='true'>a    c</t>

private["_menuDefs0", "_menuDef", "_fastPartialResult",
	"_result", "_caption", "_action", "_actionOptions", "_icon", "_tooltip", "_subMenu", "_shortcut_DIK", "_visible", "_enabled",
	"_array", "_index", "_containCaret", "_asciiKey", "_iconFolder", "_multiReselect",
	"_keyName", "_offset"];

_menuDefs0 = _this select 0;
_menuDef = _this select 1;
IfCountDefault(_fastPartialResult,_this,2,false); // return a faster partial result, which ignores CPU intensive code like highlightCaretKey.

IfCountDefault(_iconFolder,_menuDefs0,_flexiMenu_menuProperty_ID_iconFolder,""); // base icon folder (eg: "\ca\ui\data\")
IfCountDefault(_multiReselect,_menuDefs0,_flexiMenu_menuProperty_ID_multiReselect,0); // menuStayOpenUponSelect: 0/1 type boolean
if (typeName _multiReselect == typeName true) then {_multiReselect = if (_multiReselect) then {1}else{0}}; // convert boolean to integer

_caption = "";
IfCountDefault(_action,_menuDef,_flexiMenu_menuDef_ID_action,"");
_icon = "";
_tooltip = "";
IfCountDefault(_subMenu,_menuDef,_flexiMenu_menuDef_ID_subMenuSource,"");
_shortcut_DIK = -1;
_enabled = 0;
_visible = 0;
//-----------------------------------------------------------------------------
_caption = _menuDef select _flexiMenu_menuDef_ID_caption;
IfCountDefault(_shortcut_DIK,_menuDef,_flexiMenu_menuDef_ID_shortcut,-1);
IfCountDefault(_tooltip,_menuDef,_flexiMenu_menuDef_ID_tooltip,"");

// enabled
IfCountDefault(_enabled,_menuDef,_flexiMenu_menuDef_ID_enabled,1);
if (isNil "_enabled") then {
	hint ("Error logged: 'enabled' menu property returned nil.\n\n" + format["Source data: %1", _this]);
	ERROR_WITH_TITLE("'enabled' menu property returned nil.", str _this);
	_enabled = 0;
	_caption = "Error: " + _caption;
};
if (typeName _enabled != typeName 2) then {
	if (typeName _enabled == typeName "") then {_enabled = parseNumber _enabled}; // allow "0"/"1" like BIS does
	if (typeName _enabled == typeName true) then {_enabled = if (_enabled) then {1} else {0}}; // convert boolean to number
};

// visible
IfCountDefault(_visible,_menuDef,_flexiMenu_menuDef_ID_visible,1);
if (isNil "_visible") then {
	hint ("Error logged: 'visible' menu property returned nil.\n\n" + format["Source data: %1", _this]);
	ERROR_WITH_TITLE("'visible' menu property returned nil.", str _this);
	_visible = 0;
	_caption = "Error: " + _caption;
};
if (typeName _visible != typeName 2) then {
	if (typeName _visible == typeName "") then {_visible = parseNumber _visible}; // allow "0"/"1"/"2" like BIS does
	if (typeName _visible == typeName true) then {_visible = if (_visible) then {1}else{0}}; // convert boolean to number
};

if (_caption == "-") then {
	_caption = _flexiMenuSeparatorLine;
	_enabled = 0;
};
//-----------------------------------------------------------------------------
// search for "^" embedded caption shortcut
_array = toArray /* toUpper */ _caption;

// find hot key marker char "^"
_index = _array find 94; // "^"
_containCaret = (_index >= 0 && _index < (count _array) - 1);
// ensure a char follows eg: "^S" (i.e. "^" is not last char)
_asciiKey = -1;
if (_containCaret) then {
	_shortcut_DIK = -1; // caret shortcut overrides DIK shortcut, so remove any DIK shortcut (if any)
	_asciiKey = (toArray toUpper toString [_array select (_index + 1)]) select 0;
};

if (_enabled != 0 && _visible > 0) then {
	if (_shortcut_DIK == -1 && _asciiKey != -1) then {
		// find DIK code based on asciiKey ('Z'->DIK_Z)
		{
			if (_x select 0 == _asciiKey) exitWith {_shortcut_DIK = _x select 1}
		} forEach ICE_DIKASCIIMap;
	};
	// mark coloured shortcut letter
	if (_shortcut_DIK != -1 && !_containCaret) then {
		// find asciiKey based on DIK code (DIK_Z->'Z')
		{
			if (_x select 1 == _shortcut_DIK) exitWith {_asciiKey = _x select 0}
		} forEach ICE_DIKASCIIMap;

		_index = _array find _asciiKey; // uppercase key
		if (_index < 0) then {
			_index = _array find (_asciiKey + 32); // lowercase key
		};
	};
} else {
	_shortcut_DIK = -1; // disable shortcut for disabled menu options
	if (_shortcut_DIK != -1) then {player sidechat str [_caption, _shortcut_DIK, _enabled, _visible]};
};

// remove "^" from caption and substitute coloured shortcut letter if enabled.
if (_index >= 0) then {
	if (_enabled != 0) then {
		private ["_offset"];

#define _ST_highlightKey_attribute "<t color='#f07EB27E'>"

// TODO: Read an appropriate color from the menu class.

		_offset = (if (_containCaret) then {1} else {0});
		if (!_fastPartialResult) then {
			_caption = [_array, _index, _offset, _ST_highlightKey_attribute] call FUNC(highlightCaretKey);
		};
	} else {
		_array = _array - [94]; // "^"
		_caption = toString _array;
	};
} else {
	// map menu shortcut DIK code
	// Note: don't append shortcut to empty caption, which is usually an "icon only" menu, without text captions.
	if (_shortcut_DIK != -1 && _caption != "") then {
		private ["_keyName"];
		_keyName = keyName _shortcut_DIK;
		_array = toArray _keyName;
		if (count _array > 2) then {
			_array = _array - [34]; // 34=("). Strip off leading and trailing quotes.
		};
		_keyName = toString _array;

		// append shortcut key name to caption. Eg: "Option (F9)".
		_caption = _caption+format[" (%1%2</t>)", _ST_highlightKey_attribute, _keyName];
	};
};
//-----------------------------------------------------------------------------
IfCountDefault(_icon,_menuDef,_flexiMenu_menuDef_ID_icon,"");
if (_icon != "" && !_fastPartialResult) then {
	_array = toArray _icon;
	// if pathname does not already contain a folder path
	if (_iconFolder != "" && _array find 92 < 0 && _array find 47 < 0) then { // 92='\', 47='/'
		_icon = _iconFolder + _icon;
	};
	_caption = format ["<img image='%2'/> %1", _caption, _icon];
};
//-----------------------------------------------------------------------------
if (_caption != "") then {
	_actionOptions = [_action, _subMenu, _multiReselect];

	// TODO: Consider changing _action array item from string to type code.
	_action = format ["%1 call %2", _actionOptions, QUOTE(FUNC(execute))];
};
//-----------------------------------------------------------------------------
_result = [];
_result resize _flexiMenu_menuDef_ID_totalIDs;
_result set [_flexiMenu_menuDef_ID_caption, _caption];
_result set [_flexiMenu_menuDef_ID_action, _action];
_result set [_flexiMenu_menuDef_ID_icon, _icon];
_result set [_flexiMenu_menuDef_ID_tooltip, _tooltip];
_result set [_flexiMenu_menuDef_ID_subMenuSource, _subMenu];
_result set [_flexiMenu_menuDef_ID_shortcut, _shortcut_DIK];
_result set [_flexiMenu_menuDef_ID_enabled, _enabled];
_result set [_flexiMenu_menuDef_ID_visible, _visible];
_result
