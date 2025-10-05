disableSerialization;
//#define DEBUG_MODE_FULL
#include "..\script_component.hpp"
//-----------------------------------------------------------------------------
// TODO: Menu string parameter substitutions. Eg: _action="[%ID%] call func". Eg: %ID%,<ID>
// TODO: Consider adding: a base IDC override value.
// TODO: Consider adding: a max buttons override value.
// TODO: Consider adding: x,y menu offsets override values.
// TODO: Consider adding: auto centering x,y menu offsets. Each menu dialog may need it's own center.sqf script.
// TODO: Consider adding: menu properties source value.
// TODO: Consider adding: "stay open" menu or menu option property (see menuStayOpenUponSelect), eg: for NV adjustment or VD adjustment, etc. TODO: Clarify: presumably upon releasing interact key. Close with right click.
// TODO: Consider adding: pass parameters [object, caller] to action
// TODO: Consider adding: object menu interaction radius (similar to userAction class). (Specify where?)
// TODO: Bug: the rsc of curr menu is not properly passed on to list menu, whereby default menu param gets used instead (if different).
// TODO (half done): Refactor: the dialog display speed has deteriorated with the inclusion of shortcut handling and 'clean drawing'. Investigate possible performance improvements. Replace KRON string functions maybe.
// TODO high: Consider adding: "default menu source" in first array of menu def (same as "optional icon folder") to allow nominated (usually same) menu file to be re-used for same section of menu tree.
// TODO: how to distinguish external/internal vehicle actions
// TODO medium/easy: Support missionConfigFile too
// TODO high: add in menu priority, similar to addAction
// TODO: if using multiple merged _menuSources, then it may need a "doMerge" or "priorityOne" option(s) to avoid merging in special cases.
// TODO: _minObjectInteractionDistance: Find a very fast way to determine vehicle size and orientation to calc suitable dist.

// Desc: Determine which menu resource to display. Create and init the menu using menu def's param.
// Pass optional paramters (if used) to determine which menu to use and/or alter it's properties.

// Note: Side effect of merging menus is that only the header of the first menu is retained.
// TODO: Losing secondary headers will lose things like iconFolder. Perhaps auto merge into menuOptions in advance.
// TODO: Somehow handle shortcut clashes between merged menus. Currently it will simply use first found entry.
//-----------------------------------------------------------------------------
// See http://dev-heaven.net/projects/cca/wiki/FlexiMenu for array syntax info.

// Notes: CBA_UI_fnc_setObjectMenuSource allows you to assign a menu source to a particular object. It will add an object variable called QGVAR(flexiMenu_source) containing the menu source.
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
            {0|1/"0"|"1"/false|true} (enabled),
            {-1|0|1/"-1"|"0"|"1"/false|true} (visible, -1 is special case for reserved hidden button)]
    ]
]
Note: visible allows value -1 (instead of 0) to make the current button be re-used for the next menu item, rather than hidden and left as a gap. It is dependent on the design of the menu dialog used.
*/

// For each menu option, only the caption and action are required paramters. The other parameters are optional.
/*
[
    ["Menu Name": type Any, "Menu Caption": string, "menu dialog class or suffix id": string, "\ca\ui\data\": string, "menuStayOpenUponSelect": boolean],
    [
        ["caption 1", "player sideChat 'selected option 1'", "iconplane_ca.paa", "hint 1", "", -1, 1, 1],
        ...
    ]
]
*/
//-----------------------------------------------------------------------------
private [
    "_msg", "_valid", "_menuSources", "_menuDefs", "_menuParams", "_menuRsc", "_array", "_t",
    "_w", "_idcIndex", "_idc", "_caption", "_action", "_icon", "_subMenu", "_tooltip",
    "_shortcut_DIK", "_visible", "_enabled", "_params", "_useListBox", "_menuOption", "_commitList",
    "_source", "_width", "_list"
];

