#include "\x\cba\addons\keybinding\script_component.hpp"

disableSerialization;

// Get button
_button = _this select 0;
// Get dialog
_display = uiNamespace getVariable "RscDisplayConfigure";

_combo = _display displayCtrl 208;
// Get the mod selected in the comobo
_comboMod = _combo lbData (lbCurSel _combo);

// Get listnbox
_lnb = _display displayCtrl 202;
// Get currently selected index
_lnbIndex = lnbCurSelRow _lnb;
// Get handler tracker index array for keys stored in listbox data string
_actionId = _lnb lnbData [_lnbIndex, 0];

_modId = (GVAR(handlers) select 0) find _comboMod;
if(_modId == -1) exitWith {};

_modRegistry = (GVAR(handlers) select 1) select _modId;

_actionEntryId = (_modRegistry select 0) find _actionId;
if(_actionEntryId == -1) exitWith {};
_actionEntry = (_modRegistry select 1) select _actionEntryId;

_hashDown = format["%1_%2_down", _comboMod, _actionId];
_entryIndex = (GVAR(defaultKeybinds) select 0) find _hashDown;
if(_entryIndex == -1) exitWith {};
_defaultEntry = (GVAR(defaultKeybinds) select 1) select _entryIndex;
                    

[
    _comboMod, 
    _actionId, 
    _actionEntry select 0, 
    _defaultEntry select 0,
    _defaultEntry select 1,
    [-1,[false,false,false]],
    _defaultEntry select 2,
    _defaultEntry select 3,
    true
] call cba_fnc_addKeybind;

// Clear any input actions.
GVAR(waitingForInput) = false;

// Update the main dialog.
[] call FUNC(updateGUI);
