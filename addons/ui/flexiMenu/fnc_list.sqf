disableSerialization;
// Desc: Fill and show an embedded listbox on dialog menu.
//-----------------------------------------------------------------------------
#include "..\script_component.hpp"

private _menuDefs = _this call FUNC(getMenuDef);
//-----------------------------------------------------------------------------
// replace primary menu's key EH and menuDefs with same key EH but using secondary menu's menuDefs

private _disp = uiNamespace getVariable QGVAR(display);
_disp displayRemoveEventHandler ["KeyDown", GVAR(keyDownEHID)];
params ["", "_menuSources"];

GVAR(keyDownEHID) = _disp displayAddEventHandler ["KeyDown",
    format ["[_this, [%1, %2]] call %3", QGVAR(target), _menuSources, QUOTE(FUNC(menuShortcut))]];

private _caption = if (count (_menuDefs select 0) > _flexiMenu_menuProperty_ID_menuDesc) then {_menuDefs select 0 select _flexiMenu_menuProperty_ID_menuDesc} else {""};
(_disp displayCtrl _flexiMenu_IDC_listMenuDesc) ctrlSetText _caption;

private _iconFolder = if (count (_menuDefs select 0) > _flexiMenu_menuProperty_ID_iconFolder) then {_menuDefs select 0 select _flexiMenu_menuProperty_ID_iconFolder} else {""}; // base icon folder (eg: "\ca\ui\data\")
//-----------------------------------------------------------------------------
private _menuRsc = _menuDefs select 0 select _flexiMenu_menuProperty_ID_menuResource;
private _msg = format ["%1: Invalid params c4: %2", __FILE__, _this];

if (isNil "_msg") then  {_msg = "FLEXIMENU: Unknown Error in fnc_list.sqf"};
if (typeName _menuRsc != "STRING") exitWith {diag_log _msg};

if (!isClass (configFile >> _menuRsc) && {!isClass (missionConfigFile >> _menuRsc)}) then { // if not a full class name
    _menuRsc = __menuRscPrefix + _menuRsc; // attach standard flexi menu prefix
};

// TODO: Support missionConfigFile too
private _width = getNumber (configFile >> _menuRsc >> "flexiMenu_subMenuCaptionWidth");
if (_width == 0) then {
    player sideChat format ["Error: missing flexiMenu_subMenuCaptionWidth: %1", _menuRsc];
    _width = __SMW_default;
};

private _idc = _flexiMenu_IDC_listMenuDesc;
private _ctrl = _disp displayCtrl _idc;
private _array = ctrlPosition _ctrl;

if ({_x == 0} count _array != 4 && {_array select 2 == 0}) then {
    _array = [_array select 0, _array select 1, _width, _array select 3];
    _ctrl ctrlSetPosition _array;

    _ctrl ctrlCommit 0; // commit pos/size before showing
};
_ctrl ctrlShow true;

// TODO: For merged menus, _menuRsc must come from the first merged menu, not secondary.
_width = getNumber (missionConfigFile >> _menuRsc >> "flexiMenu_subMenuControlWidth");
if (_width == 0) then {
    _width = getNumber (configFile >> _menuRsc >> "flexiMenu_subMenuControlWidth");
    if (_width == 0) then {
        player sideChat format ["Error: missing flexiMenu_subMenuControlWidth: %1", _menuRsc];
        _width = __SMW_default;
    };
};

GVAR(hotKeyColor) = getText (missionConfigFile >> _menuRsc >> "flexiMenu_hotKeyColor");
if (GVAR(hotKeyColor) == "") then {
    GVAR(hotKeyColor) = getText (configFile >> _menuRsc >> "flexiMenu_hotKeyColor");
    if (GVAR(hotKeyColor) == "") then {
        GVAR(hotKeyColor) = __defaultHotkeyColor;
    };
};

_idc = _flexiMenu_baseIDC_listButton;
//-----------------------------------------------------------------------------
{ // forEach
    private _menuOption = [_menuDefs select 0, _x] call FUNC(getMenuOption);

    private _caption = _menuOption select _flexiMenu_menuDef_ID_caption;
    private _action = _menuOption select _flexiMenu_menuDef_ID_action;
    private _icon = _menuOption select _flexiMenu_menuDef_ID_icon;
    private _tooltip = _menuOption select _flexiMenu_menuDef_ID_tooltip;
    private _subMenu = _menuOption select _flexiMenu_menuDef_ID_subMenuSource;
    private _shortcut_DIK = _menuOption select _flexiMenu_menuDef_ID_shortcut;
    private _enabled = _menuOption select _flexiMenu_menuDef_ID_enabled;
    private _visible = _menuOption select _flexiMenu_menuDef_ID_visible;

    _ctrl = _disp displayCtrl _idc;
    _array = ctrlPosition _ctrl;

    if ({_x == 0} count _array == 4) then {
        if (!isNull _disp) exitWith {
            diag_log format ["Warning: Too many menu items or missing List button control: %1",
                [_menuRsc, _idc, _caption]]
        };
    } else {
        if (_array select 2 == 0) then {
            _array = [_array select 0, _array select 1, _width, _array select 3];
            _ctrl ctrlSetPosition _array;
        };
    };

    _ctrl ctrlSetStructuredText parseText _caption;
    _ctrl ctrlSetTooltip _tooltip;
    _ctrl buttonSetAction _action;

    _ctrl ctrlCommit 0; // commit pos/size before showing

    _ctrl ctrlShow (_visible > 0);
    _ctrl ctrlEnable (_enabled != 0);

    if (_visible != 0) then { // i.e. in [-1,1]
        _idc = _idc + 1;
    }; // else if (_visible == 0) then {re-use hidden button idc}
} forEach (_menuDefs select 1);
//-----------------------------------------------------------------------------
// hide and disable unused list buttons
for "_i" from _idc to (_flexiMenu_baseIDC_listButton + _flexiMenu_maxButtons - 1) do {
    _ctrl = _disp displayCtrl _i;
    _ctrl ctrlShow false;
    _ctrl ctrlEnable false;
};
//-----------------------------------------------------------------------------
_idc = _flexiMenu_baseIDC_listButton;
ctrlSetFocus (_disp displayCtrl _idc);