#define _MenuOption_NoOptions ["No options", "<No options>", "", "", "", -1, 0, 1]
TRACE_1("INPUT Params []",_this);
//-----------------------------------------------------------------------------
_msg = "";
_msg = format ["%1: Invalid params type: %2", __FILE__, _this];

if (isNil "_msg") then  {_msg = "FLEXIMENU: Unknown Error in fnc_menu.sqf"};
if !(typeName _this in ["ARRAY", "STRING"]) exitWith {diag_log _msg};
TRACE_2("INPUT Params",_this select 0,_this select 1);

_menuDefs = _this call FUNC(getMenuDef);
TRACE_1("Get Menu Defs",_menuDefs);
//-----------------------------------------------------------------------------

//Array must be returned.
if (isNil "_menuDefs") then {diag_log format ["%1: Nil Warning: Expected type array from _menuDefs from target: %2 from source: %3", __FILE__, _this select 0, _this select 1]};
if (typeName _menuDefs != "ARRAY") exitWith {diag_log format ["%1: Invalid params c5: %2", __FILE__, _this]};

// Empty Array is allowed to signify that nothing should happen
if (count _menuDefs == 0) exitWith {
    #ifdef DEBUG_MODE_FULL
        diag_log format ["%1: _menuDefs is an empty, nothing to do. params c1: %2", __FILE__, _this];
    #endif
};

if (count _menuDefs < 2) exitWith {diag_log format ["%1: Invalid params c2: %2", __FILE__, _this]};
if (count (_menuDefs select 0) <= _flexiMenu_menuProperty_ID_menuResource) exitWith {diag_log format ["%1: Invalid params c3: %2", __FILE__, _this]};
_menuRsc = _menuDefs select 0 select _flexiMenu_menuProperty_ID_menuResource; // determine which dialog to show

TRACE_2("Determined which dialog to show",_flexiMenu_menuProperty_ID_menuResource,_menuRsc);

if (typeName _menuRsc != "STRING") exitWith {diag_log format ["%1: Invalid params c4: %2", __FILE__, _this]};
if (!isClass (configFile >> _menuRsc) && {!isClass (missionConfigFile >> _menuRsc)}) then { // if not a full class name
    _menuRsc = __menuRscPrefix + _menuRsc; // attach standard flexi menu prefix
};
if (!createDialog _menuRsc) exitWith {hint format ["%1: createDialog failed: %2", __FILE__, _menuRsc]};
setMousePosition [0.5, 0.5];

TRACE_2("Show Diaglog",_flexiMenu_menuProperty_ID_menuResource,_menuRsc);
private "_disp";
_disp = uiNamespace getVariable QGVAR(display);

IfCountDefault(_caption,(_menuDefs select 0),_flexiMenu_menuProperty_ID_menuDesc,"");
(_disp displayCtrl _flexiMenu_IDC_menuDesc) ctrlSetText _caption;

// initially list caption
(_disp displayCtrl _flexiMenu_IDC_listMenuDesc) ctrlShow false;

_menuSources = _this select 1;
GVAR(keyDownEHID) = _disp displayAddEventHandler ["KeyDown", format ["[_this, [%1, %2]] call %3", QGVAR(target), _menuSources, QUOTE(FUNC(menuShortcut))]];

_disp displayAddEventHandler ["MouseButtonDown", format ["_this call %1", QUOTE(FUNC(mouseButtonDown))]];

_idcIndex = 0;

