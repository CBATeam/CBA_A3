// TODO: Find a way to reset the caption text after each button click (when _multiReselect is used), to allow caption to update with new status, etc.

// Perform menu action execution along with related menu behaviour changes.
//-----------------------------------------------------------------------------
#include "..\script_component.hpp"

private _arrayID = _this;
private _actionData = GVAR(menuActionData) select _arrayID;

_actionData params ["_action", "_subMenu", "_multiReselect"];
//-----------------------------------------------------------------------------
// indicates an option/button was selected, (to allow menu to close upon release of interact key), except if _multiReselect enabled.
if (_multiReselect == 0) then {
    GVAR(optionSelected) = true;
};

// determine optional sub menu source
private _subMenuSource = "";
private _params = ["?"];
private _useListBox = 0;
if (_subMenu isEqualType []) then {
    IfCountDefault(_subMenuSource,_subMenu,0,"");
    IfCountDefault(_params,_subMenu,1,[]);
    IfCountDefault(_useListBox,_subMenu,2,0);
} else { // else (assume?) it was a string
    _subMenuSource = _subMenu;
};

// close menu if needed
if (_useListBox == 0 && {_multiReselect == 0}) then { // if using embedded listBox && normal close upon selection
    closeDialog 0;

    // to prevent any successive user dialogs (activated via menu) from being inadvertantly closed by keyUp EH, set _display to null quickly here.
    uiNamespace setVariable [QGVAR(display), displayNull]; // manually set here, since onUnload takes too long to complete.
};
//-----------------------------------------------------------------------------
// execute main menu action (unless submenu)

private _actionParams = 1;
private _actionCode = _action;

if (_action isEqualType []) then {
    _actionParams = _action select 0;
    _actionCode = _action select 1;
};

if (_actionCode isEqualType {}) then {
    _actionParams call _actionCode
} else {
    if (_actionCode isEqualType "") then {
        if(_actionCode != "") then {
            _actionParams call compile _actionCode;
        };
    };
};

// show sub menu
if (_subMenuSource != "") then {
    // TODO: Find a way to combine the menu and list scripts together.
    #define PATHTO_SUB(var1,var2,var3,var4) MAINPREFIX\##var1\SUBPREFIX\##var2\##var3\##var4.sqf
    private _pathName = QUOTE(PATHTO_SUB(PREFIX,COMPONENT_F,flexiMenu,%1));
    _pathName = format [_pathName, if (_useListBox == 0) then {'fnc_menu'} else {'fnc_list'}];

    [GVAR(target), [[_subMenuSource, _params]]] call COMPILE_FILE2_SYS(_pathName);
    // TODO: DEBUG switch to recompile menus always?
    // compile preprocessFileLineNumbers _pathName;
};

false
