// Desc: "keyDown" EH for menu dialog
//-----------------------------------------------------------------------------
#include "\x\cba\addons\ui\script_component.hpp"

if (isDedicated || !dialog) exitWith {};

(_this select 0) params ["_control", "_dikCode", "_shiftKey", "_ctrlKey", "_altKey"];

private _handled = false;

// prevent unneeded cpu usage due to key down causing repeated event trigger
if (GVAR(holdKeyDown)) then {
    if (time - (GVAR(lastAccessCheck) select 0) < 0.220 && (GVAR(lastAccessCheck) select 1) == _dikCode) exitWith {_handled};
    GVAR(lastAccessCheck) = [time, _dikCode];
};

if (!GVAR(holdKeyDown) && {(_dikCode in (actionKeys "menuBack"))}) exitWith {
    closeDialog 0;
    true
};

private _menuDefs = (_this select 1) call FUNC(getMenuDef);
//-----------------------------------------------------------------------------
{ // forEach
    private _menuOption = [_menuDefs select 0, _x, true] call FUNC(getMenuOption); // get fast partial record

    //private _caption = _menuOption select _flexiMenu_menuDef_ID_caption;
    //private _action = _menuOption select _flexiMenu_menuDef_ID_action;
    //private _icon = _menuOption select _flexiMenu_menuDef_ID_icon;
    //private _tooltip = _menuOption select _flexiMenu_menuDef_ID_tooltip;
    //private _subMenu = _menuOption select _flexiMenu_menuDef_ID_subMenuSource;
    private _shortcut = _menuOption select _flexiMenu_menuDef_ID_shortcut;
    private _enabled = _menuOption select _flexiMenu_menuDef_ID_enabled;
    private _visible = _menuOption select _flexiMenu_menuDef_ID_visible;

    if (_dikCode == _shortcut && {_enabled != 0} && {_visible > 0}) exitWith {
        _menuOption = [_menuDefs select 0, _x, false] call FUNC(getMenuOption); // get complete same record
        _action = _menuOption select _flexiMenu_menuDef_ID_action;

        if (typeName _action == "CODE") then {call _action} else {call compile _action};
        _handled = true;
    };
} forEach (_menuDefs select 1);

_handled