_width = getNumber (missionConfigFile >> _menuRsc >> "flexiMenu_primaryMenuControlWidth");
if (_width == 0) then {
    _width = getNumber (configFile >> _menuRsc >> "flexiMenu_primaryMenuControlWidth");
    if (_width == 0) then {
        player sideChat format ["Error: missing flexiMenu_primaryMenuControlWidth: %1", _menuRsc];
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

//-----------------------------------------------------------------------------
GVAR(menuActionData) = [];
_commitList = [];
{ // forEach
    if (count _x >= 2) then { // all essential array items exist
        _idc = _flexiMenu_baseIDC_button + _idcIndex;
        _menuOption = [_menuDefs select 0, _x] call FUNC(getMenuOption);

        _caption = _menuOption select _flexiMenu_menuDef_ID_caption;
        _action = _menuOption select _flexiMenu_menuDef_ID_action;
        _icon = _menuOption select _flexiMenu_menuDef_ID_icon;
        _tooltip = _menuOption select _flexiMenu_menuDef_ID_tooltip;
        _subMenu = _menuOption select _flexiMenu_menuDef_ID_subMenuSource;
        _shortcut_DIK = _menuOption select _flexiMenu_menuDef_ID_shortcut;
        _enabled = _menuOption select _flexiMenu_menuDef_ID_enabled;
        _visible = _menuOption select _flexiMenu_menuDef_ID_visible;

        if (_caption != "" && {(_caption != "No options" || {_idcIndex == 0})}) then {
            private _ctrl = _disp displayCtrl _idc;
            _array = ctrlPosition _ctrl;
            if ({_x == 0} count _array == 4) then {
                if (!isNull _disp) exitWith {
                    diag_log format ["Warning: Too many menu items or missing Menu button control: %1", [_menuRsc, _idc, _caption]]
                };
            } else {
                if (_array select 2 == 0) then {
                    _array = [_array select 0, _array select 1, _width, _array select 3];
                    _ctrl ctrlSetPosition _array;
                };
            };

            _ctrl ctrlCommit 0; // commit pos/size before showing

            _ctrl ctrlSetStructuredText parseText _caption;
            _ctrl ctrlSetTooltip _tooltip;
            buttonSetAction [_idc, _action];

            _commitList pushBack [_idc, _enabled, _visible];

            // _visible==1 means: button used, go to next button.
            // _visible==0 means: button hidden and unused, so re-use this idc for next menu option.
            // _visible==-1 means: button hidden but reserved, so skip this idc and use next idc for next menu option.
            if (_visible != 0) then { // i.e. in [-1, 1]
                _idcIndex = _idcIndex + 1;
            };
        };
    };
} forEach (_menuDefs select 1) + [_MenuOption_NoOptions];
//-----------------------------------------------------------------------------
// if no menu options are shown/applicable
if (_idcIndex == 0) then {
    // TODO: This block is duplicate code from above. Find a tidy way to merge this back with code above, by adding fake "No options" menu option.
    _idc = _flexiMenu_baseIDC_button + _idcIndex;
    private _ctrl = _disp displayCtrl _idc;
    _array = ctrlPosition _ctrl;

    if (_array select 2 == 0) then {
        _array = [_array select 0, _array select 1, _width, _array select 3];
        _ctrl ctrlSetPosition _array;
    };

    _ctrl ctrlCommit 0; // commit pos/size before showing
    _ctrl ctrlSetStructuredText parseText "No options";
    _commitList pushBack [_idc, 0, 1];
    _idcIndex = _idcIndex + 1;
};

// handle odd case where uncommitted controls are not shown
{
    _t = time;
    _idc = _x select 0;
    if (!ctrlCommitted (_disp displayCtrl _idc)) then {
        waitUntil {ctrlCommitted (_disp displayCtrl _idc) || time > _t + 1.9};
    };
    _enabled = _x select 1;
    _visible = _x select 2;
    ctrlShow [_idc, (_visible > 0)];
    ctrlEnable [_idc, (_enabled != 0)];
} forEach _commitList;

// hide and disable unused buttons
// Note: BIS bug: you still need to disable hidden RscShortcutButton(s) because you can tab to them otherwise!
for "_i" from _idcIndex to (_flexiMenu_maxButtons - 1) do {
    _idc = _flexiMenu_baseIDC_button + _i;
    private _ctrl = _disp displayCtrl _idc;
    _ctrl ctrlShow false;
    _ctrl ctrlEnable false;
};
